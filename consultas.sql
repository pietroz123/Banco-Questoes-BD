-- Este arquivo contém as consultas do projeto Banco de Questões

-- Bianca Gomes Rodrigues   743512
-- Pietro Zuntini Bonfim    743588


--Consulta 1 - Buscar um determinado Aluno pertencente a uma determinada Disciplina

SELECT RA_Aluno, Nome_Aluno
FROM aluno
JOIN aluno_disciplina
ON aluno.RA_Aluno = aluno_disciplina.RA_Aluno
WHERE aluno.RA_Aluno = <RA_Aluno>
AND Codigo_Disciplina = <Codigo_Disciplina>;


-- Consulta 2 - Listar uma determinada Questão e suas respectivas Alternativas a partir de uma palavra chave

SELECT *
FROM questao
JOIN alternativa
ON questao.ID_Questao = alternativa.ID_Questao
WHERE Texto_Questao ILIKE '%<palavrachave>%';


-- Consulta 3 - Listar todas as Questões de uma determinada Disciplina

SELECT *
FROM questao
WHERE Codigo_Disciplina = <Codigo_Disciplina>;


-- Consulta 4 - Listar as Disciplinas a partir do código

SELECT *
FROM disciplina
WHERE Codigo_Disciplina = <Codigo_Disciplina>;


-- Consulta 5 - Calcula o número de Alunos inscritos por Disciplina

SELECT aluno_disciplina.Codigo_Disciplina AS Codigo_Disciplina,
       count(aluno_disciplina.RA_Aluno) AS Numero_Alunos
FROM aluno_disciplina
GROUP BY aluno_disciplina.Codigo_Disciplina;


-- Consulta 6 - Calcula o número de questões respondidas por um determinado Aluno

SELECT count(RA_Aluno) AS Numero_Questoes
FROM responde
WHERE RA_Aluno = <RA_Aluno>;


-- Consulta 7 - Calcula a pontuação do Aluno

SELECT count(RA_Aluno) AS Pontuacao
FROM responde
JOIN alternativa
ON responde.Opcao = alternativa.ID_Alternativa
WHERE RA_Aluno = <RA_Aluno> AND alternativa.Eh_Correta = 'Sim';


-- Consulta 8 - Calcula o número de Alunos

SELECT count(ID_Questao) AS Numero_Questoes
FROM questao
WHERE Codigo_Disciplina = <Codigo_Disciplina>;


-- Consulta 9 - Lista todas as Alternativas de uma determinada Questão

SELECT Texo_Questao, Texto_Alternativa, Eh_Correta
FROM questao
JOIN alternativa
ON questao.ID_Questao = alternativa.ID_Questao
WHERE questao.ID_Questao = <ID_Questao>;


-- Consulta 10 - Lista todos os Alunos de uma determinada Disciplina

SELECT aluno_disciplina.Codigo_Disciplina,
       aluno.RA_Aluno, aluno.Nome_Aluno
FROM aluno_disciplina
JOIN aluno
ON aluno_disciplina.RA_Aluno = aluno.RA_Aluno
WHERE Codigo_Disciplina = <Codigo_Disciplina>;


-- Consulta 11 - Calcula a média da pontuação dos Alunos por Disciplina

SELECT aluno_disciplina.codigo_disciplina,
       avg(pontuacao) AS Media_Pontuacao
FROM aluno_disciplina
JOIN aluno
ON aluno.RA_Aluno = aluno_disciplina.RA_Aluno
GROUP BY aluno_disciplina.Codigo_Disciplina
ORDER BY Media_Pontuacao


-- Consulta 12 - Calcula a média de Questões respondidas por Disciplina

SELECT codigo_disciplina,
       avg(total_respondidas) AS Media_Respondidas
FROM aluno_disciplina
JOIN aluno
ON aluno_disciplina.ra_aluno = aluno.ra_aluno
GROUP BY aluno_disciplina.codigo_disciplina
ORDER BY Media_Respondidas


-- Consulta 13 - Listar o número de questões respondidas por Aluno

SELECT RA_Aluno, count(RA_Aluno) AS Numero_Questoes
FROM responde
GROUP BY ra_aluno;