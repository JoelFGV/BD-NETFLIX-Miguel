from conexao_db import ConexaoDB
import os


class InterfaceAdmin:
    def __init__(self):
        self.db = ConexaoDB()

    def limpar_tela(self):
        os.system("cls" if os.name == "nt" else "clear")

    # INFORMACOES DO BANCO DE DADOS
    def listar_tabelas(self):
        return [
            row[0]
            for row in self.db.buscar_todos("""
                SELECT tablename
                FROM pg_tables
                WHERE schemaname = 'public'
                ORDER BY tablename
            """)
        ]

    def obter_colunas(self, tabela):
        return self.db.buscar_todos("""
            SELECT
                column_name,
                data_type
            FROM information_schema.columns
            WHERE table_name = %s
            ORDER BY ordinal_position
        """, (tabela.lower(),))

    def obter_pk(self, tabela):
        resultado = self.db.buscar_um("""
            SELECT kcu.column_name
            FROM information_schema.table_constraints tc
            JOIN information_schema.key_column_usage kcu
                ON tc.constraint_name = kcu.constraint_name
            WHERE tc.table_name = %s
            AND tc.constraint_type = 'PRIMARY KEY'
        """, (tabela.lower(),))

        return resultado[0] if resultado else None

    def obter_fks(self, tabela):
        linhas = self.db.buscar_todos("""
            SELECT
                kcu.column_name,
                ccu.table_name,
                ccu.column_name
            FROM information_schema.table_constraints tc
            JOIN information_schema.key_column_usage kcu
                ON tc.constraint_name = kcu.constraint_name
            JOIN information_schema.constraint_column_usage ccu
                ON ccu.constraint_name = tc.constraint_name
            WHERE tc.constraint_type = 'FOREIGN KEY'
            AND tc.table_name = %s
        """, (tabela.lower(),))

        return {
            coluna: (tabela_ref, coluna_ref)
            for coluna, tabela_ref, coluna_ref in linhas
        }

    # VERIFICACAO DE FK
    def validar_fk(self, tabela_ref, coluna_ref, valor):
        resultado = self.db.buscar_um(
            f"SELECT 1 FROM {tabela_ref} WHERE {coluna_ref} = %s",
            (valor,)
        )
        return resultado is not None

    # CRUD
    def listar_registros(self, tabela):
        registros = self.db.buscar_todos(
            f"SELECT * FROM {tabela}"
        )

        print("\n")
        print("=" * 100)
        print(f"TABELA: {tabela}")
        print("=" * 100)

        if not registros:
            print("Nenhum registro encontrado.")
            return

        for registro in registros:
            print(registro)

    def inserir_registro(self, tabela):
        colunas = self.obter_colunas(tabela)
        pk = self.obter_pk(tabela)
        fks = self.obter_fks(tabela)

        nomes = []
        valores = []

        print(f"\nInserindo em {tabela}")

        for coluna, tipo in colunas:

            # Ignora SERIAL
            if coluna == pk and "integer" in tipo:
                continue

            valor = input(f"{coluna}: ").strip()

            if valor == "":
                valor = None

            if coluna in fks and valor is not None:
                tabela_ref, coluna_ref = fks[coluna]

                if not self.validar_fk(
                    tabela_ref,
                    coluna_ref,
                    valor
                ):
                    print(
                        f"❌ FK inválida: "
                        f"{valor} não existe em "
                        f"{tabela_ref}.{coluna_ref}"
                    )
                    return

            nomes.append(coluna)
            valores.append(valor)

        placeholders = ", ".join(["%s"] * len(valores))

        sql = f"""
            INSERT INTO {tabela}
            ({", ".join(nomes)})
            VALUES
            ({placeholders})
        """

        if self.db.executar(sql, tuple(valores)):
            print("✅ Registro inserido!")

    def atualizar_registro(self, tabela):
        pk = self.obter_pk(tabela)

        if not pk:
            print("Tabela sem PK.")
            return

        id_registro = input(
            f"Digite o valor de {pk}: "
        ).strip()

        colunas = self.obter_colunas(tabela)
        fks = self.obter_fks(tabela)

        sets = []
        valores = []

        for coluna, tipo in colunas:

            if coluna == pk:
                continue

            valor = input(
                f"{coluna} (ENTER para ignorar): "
            ).strip()

            if valor == "":
                continue

            if coluna in fks:
                tabela_ref, coluna_ref = fks[coluna]

                if not self.validar_fk(
                    tabela_ref,
                    coluna_ref,
                    valor
                ):
                    print(
                        f"❌ FK inválida para {coluna}"
                    )
                    return

            sets.append(f"{coluna} = %s")
            valores.append(valor)

        if not sets:
            print("Nada para atualizar.")
            return

        valores.append(id_registro)

        sql = f"""
            UPDATE {tabela}
            SET {", ".join(sets)}
            WHERE {pk} = %s
        """

        if self.db.executar(sql, tuple(valores)):
            print("✅ Registro atualizado!")

    def remover_registro(self, tabela):
        pk = self.obter_pk(tabela)

        id_registro = input(
            f"Valor de {pk}: "
        ).strip()

        sql = f"""
            DELETE FROM {tabela}
            WHERE {pk} = %s
        """

        if self.db.executar(sql, (id_registro,)):
            print("✅ Registro removido!")

    # MENU
    def menu_tabela(self, tabela):
        while True:
            self.limpar_tela()

            print("=" * 60)
            print(f"ADMIN - {tabela}")
            print("=" * 60)

            print("1 - Listar")
            print("2 - Inserir")
            print("3 - Atualizar")
            print("4 - Remover")
            print("5 - Voltar")

            op = input("\nEscolha: ")

            if op == "1":
                self.listar_registros(tabela)

            elif op == "2":
                self.inserir_registro(tabela)

            elif op == "3":
                self.atualizar_registro(tabela)

            elif op == "4":
                self.remover_registro(tabela)

            elif op == "5":
                break

            else:
                print("Opção inválida.")

            input("\nENTER para continuar...")

    def executar(self):
        if not self.db.conectar():
            return

        while True:
            self.limpar_tela()

            tabelas = self.listar_tabelas()

            print("=" * 60)
            print("PAINEL ADMIN")
            print("=" * 60)

            for i, tabela in enumerate(tabelas, start=1):
                print(f"{i} - {tabela}")

            print("0 - Sair")

            try:
                op = int(input("\nEscolha: "))
            except ValueError:
                continue

            if op == 0:
                break

            if 1 <= op <= len(tabelas):
                self.menu_tabela(
                    tabelas[op - 1]
                )

        self.db.desconectar()


if __name__ == "__main__":
    InterfaceAdmin().executar()