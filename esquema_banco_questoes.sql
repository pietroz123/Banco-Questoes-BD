-- Criação do banco
CREATE DATABASE banco_questoes;

-- Criação das Tabelas

-- Tabela Disicplinas
CREATE TABLE disciplina (
    Codigo_Disciplina int NOT NULL PRIMARY KEY,
    Nome_Disciplina varchar(255) NOT NULL,
    Nome_Professor varchar(255) NOT NULL,
    Departamento varchar(255) NOT NULL    
);


-- Tabela Aluno
CREATE TABLE aluno (
    RA_Aluno int NOT NULL PRIMARY KEY,
    Nome_Aluno varchar(255) NOT NULL,
    CPF varchar(14) NOT NULL UNIQUE,
    Email_Aluno varchar(255) NOT NULL UNIQUE, 
    Tel_Residencial varchar(14) NOT NULL,
    Tel_Celular varchar(15) NOT NULL,
    Codigo_Disciplina int NOT NULL REFERENCES disciplina(Codigo_Disciplina) -- Chave Estrangeira
);


-- Tabela Questão
CREATE TABLE questao (
    ID_Questao SERIAL NOT NULL PRIMARY KEY,
    Texto_Questao text NOT NULL,
    Peso int NOT NULL DEFAULT 1,
    Codigo_Disciplina int NOT NULL REFERENCES disciplina(Codigo_Disciplina) -- Chave Estrangeira
);


-- Enum para Sim e Não
CREATE TYPE Eh_Correta_t AS ENUM('Sim', 'Nao');

-- Tabela Alternativa
CREATE TABLE alternativa (
    ID_Alternativa SERIAL NOT NULL,
    Texto_Alternativa text NOT NULL,
    Eh_Correta Eh_Correta_t,
    ID_Questao int NOT NULL REFERENCES questao(ID_Questao),  -- Chave Estrangeira
    PRIMARY KEY (ID_Alternativa, ID_Questao)
);


-- Tabela Responde
CREATE TABLE responde (
    RA_Aluno int NOT NULL REFERENCES aluno(RA_Aluno),  -- Chave Estrangeira
    ID_Questao int NOT NULL REFERENCES questao(ID_Questao),  -- Chave Estrangeira
    Opcao Eh_Correta_t,
    PRIMARY KEY (RA_Aluno, ID_Questao)
);




-- Criação das Triggers

