-- Aluno com maior pontuação
SELECT Nome_Aluno, Pontuacao
FROM aluno
WHERE Pontuacao = (SELECT max(Pontuacao) FROM aluno)