

-- ============================================================ INSERÇÕES ============================================================

1. O sistema deve permitir o cadastro de um Aluno em uma Disciplina a partir
dos atributos do tipo-entidade Aluno
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular, Codigo_Disciplina) 
VALUES (<RA_Aluno>, '<Nome_Aluno>', '<CPF_Aluno>', '<Email_Aluno>', '<Tel_Residencial>', '<Tel_Celular>', <Codigo_Disciplina>);


2. O sistema deve permitir o cadastro de uma Disciplina a partir dos atributos
do tipo-entidade Disciplina
INSERT INTO disciplina (codigo_disciplina, nome_disciplina, nome_professor, departamento)
VALUES (<Codigo_Disciplina>, '<Nome_Disciplina>' , '<Nome_Professor>', '<Departamento>');


3. O sistema deve permitir o cadastro de uma Questão de uma determinada
Disciplina a partir dos atributos do tipo-entidade Questão
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('<Texto_Questao>', <Codigo_Disciplina>);


4. O sistema deve permitir a adição de Alternativas de uma determinada Questão
a partir dos atributos do tipo-entidade Alternativa
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('<Texto_Alternativa>', 'Nao', <ID_Questao>);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('<Texto_Alternativa>', 'Nao', <ID_Questao>);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('<Texto_Alternativa>', 'Nao', <ID_Questao>);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('<Texto_Alternativa>', 'Sim', <ID_Questao>);


-- ============================================================ BUSCAS ===============================================================

1. O sistema deve permitir a busca de um Aluno pertencente à uma Disciplina
    - Atributo(s) de visualização do resultado: RA, Nome_Aluno
    - Atributo(s) de busca (ou de condições/filtros): RA ou Nome_Aluno, CodigoDisciplina

-- Utilizando JOIN
SELECT * FROM aluno JOIN disciplina ON aluno.Codigo_Disciplina = disciplina.Codigo_Disciplina AND RA_Aluno = <RA_Aluno> AND disciplina.Codigo_Disciplina = <Codigo_Disciplina>;

-- Utilizando Produto Cartesiano
SELECT * FROM aluno, disciplina WHERE aluno.Codigo_Disciplina = disciplina.Codigo_Disciplina AND RA_Aluno = <RA_Aluno> AND disciplina.Codigo_Disciplina = <Codigo_Disciplina>;


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

SELECT * FROM questao WHERE Codigo_Disciplina = <Codigo_Disciplina>;


4. O sistema deve permitir busca de uma Disciplina à partir de seu código
    - Atributo(s) de visualização do resultado: atributos da Disciplina encontrada
    - Atributo(s) de busca (ou de condições/filtros): CodigoDisciplina

SELECT * FROM disciplina WHERE Codigo_Disciplina = <Codigo_Disciplina>;


5. O sistema deve permitir o cálculo do número de Alunos inscritos por Disciplina
    - Atributo(s) de visualização do resultado: número de alunos
    - Atributo(s) de cálculo: CodigoDisciplina

SELECT disciplina.Codigo_Disciplina AS Codigo_Disciplina, count(*) AS Numero_Alunos FROM aluno JOIN disciplina ON aluno.Codigo_Disciplina = disciplina.Codigo_Disciplina GROUP BY disciplina.Codigo_Disciplina;


6. O sistema deve permitir o cálculo do número de Questões respondidas por um
Aluno
    - Atributo(s) de visualização do resultado: número de questões respondidas
    - Atributo(s) de cálculo: obtido através do tipo-relacionamento ALUNO responde QUESTÃO

SELECT count(*) FROM responde WHERE RA_Aluno = <RA_Aluno>;
OU
SELECT Total_Respondidas FROM aluno WHERE RA_Aluno = <RA_Aluno>;


7. O sistema deve permitir o cálculo da pontuação do Aluno
    - Atributo(s) de visualização do resultado: pontuação do Aluno
    - Atributo(s) de cálculo: número de acertos

SELECT count(*) FROM responde JOIN alternativa ON responde.Opcao = alternativa.ID_Alternativa WHERE RA_Aluno = <RA_Aluno> AND alternativa.Eh_Correta = 'Sim';
OU
SELECT Pontuacao FROM aluno WHERE RA_Aluno = <RA_Aluno>;


8. O sistema deve permitir o cálculo do número de Alunos e do número de Questões
de uma determinada Disciplina

-- Numero de Alunos
SELECT count(*) FROM aluno_disciplina WHERE Codigo_Disciplina = <Codigo_Disciplina>;
OU
SELECT Numero_Alunos FROM disciplina WHERE Codigo_Disciplina = <Codigo_Disciplina>;

-- Numero de Questoes
SELECT count(*) FROM questao WHERE Codigo_Disciplina = <Codigo_Disciplina>;
OU
SELECT Numero_Questoes FROM disciplina WHERE Codigo_Disciplina = <Codigo_Disciplina>;

-- Numero de Aluno E Numero de Questoes
--!!!!!
OU
SELECT Numero_Alunos, Numero_Questoes FROM disciplina WHERE Codigo_Disciplina = <Codigo_Disciplina>; 


9. O sistema deve permitir a visualização de todas as alternativas de uma determinada
questão

SELECT * FROM questao JOIN alternativa ON questao.ID_Questao = alternativa.ID_Questao WHERE questao.ID_Questao = <ID_Questao>;

SELECT * FROM alternativa WHERE ID_Questao = <ID_Questao>; --!


10. O sistema deve permitir a visualização de todos os alunos em uma determinada
Disciplina

SELECT aluno_disciplina.Codigo_Disciplina, aluno.RA_Aluno, aluno.Nome_Aluno
FROM aluno_disciplina JOIN aluno 
ON aluno_disciplina.RA_Aluno = aluno.RA_Aluno
WHERE Codigo_Disciplina = <Codigo_Disciplina>;


-- =========================================================== AGREGACAO ==============================================================

1. O sistema deve gerar relatórios da média da pontuação dos Alunos por Disciplina

SELECT avg(pontuacao) FROM aluno_disciplina ad JOIN aluno a on ad.ra_aluno = a.ra_aluno GROUP BY ad.codigo_disciplina


2. O sistema deve gerar relatórios da média do número de questões respondidas por Disciplina

SELECT avg(total_respondidas), codigo_disciplina FROM aluno_disciplina ad JOIN aluno a on ad.ra_aluno = a.ra_aluno GROUP BY ad.codigo_disciplina


-- ========================================================== MODIFICACOES ===========================================================

1. O sistema deve permitir a alteração de dados da Disciplina

UPDATE disciplina SET <Coluna_Disciplina> = <Informação>;

2. O sistema deve permitir a alteração de dados do Aluno

UPDATE aluno SET <Coluna_Aluno> = <Informação>;


-- =========================================================== REMOCOES ==============================================================

1. O sistema deve permitir a remoção de Questões

DELETE FROM questao WHERE ID_Questao = <ID_Questao>;

2. O sistema deve permitir a remoção de Alunos

DELETE FROM aluno WHERE RA_Aluno = <RA_Aluno>;

