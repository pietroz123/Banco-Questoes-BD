-- Neste arquivo está a trigger escolhida para o projeto final. Existem 4 triggers, porém apenas a primeira (atualiza_Pontuacao) foi escolhida para ser apresentada no projeto.

-- Bianca Gomes Rodrigues   743512
-- Pietro Zuntini Bonfim    743588


-- Para deletar:
-- DROP FUNCTION Nome_Funcao() CASCADE;

-- ================================================================= Criação da Trigger ==============================================================


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


-- ================================================================= Outras Triggers ==============================================================
-- As triggers abaixo são necessárias para o funcionamento correto do Banco de Questões


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