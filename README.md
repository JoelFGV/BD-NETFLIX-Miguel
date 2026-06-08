# 🎬 NETFLIX - SISTEMA DE GERENCIAMENTO

**Grupo:** Joel, Jordana e Miguel

---

### 🎮 Executar a Interface
python3 main.py

### 🚀 Carregar Dados Para o Teste de Performance (1.000.000 registros)
psql -f DML_obras_extras.sql

### 🔄 Resetar e Restaurar o Banco Original
dropdb netflix && createdb netflix && psql -d netflix -f backup.sql