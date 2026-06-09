CREATE TABLE Pais (
    IDPais SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Estado (
    IDEstado SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    IDPais INT NOT NULL,
    FOREIGN KEY (IDPais) REFERENCES Pais(IDPais)
);

CREATE TABLE Cidade (
    IDCidade SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    IDEstado INT NOT NULL,
    FOREIGN KEY (IDEstado) REFERENCES Estado(IDEstado)
);

CREATE TABLE Endereco (
    IDEndereco SERIAL PRIMARY KEY,
    IDCidade INT NOT NULL,
    FOREIGN KEY (IDCidade) REFERENCES Cidade(IDCidade)
);

CREATE TABLE Nacionalidade (
    IDNacionalidade SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Ator (
    IDAtor SERIAL PRIMARY KEY,
    Nome VARCHAR(150) NOT NULL,
    IDNacionalidade INT NOT NULL,
    FOREIGN KEY (IDNacionalidade) REFERENCES Nacionalidade(IDNacionalidade)
);

CREATE TABLE Conta (
    IDConta SERIAL PRIMARY KEY,
    Email VARCHAR(200) UNIQUE NOT NULL,
    Senha VARCHAR(250) NOT NULL,
    IDEndereco INT NOT NULL,
    FOREIGN KEY (IDEndereco) REFERENCES Endereco(IDEndereco)
);

CREATE TABLE Perfil (
    IDPerfil SERIAL PRIMARY KEY,
    Avatar VARCHAR(80),
    Nome VARCHAR(150) NOT NULL,
    IDConta INT NOT NULL,
    FOREIGN KEY (IDConta) REFERENCES Conta(IDConta)
);

CREATE TABLE Plano (
    IDPlano SERIAL PRIMARY KEY,
    Valor NUMERIC(10, 2) NOT NULL,
    DuracaoMeses INT NOT NULL,
    Nome VARCHAR(100) NOT NULL,
    Beneficios TEXT
);

CREATE TABLE Assinatura (
    IDAssinatura SERIAL PRIMARY KEY,
    DataInicio DATE NOT NULL,
    DataFim DATE,
    IDPlano INT NOT NULL,
    IDConta INT NOT NULL,
    FOREIGN KEY (IDPlano) REFERENCES Plano(IDPlano),
    FOREIGN KEY (IDConta) REFERENCES Conta(IDConta)
);

CREATE TABLE Obra (
    IDObra SERIAL PRIMARY KEY,
    Titulo VARCHAR(250) NOT NULL,
    Sinopse TEXT,
    ClassEtaria VARCHAR(10),
    TipoObra VARCHAR(50)
);

CREATE TABLE Filme (
    IDFilme SERIAL PRIMARY KEY,
    DuracaoMinutos INT NOT NULL,
    AnoLancamento INT,
    IDObra INT UNIQUE NOT NULL,
    FOREIGN KEY (IDObra) REFERENCES Obra(IDObra)
);

CREATE TABLE Serie (
    IDSerie SERIAL PRIMARY KEY,
    IDObra INT UNIQUE NOT NULL,
    FOREIGN KEY (IDObra) REFERENCES Obra(IDObra)
);

CREATE TABLE Temporada (
    IDTemporada SERIAL PRIMARY KEY,
    NumTemporada INT NOT NULL,
    AnoLancamento INT,
    IDSerie INT NOT NULL,
    FOREIGN KEY (IDSerie) REFERENCES Serie(IDSerie)
);

CREATE TABLE Episodio (
    IDEpisodio SERIAL PRIMARY KEY,
    Titulo VARCHAR(250) NOT NULL,
    DuracaoMinutos INT NOT NULL,
    Sinopse TEXT,
    IDTemporada INT NOT NULL,
    FOREIGN KEY (IDTemporada) REFERENCES Temporada(IDTemporada)
);

CREATE TABLE Genero (
    IDGenero SERIAL PRIMARY KEY,
    NomeGenero VARCHAR(50) NOT NULL
);

CREATE TABLE GeneroObra (
    IDGeneroObra SERIAL PRIMARY KEY,
    IDGenero INT NOT NULL,
    IDObra INT NOT NULL,
    FOREIGN KEY (IDGenero) REFERENCES Genero(IDGenero),
    FOREIGN KEY (IDObra) REFERENCES Obra(IDObra)
);

CREATE TABLE Elenco (
    IDElenco SERIAL PRIMARY KEY,
    IDObra INT NOT NULL,
    FOREIGN KEY (IDObra) REFERENCES Obra(IDObra)
);

CREATE TABLE AtorElenco (
    IDAtorElenco SERIAL PRIMARY KEY,
    NomePersonagem VARCHAR(150),
    IDElenco INT NOT NULL,
    IDAtor INT NOT NULL,
    FOREIGN KEY (IDElenco) REFERENCES Elenco(IDElenco),
    FOREIGN KEY (IDAtor) REFERENCES Ator(IDAtor)
);

CREATE TABLE Historico (
    IDHistorico SERIAL PRIMARY KEY,
    DataHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    IDPerfil INT NOT NULL,
    IDObra INT NOT NULL,
    FOREIGN KEY (IDPerfil) REFERENCES Perfil(IDPerfil),
    FOREIGN KEY (IDObra) REFERENCES Obra(IDObra)
);

CREATE TABLE Catalogo (
    IDCatalogo SERIAL PRIMARY KEY
);

CREATE TABLE ObraCatalogo (
    IDObraCatalogo SERIAL PRIMARY KEY,
    IDObra INT NOT NULL,
    IDCatalogo INT NOT NULL,
    FOREIGN KEY (IDObra) REFERENCES Obra(IDObra),
    FOREIGN KEY (IDCatalogo) REFERENCES Catalogo(IDCatalogo)
);

CREATE TABLE PerfilCatalogo (
    IDPerfilCatalogo SERIAL PRIMARY KEY,
    IDCatalogo INT NOT NULL,
    IDPerfil INT NOT NULL,
    FOREIGN KEY (IDCatalogo) REFERENCES Catalogo(IDCatalogo),
    FOREIGN KEY (IDPerfil) REFERENCES Perfil(IDPerfil)
);

CREATE INDEX idx_generoobra_idgenero ON GeneroObra(IDGenero);
