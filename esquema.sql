-- Este arquivo contém o esquema do projeto Banco de Questões

-- Bianca Gomes Rodrigues   743512
-- Pietro Zuntini Bonfim    743588


--* Criação do banco
CREATE DATABASE banco_questoes;

--* Criação das Tabelas

--* Tabela Disicplinas
CREATE TABLE disciplina (
    Codigo_Disciplina int NOT NULL PRIMARY KEY,
    Nome_Disciplina varchar(255) NOT NULL,
    Nome_Professor varchar(255) NOT NULL,
    Departamento varchar(255) NOT NULL,
    Numero_Questoes int NOT NULL DEFAULT 0,
    Numero_Alunos int NOT NULL DEFAULT 0 CHECK (Numero_Alunos < 20)
);

--* Tabela Aluno
CREATE TABLE aluno (
    RA_Aluno int NOT NULL PRIMARY KEY,
    Nome_Aluno varchar(255) NOT NULL,
    CPF varchar(14) NOT NULL UNIQUE,
    Email_Aluno varchar(255) NOT NULL UNIQUE, 
    Tel_Residencial varchar(14),
    Tel_Celular varchar(15) NOT NULL,
    Total_Respondidas int NOT NULL DEFAULT 0,
    Pontuacao int NOT NULL DEFAULT 0
);

--* Tabela Aluno_Disciplina
CREATE TABLE aluno_disciplina (
    RA_Aluno int NOT NULL REFERENCES aluno(RA_Aluno) ON DELETE CASCADE ON UPDATE CASCADE, -- Chave Estrangeira / Caso o ALUNO seja deletado, então a linha que relaciona este ALUNO a  DISCIPLINA também deixa de existir, ou seja, o ALUNO não está mais inscrito na DISCIPLINA.
    Codigo_Disciplina int NOT NULL REFERENCES disciplina(Codigo_Disciplina) ON DELETE RESTRICT ON UPDATE CASCADE, -- Chave Estrangeira / Caso uma DISCIPLINA seja deletada, se um ALUNO estiver contido na disciplina, restrinja a deleção
    PRIMARY KEY (RA_Aluno, Codigo_Disciplina)
);

--* Tabela Questão
CREATE TABLE questao (
    ID_Questao SERIAL NOT NULL PRIMARY KEY,
    Texto_Questao text NOT NULL,
    Peso int NOT NULL DEFAULT 1 CHECK (Peso = 1),
    Codigo_Disciplina int NOT NULL REFERENCES disciplina(Codigo_Disciplina) ON DELETE RESTRICT ON UPDATE CASCADE -- Chave Estrangeira/ Caso a DISCIPLINA seja deletada, então todas QUESTÕES referentes também serão deletadas.
);

--* Enum para Sim e Não
CREATE TYPE Eh_Correta_t AS ENUM('Sim', 'Nao');

--* Tabela Alternativa
CREATE TABLE alternativa (
    ID_Alternativa SERIAL NOT NULL,
    ID_Questao int NOT NULL REFERENCES questao(ID_Questao) ON DELETE CASCADE ON UPDATE CASCADE,  -- Chave Estrangeira/ Sempre que uma QUESTÃO for deletada todas as ALTERNATIVAS referentes serão deletadas.
    Texto_Alternativa text NOT NULL,
    Eh_Correta Eh_Correta_t,
    PRIMARY KEY (ID_Alternativa, ID_Questao)
);

--* Tabela Responde
CREATE TABLE responde (
    RA_Aluno int NOT NULL REFERENCES aluno(RA_Aluno) ON DELETE CASCADE ON UPDATE CASCADE,  -- Chave Estrangeira
    ID_Questao int NOT NULL,
    Opcao int NOT NULL,
    PRIMARY KEY (RA_Aluno, ID_Questao, Opcao),
    FOREIGN KEY (ID_Questao, Opcao) REFERENCES alternativa (ID_Questao, ID_Alternativa) ON DELETE CASCADE ON UPDATE CASCADE --! Alterar no Latex
);