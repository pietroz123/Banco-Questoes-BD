

-- ============================================================ INSERÇÕES ============================================================

1. O sistema deve permitir o cadastro de um Aluno em uma Disciplina a partir
dos atributos do tipo-entidade Aluno
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular, Codigo_Disciplina) 
VALUES (X, 'X', 'XXX.XXX.XXX-XX', 'XXXX@XXX.XXX', '(XX) XXXX-XXXX', '(XX) XXXXX-XXXX', Y);

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

1. O sistema deve permitir a busca de um Aluno pertencente à uma Disciplina
    - Atributo(s) de visualização do resultado: RA, Nome_Aluno
    - Atributo(s) de busca (ou de condições/filtros): RA ou Nome_Aluno, CodigoDisciplina

-- Utilizando JOIN
SELECT * FROM aluno JOIN disciplina ON aluno.Codigo_Disciplina = disciplina.Codigo_Disciplina AND RA_Aluno = X AND disciplina.Codigo_Disciplina = Y;

-- Utilizando Produto Cartesiano
SELECT * FROM aluno, disciplina WHERE aluno.Codigo_Disciplina = disciplina.Codigo_Disciplina AND RA_Aluno = X AND disciplina.Codigo_Disciplina = Y;

2. O sistema deve permitir busca de Questões a partir de uma palavra chave
    - Atributo(s) de visualização do resultado: ID_Questão, Texto_Questão,
    CodigoDisciplina
    - Atributo(s) de busca (ou de condições/filtros): palavra chave (’%palavrachave%’)

-- Apenas as Questões
SELECT * FROM questao WHERE Texto_Questao ILIKE '%palavrachave%';

-- Questões COM Alternativas
SELECT * FROM questao JOIN alternativa ON questao.ID_Questao = alternativa.ID_Questao WHERE Texto_Questao ILIKE '%palavrachave%';

3. O sistema deve permitir busca de Questões de uma determinada Disciplina
    - Atributo(s) de visualização do resultado: ID_Questão, Texto_Questão
    - Atributo(s) de busca (ou de condições/filtros): CodigoDisciplina

SELECT * FROM questao WHERE Codigo_Disciplina = X;

4. O sistema deve permitir busca de uma Disciplina à partir de seu código
    - Atributo(s) de visualização do resultado: atributos da Disciplina encontrada
    - Atributo(s) de busca (ou de condições/filtros): CodigoDisciplina

SELECT * FROM disciplina WHERE Codigo_Disciplina = X;

5. O sistema deve permitir o cálculo do número de Alunos inscritos por Disciplina
    - Atributo(s) de visualização do resultado: número de alunos
    - Atributo(s) de cálculo: CodigoDisciplina

SELECT disciplina.Codigo_Disciplina AS Codigo_Diciplina, count(*) AS Numero_Alunos FROM aluno JOIN disciplina ON aluno.Codigo_Disciplina = disciplina.Codigo_Disciplina GROUP BY disciplina.Codigo_Disciplina;

6. O sistema deve permitir o cálculo do número de Questões respondidas por um
Aluno
    - Atributo(s) de visualização do resultado: número de questões respondidas
    - Atributo(s) de cálculo: obtido através do tipo-relacionamento ALUNO responde QUESTÃO

SELECT count(*) FROM responde WHERE RA_Aluno = X;   -- ! Verificar, na ferramenta diz 0 para qualquer RA, mesmo para os inexistentes
