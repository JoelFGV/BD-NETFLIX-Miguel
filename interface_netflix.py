from conexao_db import ConexaoDB
import re
import os
import time
from datetime import datetime, timedelta

class InterfaceNetflix:
    
    def __init__(self):
        self.db = ConexaoDB()
        self.conta_atual = None
        self.perfil_atual = None
    
    def limpar_tela(self):
        os.system('clear' if os.name == 'posix' else 'cls')
    
    def validar_email(self, email):
        padrao = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        return re.match(padrao, email) is not None
    
    def validar_senha(self, senha):
        return len(senha) >= 6
    
    def menu_principal(self):
        self.limpar_tela()
        print("=" * 60)
        print("🎬 BEM-VINDO AO NETFLIX - SISTEMA DE GERENCIAMENTO".center(60))
        print("=" * 60)
        print("\nEscolha uma opção:")
        print("1. Criar Conta")
        print("2. Entrar na Conta") 
        print("3. Sair")
        print("-" * 60)
        
        opcao = input("Digite sua escolha (1-3): ").strip()
        
        if opcao == "1":
            self.criar_conta()
        elif opcao == "2":
            self.entrar_conta() 
        elif opcao == "3":
            print("\n👋 Até logo!")
            return False
        else:
            print("❌ Opção inválida!")
            input("Pressione ENTER para continuar...")
            return True
        
        return True

    def entrar_conta(self):
        self.limpar_tela()
        print("=" * 60)
        print("🔐 ENTRAR NA CONTA".center(60))
        print("=" * 60)

        email = input("\n📧 Email: ").strip()
        senha = input("🔑 Senha: ").strip()

        resultado = self.db.buscar_um(
            "SELECT IDConta FROM Conta WHERE Email = %s AND Senha = %s",
            (email, senha)
        )

        if resultado:
            self.conta_atual = resultado[0]
            print("\n✅ Login realizado com sucesso!")
            input("Pressione ENTER para continuar...")
            self.selecionar_perfil()
        else:
            print("\n❌ Email ou senha incorretos!")
            input("Pressione ENTER para voltar ao menu inicial...")

    def selecionar_perfil(self):
        while True:
            self.limpar_tela()
            print("=" * 60)
            print("👥 QUEM ESTÁ ASSISTINDO?".center(60))
            print("=" * 60)

            perfis = self.db.buscar_todos(
                "SELECT IDPerfil, Nome, Avatar FROM Perfil WHERE IDConta = %s ORDER BY IDPerfil",
                (self.conta_atual,)
            )

            if not perfis:
                print("\n⚠️ Nenhum perfil encontrado nesta conta.")
                print("Vamos criar um agora!")
                input("Pressione ENTER para continuar...")
                self.criar_perfil()
                return

            print("\n📋 PERFIS DISPONÍVEIS:")
            print("-" * 60)
            for id_perfil, nome, avatar in perfis:
                print(f"  • ID: {id_perfil} | {nome} (Avatar: {avatar})")
            
            print("\n0. ➕ Criar Novo Perfil")
            print("S. Sair da Conta (Voltar)")
            print("-" * 60)

            escolha = input("\nDigite o ID do perfil, '0' para criar, ou 'S' para sair: ").strip().upper()

            if escolha == 'S':
                self.conta_atual = None 
                return
            elif escolha == '0':
                self.criar_perfil()
                return
            else:
                try:
                    id_escolhido = int(escolha)
                    
                    valido = any(p[0] == id_escolhido for p in perfis)
                    
                    if valido:
                        self.perfil_atual = id_escolhido
                        print(f"\n✅ Bem-vindo(a)!")
                        input("Pressione ENTER para entrar no catálogo...")
                        self.menu_pos_conta()
                        return 
                    else:
                        print("\n❌ ID de perfil inválido ou não pertence a esta conta!")
                        input("Pressione ENTER para tentar novamente...")
                except ValueError:
                    print("\n❌ Opção inválida! Digite um número de ID.")
                    input("Pressione ENTER para tentar novamente...")
    
    def criar_conta(self):
        self.limpar_tela()
        print("=" * 60)
        print("➕ CRIAR NOVA CONTA NETFLIX".center(60))
        print("=" * 60)
        
        while True:
            email = input("\n📧 Email: ").strip()
            if not self.validar_email(email):
                print("❌ Email inválido! Tente novamente.")
                continue
            
            resultado = self.db.buscar_um("SELECT IDConta FROM Conta WHERE Email = %s", (email,))
            if resultado:
                print("❌ Este email já está registrado!")
                continue
            break
        
        while True:
            senha = input("🔑 Senha (mínimo 6 caracteres): ").strip()
            if not self.validar_senha(senha):
                print("❌ Senha deve ter no mínimo 6 caracteres!")
                continue
            break
        
        self.listar_enderecos()
        while True:
            try:
                id_endereco = int(input("\n🏠 Digite o ID do endereço desejado: ").strip())
                resultado = self.db.buscar_um("SELECT IDEndereco FROM Endereco WHERE IDEndereco = %s", (id_endereco,))
                if not resultado:
                    print("❌ Endereço não encontrado!")
                    continue
                break
            except ValueError:
                print("❌ ID inválido!")
        
        self.listar_planos()
        while True:
            try:
                id_plano = int(input("\n💳 Digite o ID do plano desejado: ").strip())
                resultado = self.db.buscar_um("SELECT IDPlano FROM Plano WHERE IDPlano = %s", (id_plano,))
                if not resultado:
                    print("❌ Plano não encontrado!")
                    continue
                break
            except ValueError:
                print("❌ ID inválido!")
        
        try:
            self.db.executar(
                "INSERT INTO Conta (Email, Senha, IDEndereco) VALUES (%s, %s, %s)",
                (email, senha, id_endereco)
            )
            self.conta_atual = self.db.obter_ultimo_id()
            
            data_inicio = datetime.now().date()
            data_fim = data_inicio + timedelta(days=30)
            
            self.db.executar(
                "INSERT INTO Assinatura (DataInicio, DataFim, IDConta, IDPlano) VALUES (%s, %s, %s, %s)",
                (data_inicio, data_fim, self.conta_atual, id_plano)
            )
            
            print(f"\n✅ Conta criada com sucesso! ID: {self.conta_atual}")
            input("Pressione ENTER para continuar...")
            
            self.criar_perfil()
        
        except Exception as e:
            print(f"❌ Erro ao criar conta: {e}")
            input("Pressione ENTER para continuar...")
    
    def listar_enderecos(self):
        print("\n🏠 ENDEREÇOS DISPONÍVEIS:")
        print("-" * 60)
        enderecos = self.db.buscar_todos(
            """SELECT e.IDEndereco, p.Nome, est.Nome, c.Nome 
               FROM Endereco e
               INNER JOIN Cidade c ON e.IDCidade = c.IDCidade
               INNER JOIN Estado est ON c.IDEstado = est.IDEstado
               INNER JOIN Pais p ON est.IDPais = p.IDPais
               ORDER BY e.IDEndereco"""
        )
        
        if not enderecos:
            print("❌ Nenhum endereço disponível!")
            return
        
        for id_end, pais, estado, cidade in enderecos:
            print(f"ID: {id_end} | {cidade}, {estado} - {pais}")
    
    def listar_planos(self):
        print("\n💳 PLANOS DISPONÍVEIS:")
        print("-" * 60)
        planos = self.db.buscar_todos("SELECT IDPlano, Nome, Valor, Beneficios FROM Plano ORDER BY IDPlano")
        
        if not planos:
            print("❌ Nenhum plano disponível!")
            return
        
        for id_plano, nome, valor, beneficios in planos:
            print(f"\nID: {id_plano} | {nome}")
            print(f"   R$ {valor:.2f}/mês")
            print(f"   {beneficios}")
    
    def criar_perfil(self):
        while True:
            self.limpar_tela()
            print("=" * 60)
            print("➕ CRIAR NOVO PERFIL".center(60))
            print("=" * 60)
            
            nome = input("\n👤 Nome do perfil: ").strip()
            if not nome:
                print("❌ Nome não pode estar vazio!")
                input("Pressione ENTER para continuar...")
                continue
            
            self.listar_avatares()
            avatar = input("\n🎨 Digite o código do avatar desejado: ").strip()
            
            try:
                self.db.executar(
                    "INSERT INTO Perfil (Nome, Avatar, IDConta) VALUES (%s, %s, %s)",
                    (nome, avatar, self.conta_atual)
                )
                self.perfil_atual = self.db.obter_ultimo_id()
                print(f"\n✅ Perfil '{nome}' criado com sucesso!")
                input("Pressione ENTER para continuar...")
                
                self.menu_pos_conta()
                break
            
            except Exception as e:
                print(f"❌ Erro ao criar perfil: {e}")
                input("Pressione ENTER para continuar...")
    
    def listar_avatares(self):
        print("\n🎨 AVATARES DISPONÍVEIS:")
        print("-" * 60)
        avatares = [
            "Red_3", "Cavaleiro_2", "Dragao_5", "Princesa_1", 
            "Green_4", "Divertidamente_3", "Marvel_2"
        ]
        for avatar in avatares:
            print(f"  • {avatar}")
    
    def menu_pos_conta(self):
        while True:
            self.limpar_tela()
            print("=" * 60)
            print(f"🎬 MENU PRINCIPAL - Perfil: {self.perfil_atual}".center(60))
            print("=" * 60)
            print("\n1. Ver Filmes e Séries")
            print("2. Ver Histórico do Perfil")
            print("3. Editar Perfil")
            print("4. Editar Conta")
            print("5. Deletar Perfil")
            print("6. Deletar Conta")
            print("7. Sair")
            print("-" * 60)
            
            opcao = input("Digite sua escolha (1-7): ").strip()
            
            if opcao == "1":
                self.visualizar_obras()
            elif opcao == "2":
                self.ver_historico()
            elif opcao == "3":
                self.editar_perfil()
            elif opcao == "4":
                self.editar_conta()
            elif opcao == "5":
                if self.deletar_perfil():
                    break
            elif opcao == "6":
                if self.deletar_conta():
                    return False
            elif opcao == "7":
                print("\n👋 Até logo!")
                return False
            else:
                print("❌ Opção inválida!")
                input("Pressione ENTER para continuar...")
                
    def ver_historico(self):
        self.limpar_tela()
        print("=" * 60)
        print("📜 HISTÓRICO DO PERFIL".center(60))
        print("=" * 60)
        
        query = """
            SELECT h.DataHora, o.Titulo, o.TipoObra 
            FROM Historico h 
            INNER JOIN Obra o ON h.IDObra = o.IDObra 
            WHERE h.IDPerfil = %s 
            ORDER BY h.DataHora DESC
        """
        historico = self.db.buscar_todos(query, (self.perfil_atual,))
        
        if not historico:
            print("\n❌ Nenhum histórico encontrado.")
        else:
            for data_hora, titulo, tipo in historico:
                print(f"[{data_hora.strftime('%d/%m/%Y %H:%M:%S')}] {titulo} ({tipo})")
                
        input("\nPressione ENTER para continuar...")
    
    def editar_perfil(self):
        self.limpar_tela()
        print("=" * 60)
        print("✏️  EDITAR PERFIL".center(60))
        print("=" * 60)
        
        perfil = self.db.buscar_um(
            "SELECT Nome, Avatar FROM Perfil WHERE IDPerfil = %s",
            (self.perfil_atual,)
        )
        
        if not perfil:
            print("❌ Perfil não encontrado!")
            input("Pressione ENTER para continuar...")
            return
        
        nome_atual, avatar_atual = perfil
        
        print(f"\n📋 Dados Atuais:")
        print(f"   Nome: {nome_atual}")
        print(f"   Avatar: {avatar_atual}")
        
        print("\n1. Alterar Nome")
        print("2. Alterar Avatar")
        print("3. Cancelar")
        print("-" * 60)
        
        opcao = input("Escolha uma opção (1-3): ").strip()
        
        if opcao == "1":
            novo_nome = input("\n👤 Novo nome: ").strip()
            if novo_nome:
                self.db.executar(
                    "UPDATE Perfil SET Nome = %s WHERE IDPerfil = %s",
                    (novo_nome, self.perfil_atual)
                )
                print(f"✅ Nome updated para: {novo_nome}")
            else:
                print("❌ Nome não pode estar vazio!")
        
        elif opcao == "2":
            self.listar_avatares()
            novo_avatar = input("\n🎨 Novo avatar: ").strip()
            if novo_avatar:
                self.db.executar(
                    "UPDATE Perfil SET Avatar = %s WHERE IDPerfil = %s",
                    (novo_avatar, self.perfil_atual)
                )
                print(f"✅ Avatar updated para: {novo_avatar}")
            else:
                print("❌ Avatar não pode estar vazio!")
        
        elif opcao == "3":
            print("❌ Operação cancelada!")
        
        else:
            print("❌ Opção inválida!")
        
        input("\nPressione ENTER para continuar...")
    
    def editar_conta(self):
        self.limpar_tela()
        print("=" * 60)
        print("✏️  EDITAR CONTA".center(60))
        print("=" * 60)
        
        conta = self.db.buscar_um(
            "SELECT Email, IDEndereco FROM Conta WHERE IDConta = %s",
            (self.conta_atual,)
        )
        
        if not conta:
            print("❌ Conta não encontrada!")
            input("Pressione ENTER para continuar...")
            return
        
        email_atual, id_endereco_atual = conta
        
        endereco_atual = self.db.buscar_um(
            """SELECT c.Nome, est.Nome 
               FROM Endereco e
               INNER JOIN Cidade c ON e.IDCidade = c.IDCidade
               INNER JOIN Estado est ON c.IDEstado = est.IDEstado
               WHERE e.IDEndereco = %s""",
            (id_endereco_atual,)
        )
        
        print(f"\n📋 Dados Atuais:")
        print(f"   Email: {email_atual}")
        if endereco_atual:
            cidade, estado = endereco_atual
            print(f"   Endereço: {cidade}, {estado}")
        
        print("\n1. Alterar Email")
        print("2. Alterar Senha")
        print("3. Alterar Endereço")
        print("4. Alterar Plano")
        print("5. Cancelar")
        print("-" * 60)
        
        opcao = input("Escolha uma opção (1-5): ").strip()
        
        if opcao == "1":
            while True:
                novo_email = input("\n📧 Novo email: ").strip()
                if not self.validar_email(novo_email):
                    print("❌ Email inválido!")
                    continue
                
                resultado = self.db.buscar_um(
                    "SELECT IDConta FROM Conta WHERE Email = %s AND IDConta != %s",
                    (novo_email, self.conta_atual)
                )
                if resultado:
                    print("❌ Este email já está registrado!")
                    continue
                
                self.db.executar(
                    "UPDATE Conta SET Email = %s WHERE IDConta = %s",
                    (novo_email, self.conta_atual)
                )
                print(f"✅ Email updated para: {novo_email}")
                break
        
        elif opcao == "2":
            while True:
                nova_senha = input("\n🔑 Nova senha (mínimo 6 caracteres): ").strip()
                if not self.validar_senha(nova_senha):
                    print("❌ Senha deve ter no mínimo 6 caracteres!")
                    continue
                
                confirmacao = input("🔑 Confirme a nova senha: ").strip()
                if nova_senha != confirmacao:
                    print("❌ As senhas não conferem!")
                    continue
                
                self.db.executar(
                    "UPDATE Conta SET Senha = %s WHERE IDConta = %s",
                    (nova_senha, self.conta_atual)
                )
                print("✅ Senha updated com sucesso!")
                break
        
        elif opcao == "3":
            self.listar_enderecos()
            while True:
                try:
                    novo_id_endereco = int(input("\n🏠 Digite o ID do novo endereço: ").strip())
                    resultado = self.db.buscar_um(
                        "SELECT IDEndereco FROM Endereco WHERE IDEndereco = %s",
                        (novo_id_endereco,)
                    )
                    if not resultado:
                        print("❌ Endereço não encontrado!")
                        continue
                    
                    self.db.executar(
                        "UPDATE Conta SET IDEndereco = %s WHERE IDConta = %s",
                        (novo_id_endereco, self.conta_atual)
                    )
                    print("✅ Endereço updated com sucesso!")
                    break
                except ValueError:
                    print("❌ ID inválido!")
        
        elif opcao == "4":
            self.listar_planos()
            while True:
                try:
                    novo_id_plano = int(input("\n💳 Digite o ID do novo plano: ").strip())
                    resultado = self.db.buscar_um(
                        "SELECT IDPlano FROM Plano WHERE IDPlano = %s",
                        (novo_id_plano,)
                    )
                    if not resultado:
                        print("❌ Plano não encontrado!")
                        continue
                    
                    assinatura = self.db.buscar_um(
                        "SELECT IDAssinatura FROM Assinatura WHERE IDConta = %s",
                        (self.conta_atual,)
                    )
                    
                    if assinatura:
                        id_assinatura = assinatura[0]
                        self.db.executar(
                            "UPDATE Assinatura SET IDPlano = %s WHERE IDAssinatura = %s",
                            (novo_id_plano, id_assinatura)
                        )
                    else:
                        data_inicio = datetime.now().date()
                        data_fim = data_inicio + timedelta(days=30)
                        self.db.executar(
                            "INSERT INTO Assinatura (DataInicio, DataFim, IDConta, IDPlano) VALUES (%s, %s, %s, %s)",
                            (data_inicio, data_fim, self.conta_atual, novo_id_plano)
                        )
                    
                    print("✅ Plano updated com sucesso!")
                    break
                except ValueError:
                    print("❌ ID inválido!")
        
        elif opcao == "5":
            print("❌ Operação cancelada!")
        
        else:
            print("❌ Opção inválida!")
        
        input("\nPressione ENTER para continuar...")
    
    def visualizar_obras(self):
        self.limpar_tela()
        print("=" * 60)
        print("🎬 CATÁLOGO DE FILMES E SÉRIES".center(60))
        print("=" * 60)
        
        print("\n📂 GÊNEROS DISPONÍVEIS:")
        print("-" * 60)
        generos = self.db.buscar_todos("SELECT IDGenero, NomeGenero FROM Genero ORDER BY IDGenero")
        
        for id_genero, nome_genero in generos:
            print(f"{id_genero}. {nome_genero}")
        
        try:
            id_genero = int(input("\nDigite o ID do gênero desejado: ").strip())
            
            query = """
                SELECT DISTINCT o.IDObra, o.Titulo, o.ClassEtaria, o.TipoObra
                FROM Obra o
                INNER JOIN GeneroObra go ON o.IDObra = go.IDObra
                WHERE go.IDGenero = %s
                ORDER BY o.Titulo
            """
            obras = self.db.buscar_todos(query, (id_genero,))
            
            if not obras:
                print("❌ Nenhuma obra encontrada neste gênero!")
                input("Pressione ENTER para continuar...")
                return
            
            print("\n🎬 OBRAS ENCONTRADAS:")
            print("-" * 60)
            for id_obra, titulo, classe_etaria, tipo_obra in obras:
                print(f"\n📽️  ID {id_obra}: {titulo}")
                print(f"   Tipo: {tipo_obra} | Classificação: {classe_etaria}+")
                self.mostrar_detalhes_obra(id_obra, tipo_obra)
            
            print("\n" + "-" * 60)
            print("1. Assistir uma Obra")
            print("2. Ver Temporadas e Episódios de uma Série")
            print("3. Voltar")
            
            opcao = input("\nEscolha uma opção (1-3): ").strip()
            
            if opcao == "1":
                self.assistir_obra()
            elif opcao == "2":
                self.ver_episodios()
            elif opcao == "3":
                return
            else:
                print("❌ Opção inválida!")
                input("Pressione ENTER para continuar...")
        
        except ValueError:
            print("❌ ID inválido!")
            input("Pressione ENTER para continuar...")
            
    def assistir_obra(self):
        try:
            id_obra = int(input("\nDigite o ID da obra que deseja assistir: ").strip())
            obra = self.db.buscar_um("SELECT Titulo FROM Obra WHERE IDObra = %s", (id_obra,))
            
            if obra:
                self.db.executar(
                    "INSERT INTO Historico (IDPerfil, IDObra) VALUES (%s, %s)",
                    (self.perfil_atual, id_obra)
                )
                print(f"\n✅ Você está assistindo '{obra[0]}'. Obra adicionada ao histórico!")
            else:
                print("\n❌ Obra não encontrada.")
        except ValueError:
            print("\n❌ ID inválido!")
            
        input("\nPressione ENTER para continuar...")

    def ver_episodios(self):
        try:
            id_obra = int(input("\nDigite o ID da série para ver os episódios: ").strip())
            
            obra = self.db.buscar_um("SELECT TipoObra FROM Obra WHERE IDObra = %s", (id_obra,))
            if not obra or obra[0] != "Série":
                print("\n❌ ID inválido ou a obra selecionada não é uma série.")
                input("Pressione ENTER para continuar...")
                return

            query = """
                SELECT t.NumTemporada, e.IDEpisodio, e.Titulo, e.DuracaoMinutos 
                FROM Serie s 
                INNER JOIN Temporada t ON s.IDSerie = t.IDSerie 
                INNER JOIN Episodio e ON t.IDTemporada = e.IDTemporada 
                WHERE s.IDObra = %s 
                ORDER BY t.NumTemporada, e.IDEpisodio
            """
            episodios = self.db.buscar_todos(query, (id_obra,))
            
            if episodios:
                print("\n📺 TEMPORADAS E EPISÓDIOS:")
                print("-" * 60)
                temporada_atual = None
                for num_temp, id_ep, titulo, duracao in episodios:
                    if temporada_atual != num_temp:
                        print(f"\n▶️  Temporada {num_temp}")
                        temporada_atual = num_temp
                    print(f"   Episódio {id_ep}: {titulo} ({duracao} min)")
            else:
                print("\n❌ Nenhum episódio encontrado para esta série.")
        except ValueError:
            print("\n❌ ID inválido!")
            
        input("\nPressione ENTER para continuar...")
    
    def mostrar_detalhes_obra(self, id_obra, tipo_obra):
        if tipo_obra == "Filme":
            filme = self.db.buscar_um(
                "SELECT DuracaoMinutos, AnoLancamento FROM Filme WHERE IDObra = %s",
                (id_obra,)
            )
            if filme:
                duracao, ano = filme
                print(f"   ⏱️  Duração: {duracao} minutos | Lançamento: {ano}")
        
        elif tipo_obra == "Série":
            temporadas = self.db.buscar_todos(
                "SELECT COUNT(IDTemporada) FROM Temporada t INNER JOIN Serie s ON t.IDSerie = s.IDSerie WHERE s.IDObra = %s",
                (id_obra,)
            )
            if temporadas:
                qtd_temp = temporadas[0][0]
                print(f"   📺 Temporadas: {qtd_temp}")
    
    def deletar_perfil(self):
        self.limpar_tela()
        print("=" * 60)
        print("❌ DELETAR PERFIL".center(60))
        print("=" * 60)
        
        print(f"\n⚠️  Tem certeza que deseja deletar o perfil ID {self.perfil_atual}?")
        confirmacao = input("Digite 'SIM' para confirmar: ").strip().upper()
        
        if confirmacao == "SIM":
            try:
                self.db.executar(
                    "DELETE FROM Historico WHERE IDPerfil = %s",
                    (self.perfil_atual,)
                )
                self.db.executar(
                    "DELETE FROM PerfilCatalogo WHERE IDPerfil = %s",
                    (self.perfil_atual,)
                )
                self.db.executar(
                    "DELETE FROM Perfil WHERE IDPerfil = %s",
                    (self.perfil_atual,)
                )
                print("✅ Perfil deletado com sucesso!")
                
                perfis = self.db.buscar_todos(
                    "SELECT IDPerfil, Nome FROM Perfil WHERE IDConta = %s",
                    (self.conta_atual,)
                )
                
                if perfis:
                    print("\n📋 PERFIS RESTANTES:")
                    for id_perfil, nome in perfis:
                        print(f"  • ID: {id_perfil} | Nome: {nome}")
                    
                    try:
                        novo_id = int(input("\nEscolha outro perfil (ID): ").strip())
                        resultado = self.db.buscar_um(
                            "SELECT IDPerfil FROM Perfil WHERE IDPerfil = %s AND IDConta = %s",
                            (novo_id, self.conta_atual)
                        )
                        if resultado:
                            self.perfil_atual = novo_id
                            return False
                        else:
                            print("❌ Perfil inválido!")
                    except ValueError:
                        print("❌ ID inválido!")
                    
                    return False
                else:
                    print("❌ Nenhum perfil restante! Voltando ao menu principal...")
                    return True
            
            except Exception as e:
                print(f"❌ Erro ao deletar perfil: {e}")
                input("Pressione ENTER para continuar...")
                return False
        else:
            print("❌ Operação cancelada!")
            input("Pressione ENTER para continuar...")
            return False
    
    def deletar_conta(self):
        self.limpar_tela()
        print("=" * 60)
        print("❌ DELETAR CONTA".center(60))
        print("=" * 60)
        
        print(f"\n⚠️  ⚠️  ⚠️  ATENÇÃO! Isto deletará a conta e TODOS os perfis!")
        print(f"ID da Conta: {self.conta_atual}")
        confirmacao = input("\nDigite 'DELETAR TUDO' para confirmar: ").strip().upper()
        
        if confirmacao == "DELETAR TUDO":
            try:
                perfis = self.db.buscar_todos("SELECT IDPerfil FROM Perfil WHERE IDConta = %s", (self.conta_atual,))
                for (id_perfil,) in perfis:
                    self.db.executar("DELETE FROM Historico WHERE IDPerfil = %s", (id_perfil,))
                    self.db.executar("DELETE FROM PerfilCatalogo WHERE IDPerfil = %s", (id_perfil,))

                self.db.executar(
                    "DELETE FROM Perfil WHERE IDConta = %s",
                    (self.conta_atual,)
                )
                
                self.db.executar(
                    "DELETE FROM Assinatura WHERE IDConta = %s",
                    (self.conta_atual,)
                )
                
                self.db.executar(
                    "DELETE FROM Conta WHERE IDConta = %s",
                    (self.conta_atual,)
                )
                
                print("✅ Conta deletada com sucesso!")
                print("\n👋 Voltando ao menu principal...")
                input("Pressione ENTER para continuar...")
                
                return True
            
            except Exception as e:
                print(f"❌ Erro ao deletar conta: {e}")
                input("Pressione ENTER para continuar...")
                return False
        else:
            print("❌ Operação cancelada!")
            input("Pressione ENTER para continuar...")
            return False
    
    def executar(self):
        if not self.db.conectar():
            print("❌ Não foi possível conectar ao banco de dados!")
            return
        
        try:
            continuar = True
            while continuar:
                continuar = self.menu_principal()
        finally:
            self.db.desconectar()

def main():
    interface = InterfaceNetflix()
    interface.executar()

if __name__ == "__main__":
    main()
