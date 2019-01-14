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
    Tel_Residencial varchar(13) NOT NULL,
    Tel_Celular varchar(14) NOT NULL,
    Codigo_Disciplina int NOT NULL  -- Chave Estrangeira
);

-- aluno.Codigo_Disciplina referencia disciplina.Codigo_Disciplina
ALTER TABLE aluno ADD FOREIGN KEY (Codigo_Disciplina) REFERENCES disciplina(Codigo_Disciplina); 


-- Tabela Questão
CREATE TABLE questao (
    ID_Questao SERIAL NOT NULL PRIMARY KEY,
    Texto_Questao text NOT NULL,
    Peso int NOT NULL DEFAULT 1
);


-- Enum para Sim e Não
CREATE TYPE Eh_Correta_t AS ENUM('Sim', 'Nao');

-- Tabela Alternativa
CREATE TABLE alternativa (
    ID_Alternativa SERIAL NOT NULL,
    Texto_Alternativa text NOT NULL,
    Eh_Correta Eh_Correta_t,
    ID_Questao int NOT NULL,  -- Chave Estrangeira
    PRIMARY KEY (ID_Alternativa, ID_Questao)
);

-- alternativa.ID_Questao referencia questao.ID_Questao
ALTER TABLE alternativa ADD FOREIGN KEY (ID_Questao) REFERENCES questao(ID_Questao); 


-- Tabela Responde
CREATE TABLE responde (
    RA_Aluno int NOT NULL,  -- Chave Estrangeira
    ID_Questao int NOT NULL,  -- Chave Estrangeira
    Opcao Eh_Correta_t,
    PRIMARY KEY (RA_Aluno, ID_Questao)
);

-- responde.RA_Aluno referencia aluno.RA
ALTER TABLE responde ADD FOREIGN KEY (RA_Aluno) REFERENCES aluno(RA_Aluno); 
-- responde.ID_Questao referencia questao.ID_Questao
ALTER TABLE responde ADD FOREIGN KEY (ID_Questao) REFERENCES questao(ID_Questao); 





-- Criação das Triggers

