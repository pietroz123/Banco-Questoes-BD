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
    FOREIGN KEY (ID_Questao, Opcao) REFERENCES alternativa (ID_Questao, ID_Alternativa)
);

-- ================================================================= Criação das Triggers ==============================================================

-- Para deletar:
-- DROP FUNCTION Nome_Funcao() CASCADE;

--* Atualiza o número de ALUNOS a cada ALUNO inserido ou deletado da tabela ALUNO_DISCIPLINA.
CREATE FUNCTION atualizar_nAlunos() RETURNS TRIGGER AS $atualizar_nAlunos$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            UPDATE disciplina SET Numero_Alunos = (Numero_Alunos + 1) WHERE disciplina.Codigo_Disciplina = NEW.Codigo_Disciplina; 
			RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            UPDATE disciplina SET Numero_Alunos = (Numero_Alunos - 1) WHERE disciplina.Codigo_Disciplina = OLD.Codigo_Disciplina; 
			RETURN OLD;
        END IF;
    END;
$atualizar_nAlunos$ LANGUAGE plpgsql;

-- Cria a trigger
CREATE TRIGGER atualizar_nAlunos 
AFTER DELETE OR INSERT 
ON aluno_disciplina
FOR EACH ROW EXECUTE PROCEDURE atualizar_nAlunos();



--* Atualiza o número de QUESTOES a cada QUESTAO inserida ou deletada da tabela QUESTAO.
CREATE FUNCTION atualizar_nQuestoes() RETURNS TRIGGER AS $atualizar_nQuestoes$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            UPDATE disciplina SET Numero_Questoes = (Numero_Questoes + 1) WHERE disciplina.Codigo_Disciplina = NEW.Codigo_Disciplina; 
			RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            UPDATE disciplina SET Numero_Questoes = (Numero_Questoes - 1) WHERE disciplina.Codigo_Disciplina = OLD.Codigo_Disciplina; 
			RETURN OLD;
        END IF;
    END;
$atualizar_nQuestoes$ LANGUAGE plpgsql;

-- Cria a trigger
CREATE TRIGGER atualizar_nQuestoes 
AFTER DELETE OR INSERT 
ON questao
FOR EACH ROW EXECUTE PROCEDURE atualizar_nQuestoes();


--* Atualiza o número de QUESTOES respondidas pelo ALUNO a cada questão respondida.
CREATE FUNCTION atualizar_totalRespondidas() RETURNS TRIGGER AS $atualizar_totalRespondidas$
    BEGIN
        IF (TG_OP = 'INSERT') THEN
            UPDATE aluno SET Total_Respondidas = (Total_Respondidas + 1) WHERE aluno.RA_Aluno = NEW.RA_Aluno; 
			RETURN NEW;
        ELSIF (TG_OP = 'DELETE') THEN
            UPDATE aluno SET Total_Respondidas = (Total_Respondidas - 1) WHERE aluno.RA_Aluno = OLD.RA_Aluno; 
			RETURN OLD;
        END IF;
    END;
$atualizar_totalRespondidas$ LANGUAGE plpgsql;

-- Cria a trigger
CREATE TRIGGER atualizar_totalRespondidas 
AFTER DELETE OR INSERT 
ON responde
FOR EACH ROW EXECUTE PROCEDURE atualizar_totalRespondidas();



--* Atualiza a pontuacao do ALUNO.
CREATE FUNCTION atualizar_pontuacao() RETURNS TRIGGER AS $atualizar_pontuacao$
    DECLARE
        resultado Eh_Correta_t;
    BEGIN
        SELECT Eh_Correta INTO resultado FROM alternativa WHERE ID_Alternativa = NEW.Opcao; 
        IF (resultado = 'Sim') THEN
            UPDATE aluno SET Pontuacao = (Pontuacao + 1) WHERE aluno.RA_Aluno = NEW.RA_Aluno; 
			RETURN NEW;
        END IF;
    
        RETURN NULL;
    END;
$atualizar_pontuacao$ LANGUAGE plpgsql;

-- Cria a trigger
CREATE TRIGGER atualizar_pontuacao 
AFTER INSERT 
ON responde
FOR EACH ROW EXECUTE PROCEDURE atualizar_pontuacao();