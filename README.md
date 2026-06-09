# 🎬 NETFLIX

**Grupo:** Joel, Jordana e Miguel

---

### 🎮 Executar a Interface
```bash
python3 main.py
```

### 🚀 Carregar Dados Para o Teste de Performance (1.000.000 registros)
```bash
psql -f DML_obras_extras.sql
```

### 🔄 Restaurar o Banco de Dados Original
```bash
dropdb netflix && createdb netflix && psql -d netflix -f backup.sql
```
