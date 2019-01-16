

-- ============================================================ INSERÇÕES ============================================================

1. O sistema deve permitir o cadastro de um Aluno em uma Disciplina a partir
dos atributos do tipo-entidade Aluno
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular, Codigo_Disciplina) 
VALUES (X, 'X', 'XXX.XXX.XXX-XX', 'XXXX@XXX.XXX', '(XX) XXXX-XXXX', '(XX) XXXXX-XXXX', X);

2. O sistema deve permitir o cadastro de uma Disciplina a partir dos atributos
do tipo-entidade Disciplina
INSERT INTO disciplina (codigo_disciplina, nome_disciplina, nome_professor, departamento)
VALUES (X, 'X', 'X', 'X');

3. O sistema deve permitir o cadastro de uma Questão de uma determinada
Disciplina a partir dos atributos do tipo-entidade Questão
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('X', X);

4. O sistema deve permitir a adição de Alternativas de uma determinada Questão
a partir dos atributos do tipo-entidade Alternativa
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('X', 'Nao', Y);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('X', 'Nao', Y);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('X', 'Nao', Y);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('X', 'Sim', Y);

-- ============================================================ BUSCAS ===============================================================
