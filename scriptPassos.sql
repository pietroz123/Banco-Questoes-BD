--* Criação das Tabelas

--* Tabela Disicplinas
CREATE TABLE disciplina (
    Codigo_Disciplina int NOT NULL PRIMARY KEY,
    Nome_Disciplina varchar(255) NOT NULL,
    Nome_Professor varchar(255) NOT NULL,
    Departamento varchar(255) NOT NULL,
    Numero_Questoes int NOT NULL DEFAULT 0,
    Numero_Alunos int NOT NULL DEFAULT 0 CHECK (Numero_Alunos < 20)   --! VOLTAR
);

--* Tabela Aluno
CREATE TABLE aluno (
    RA_Aluno int NOT NULL PRIMARY KEY,
    Nome_Aluno varchar(255) NOT NULL,
    CPF varchar(14) NOT NULL UNIQUE,
    Email_Aluno varchar(255) NOT NULL UNIQUE, 
    Tel_Residencial varchar(14) NOT NULL,
    Tel_Celular varchar(15) NOT NULL,
    Total_Respondidas int NOT NULL DEFAULT 0, --! VOLTAR
    Pontuacao int NOT NULL DEFAULT 0
);


--* Tabela Aluno_Disciplina
CREATE TABLE aluno_disciplina (
    RA_Aluno int NOT NULL REFERENCES aluno(RA_Aluno) ON DELETE CASCADE ON UPDATE CASCADE, -- Chave Estrangeira / Caso o ALUNO seja deletado, então a linha que relaciona este ALUNO a  DISCIPLINA também deixa de existir, ou seja, o ALUNO não está mais inscrito na DISCIPLINA.
    Codigo_Disciplina int NOT NULL REFERENCES disciplina(Codigo_Disciplina) ON DELETE RESTRICT ON UPDATE CASCADE -- Chave Estrangeira / Caso uma DISCIPLINA seja deletada, se um ALUNO estiver contido na disciplina, restrinja a deleção
);


--* Tabela Questão
CREATE TABLE questao (
    ID_Questao SERIAL NOT NULL PRIMARY KEY,
    Texto_Questao text NOT NULL,
    Peso int NOT NULL DEFAULT 1,
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



-- Alunos de BD
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (743512, 'Bianca Gomes Rodrigues', '444.618.208.07', 'bgsrd@outlook.com', '(15) 3293-2383', '(15) 99143-4900');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (611685, 'Lucas Oliver Victor Melo', '098.810.918-29', 'lucasolivervictormelo@granvale.com.br', '(11) 3819-0035', '(11) 98958-3398');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (851725, 'Vicente Nathan Francisco Mendes', '465.775.178-60', 'vicentenathanfranciscomendes@caferibeiro.com.br', '(11) 2613-9077', '(11) 98630-7733');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (592355, 'Larissa Antonella Lara Silveira', '269.560.788-13', 'larissaantonellalarasilveira@ornatopresentes.com.br', '(11) 2505-1593', '(11) 98358-5632');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (855907, 'Carlos Eduardo Luan Aparício', '297.720.168-85', 'carloseduardoluanaparicio-76@aulicinobastos.com.br', '(11) 3679-9955', '(11) 99338-7210');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (508728, 'Mateus Diego Gomes', '668.047.608-91', 'mateusdiegogomes-73@dillon.com.br', '(11) 2842-6672', '(11) 99806-8291');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (907292, 'Gabriela Isabelle Oliveira', '624.785.538-99', 'gabrielaisabelleoliveira@sitran.com.br', '(11) 2987-3428', '(11) 98933-8251');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (587888, 'Raquel Luana Freitas', '610.529.428-06', 'rraquelluanafreitas@graffiti.net', '(11) 3713-6269', '(11) 98855-2484');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (826384, 'Vitória Maria Oliveira', '732.608.608-78', 'vitoriamariaoliveira@riquefroes.com', '(11) 3699-0358', '(11) 98782-8991');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (152420, 'Sérgio Renan Augusto da Cunha', '101.611.928-31', 'sergiorenanaugustodacunha@depotit.com.br', '(11) 2663-3286', '(11) 98844-3240');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (125656, 'Alexandre Benjamin Ian Bernardes', '927.052.178-86', 'aalexandrebenjaminianbernardes@plastic.com.br', '(11) 3620-6334', '(11) 99841-9296');

-- Alunos de SO
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (743588, 'Pietro Zuntini Bonfim', '410.242.338-98', 'pietrozuntini@gmail.com', '(15) 3228-1918', '(15) 99713-6093');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (240891, 'Leandro Gabriel Pereira', '549.927.378-20', 'leandrogabrielpereira_@selfcd.com.br', '(11) 2710-2355', '(11) 98952-0541');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (111133, 'Augusto Juan Campos', '447.102.398-51', 'augustojuancampos-90@power.alston.com', '(11) 2545-3263', '(11) 98773-7381');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (659187, 'Aurora Laura Marli Martins', '056.131.768-25', 'auroralauramarlimartins@dillon.com.br', '(11) 3763-0415', '(11) 98458-9597');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (914258, 'César Tiago Barros', '308.367.738-37', 'cesartiagobarros@konzeption.com.br', '(11) 3700-0109', '(11) 98247-1162');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (319322, 'Renato Raul Souza', '546.415.918-57', 'renatoraulsouza@mx.labinal.com', '(11) 3789-9482', '(11) 98525-7479');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (693596, 'Benício Manuel Viana', '026.010.458-25', 'bbeniciomanuelviana@maissaude.adm.br', '(11) 2968-2476', '(11) 99160-0020');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (282384, 'Clara Lorena da Cunha', '996.021.298-08', 'claralorenadacunha_@yahoo.de', '(11) 3592-6006', '(11) 98973-2565');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (282390, 'Enzo Mário Nunes', '324.191.268-07', 'eenzomarionunes@engineer.com', '(11) 2683-3268', '(11) 98627-7386');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (691045, 'Antonio Eduardo Manuel Novaes', '669.849.188-80', 'antonioeduardomanuelnovaes@purkyt.com', '(11) 3588-1824', '(11) 99819-5790');
INSERT INTO aluno (RA_Aluno, Nome_Aluno, CPF, Email_Aluno, Tel_Residencial, Tel_Celular) 
VALUES (671045, 'Sophie Carolina Gonçalves', '762.556.928-41', 'sophiecarolinagoncalves@iaru.com', '(11) 3931-1890', '(11) 98332-5499');


INSERT INTO disciplina (codigo_disciplina, nome_disciplina, nome_professor, departamento) VALUES (11111, 'Banco de Dados', 'Sahudy', 'DComp');

INSERT INTO disciplina (codigo_disciplina, nome_disciplina, nome_professor, departamento) VALUES (22222, 'Sistemas Operacionais', 'Gustavo', 'DComp');


-- Alunos de BD
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (743588, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (743512, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (282384, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (611685, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (851725, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (592355, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (855907, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (508728, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (659187, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (907292, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (587888, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (693596, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (826384, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (671045, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (152420, 11111);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (125656, 11111);

-- Alunos de SO
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (743512, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (743588, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (587888, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (240891, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (111133, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (659187, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (851725, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (914258, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (319322, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (693596, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (282384, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (855907, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (282390, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (691045, 22222);
INSERT INTO aluno_disciplina (RA_Aluno, Codigo_Disciplina) VALUES (671045, 22222);

-- Questões BD
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('PostgreSQL é', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('A instrução JOIN em SQL é utilizada para consultar informações de duas ou mais tabelas, baseadas em relações entre colunas destas tabelas. Um dos tipos de JOIN é o INNER JOIN que retorna linhas ', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Analise os seguintes comandos em SQL:

CREATE TABLE nota (id INT PRIMARY KEY,data TEXT,valor REAL); 
INSERT INTO nota SET id=1,data="01012012",valor=15.5; 
INSERT INTO nota SET id=1,data="03022012",valor=11.5; 
INSERT INTO nota SET id=2,data="01042012",valor=25.5; 
INSERT INTO nota SET id=20,data="10062012",valor=12.5; 
SELECT COUNT(*) FROM nota WHERE valor < 20; 

O resultado para a consulta efetuada será:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('A integridade dos dados é um termo abrangente que inclui, simultaneamente, os conceitos de consistência, precisão e correção dos dados armazenados em um banco de dados. Um dos tipos de integridade é caracterizado por meio das condições listadas a seguir.

- É a forma mais elementar de restrição de integridade; 
- O valor de um campo deve obedecer ao tipo de dados e às restrições de valores admitidos para a coluna;
- Funciona ao nível da coluna do banco de dados. 

O tipo descrito acima é denominado integridade de:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Em um banco de dados, uma transação constitui uma operação, como inclusão, leitura, atualização ou exclusão, realizada em um banco de dados. Nesse contexto, alguns princípios devem ser atendidos, tais como:

I. se ocorrerem falhas que interrompam o processo de atualização de valores de estoque, o sistema deve manter os valores antigos.
II. se a transação for completada sem problemas, a soma das quantidades existentes em estoque do produto transferido (nos dois estoques), antes e depois da transação, deve ser a mesma.

Os princípios definidos em I e II são denominados, respectivamente:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('PGSQL é uma linguagem procedural carregável desenvolvida para o sistema de banco de dados PostgreSQL. Como a maioria dos produtos de banco de dados relacional, o PostgreSQL suporta funções de agregação. Uma função de agregação computa um único resultado para várias linhas de entrada. Por exemplo, para calcular a média deve ser usada a seguinte função de agregação:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('No que diz respeito à normalização em bancos de dados, duas formas normais são descritas a seguir.

I. Se somente todos os domínios básicos contiverem exclusivamente valores atômicos. Para atingir esta forma normal deve-se eliminar os grupos de repetição.
II. Se e somente se todos os atributos não chave forem totalmente dependentes da chave primária.

As descrições em I e II indicam condições que devem ser atendidas, respectivamente, pelas seguintes formas normais:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('No que diz respeito às consultas SQL em bancos de dados, duas cláusulas devem ser utilizadas na sintaxe do comando SELECT com as finalidades especificadas a seguir. 

I. Para expressar a condição que deve satisfazer cada grupo. 
II. Para ordenar os registros selecionados com uma ordem específica. 

As cláusulas I e II são, respectivamente:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Em PGSQL, é usado, para o operador de atribuição, o seguinte símbolo:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Em TSQL, um comando permite a remoção de uma ou mais definições de tabela e todos os dados, índices, gatilhos, restrições e especificações de permissão dessas tabelas. Esse comando é:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Existem diversas notações para o Modelo Entidade-Relacionamento. A notação original foi proposta por Peter Chen e é composta de entidades, relacionamentos, atributos, representados, respectivamente, por:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Considere a existência da seguinte tabela de um Banco de Dados relacional:

                              Produto (ID, Item, Tipo, Custo)

A consulta SQL para obter o Custo médio dos Itens de cada Tipo de Produto é

                        SELECT Tipo, AVG (Custo)
                        FROM Produto
                        Cláusula 3

O conteúdo da Cláusula 3 para completar a consulta e atender o especificado na questão', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Assinale a alternativa que corresponde ao recurso do modelo de entidade-relacionamento, cuja definição é “ser um conjunto de um ou mais atributos que, tomados coletivamente, permite-se identificar de maneira unívoca uma entidade em um conjunto de entidades”:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('A estrutura básica de uma expressão SQL consiste em três cláusulas. Assinale-as:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Sobre o modelo de entidade-relacionamento, assinale a alternativa correta:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Durante a modelagem de um projeto de banco de dados é necessário aplicar o processo de normalização. Esse processo é composto por várias regras ou “forma normal”. Analise as afirmativas a seguir:

I – A primeira forma normal (1FN) diz que toda relação deve ter uma chave primária e deve-se garantir que todo atributo seja atômico.
II – A segunda forma normal (2FN) diz que toda relação deve estar na 2FN e devem-se eliminar dependências funcionais transitivas, ou seja, todo atributo não chave deve ser mutuamente independente.
III – A terceira forma normal (3FN) diz que devem-se eliminar dependências funcionais parciais, ou seja, todo atributo não chave deve ser totalmente dependente da chave primária.

Assinale a alternativa correta:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Na fase de modelagem de um banco de dados, o modelo que analisa os limites impostos por alguma tecnologia de banco de dados é o:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES (' Analise as afirmações a seguir a respeito de Store Procedure:

I – Uma Store Procedure é um procedimento armazenado em um arquivo executável que pode ser chamado através de comandos SQL.
II – Uma Store Procedure armazena tarefas repetitivas dentro de um banco de dados e aceita parâmetros de entrada para que a tarefa seja efetuada de acordo com a necessidade individual.
III – Uma Store Procedure é disparada automaticamente após a execução de Insert, ou Update, ou Delete.

Assinale a alternativa correta:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Como é conhecido em banco de dados o processo de normalização que requer apenas que todos os atributos sejam atômicos, ou seja, não contenham repetições dentro de um campo?', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Uma entidade fraca na modelagem conceitual de banco de dados é a que se caracteriza', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Um banco de dados relacional pode ser definido como um(a)', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Para responder a esta questão, sobre os níveis de abstração de um SGBD, leia cuidadosamente as afirmações a seguir.

I. O nível Físico é o nível mais alto de abstração e descreve como os dados estão realmente armazenados. 
II. O nível Conceitual descreve todos os dados que estão armazenados de fato no banco de dados e as relações existentes entre eles.
III. O nível de Visões descreve o banco de dados em partes que são de interesse de cada usuário ou aplicação. 

Está correto o que se afirma em:', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Assinale a alternativa que apresenta as palavras que preenchem, respectivamente, as lacunas do seguinte texto, sobre os níveis de independência de um banco de dados relacional. 

A independência física de dados é a habilidade de se modificar o esquema _______ sem a necessidade de rescrever o modelo conceitual, enquanto a independência ________ de dados é a habilidade de se modificar o esquema _______ sem a necessidade de reescrever as aplicações.', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Considere o seguinte código SQL:

CREATE TABLE EMPREG
(ID INTEGER PRIMARY KEY, NOME CHAR(20), SOBRENOME CHAR(60), SALARIO REAL);
INSERT INTO EMPREG VALUES (44, ‘William’, ‘Simpson’, 6387.01);
INSERT INTO EMPREG VALUES (11, ‘Fulano’, ‘Brasil’, 3045.78);
INSERT INTO EMPREG VALUES (22, ‘Beltrano’, ‘da Silva’, 4046.79);
INSERT INTO EMPREG VALUES (33, ‘Carlos’, ‘da Silva’, 13040.78);
CREATE TABLE COMISSAO
(ID INTEGER REFERENCES EMPREG(ID), MES INTEGER CHECK (MES BETWEEN 1 AND 12),
VALOR_COMISS REAL, PRIMARY KEY (ID, MES));
INSERT INTO COMISSAO VALUES (22,1,1001.67);
INSERT INTO COMISSAO VALUES (22,6,1001.67);
INSERT INTO COMISSAO VALUES (44,5,2338.67);
INSERT INTO COMISSAO VALUES (11,1,400.67);
INSERT INTO COMISSAO VALUES (33,9,2340.00);
INSERT INTO COMISSAO VALUES (44,12,2940.67);

O resultado da consulta

SELECT NOME FROM EMPREG WHERE 2340.00 < (SELECT AVG(VALOR_COMISS) FROM COMISSAO WHERE EMPREG.ID = COMISSAO.ID);

será', 11111);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Em um banco de dados, a tabela Pessoa foi criada com a seguinte instrução:

CREATE TABLE Pessoa (     PessoaID int ,
                                           Nome varchar (255) ,
                                           Sobrenome varchar (255),
                                           Endereco varchar (255) ,
                                           Cidade varchar (255)) ;

Após a criação, a tabela foi preenchida, porém o programador percebeu que todos os Nomes foram colocados no lugar do Sobrenome e vice-versa.

Que instrução SQL pode ser usada para realizar a troca, corrigindo a base?', 11111);




-- Alternativas
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('um algoritmo de conteúdos.', 'Nao', 1);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('uma linguagem de programação.', 'Nao', 1);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('um gerenciador de banco de dados.', 'Sim', 1);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('um servidor de páginas web.', 'Nao', 1);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('não importando a correspondência entre as tabelas, criando uma relação entre as linhas e colunas.', 'Nao', 2);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('quando existir correspondência em apenas uma das tabelas.', 'Nao', 2);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('não importando a correspondência entre as tabelas, criando uma relação entre as linhas, apenas.', 'Nao', 2);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('quando existir ao menos uma correspondência em ambas as tabelas.', 'Sim', 2);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('12.5', 'Nao', 3);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('3', 'Nao', 3);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('11.5, 12.5 e 15.5', 'Nao', 3);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('2', 'Sim', 3);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('instância.', 'Nao', 4);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('registro.', 'Nao', 4);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('domínio.', 'Sim', 4);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('entidade.', 'Nao', 4);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('consistência e durabilidade.', 'Nao', 5);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('bilidade e independência.', 'Nao', 5);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('independência e confiabilidade.', 'Nao', 5);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('atomicidade e consistência.', 'Sim', 5);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('query', 'Nao', 6);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('media', 'Nao', 6);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('med', 'Nao', 6);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('avg', 'Sim', 6);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('1FNe 2FN', 'Sim', 7);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('2FNe 1FN', 'Nao', 7);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('2FNe 3FN', 'Nao', 7);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('3FNe 1FN', 'Nao', 7);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('JOIN e ORDERBY', 'Nao', 8);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('GROUPING e ORDER BY', 'Nao', 8);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('HAVING e SORT BY', 'Nao', 8);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('HAVING e ORDER BY', 'Sim', 8);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('=', 'Nao', 9);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('<-', 'Nao', 9);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES (': =', 'Sim', 9);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('<<', 'Nao', 9);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('REMOVE TABLE', 'Nao', 10);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('DELETE TABLE', 'Nao', 10);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('DROP TABLE', 'Sim', 10);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('ERASE TABLE', 'Nao', 10);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('retângulos, losangos e círculos.', 'Sim', 11);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('retângulos, círculos e losangos.', 'Nao', 11);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('losangos, retângulos e círculos.', 'Nao', 11);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('círculos, losangos e retângulos.', 'Nao', 11);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('ORDER BY Tipo.', 'Nao', 12);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('HAVING Tipo LIKE “ “.', 'Nao', 12);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('WHERE Tipo IN GROUP.', 'Nao', 12);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('GROUP BY Tipo', 'Sim', 12);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Chave primária.', 'Nao', 13);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Superchave.', 'Sim', 13);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Especialização.', 'Nao', 13);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Generalização.', 'Nao', 13);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Select, distinct, where.', 'Nao', 14);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Select, from, where.', 'Sim', 14);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Select, distinct, from.', 'Nao', 14);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('From, where, distinct.', 'Nao', 14);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Uma entidade é um objeto no mundo real que pode ser identificada de forma unívoca em relação a todos os outros objetos.', 'Sim', 15);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Define-se por “conjunto de entidades”, entidades de tipos diferentes com propriedades diferentes.', 'Nao', 15);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Uma entidade é uma associação entre vários relacionamentos.', 'Nao', 15);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('As entidades são utilizadas unicamente para efetuar o mapeamento das cardinalidades.', 'Nao', 15);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('A afirmação I está correta.', 'Sim', 16);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('A afirmação II está correta.', 'Nao', 16);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('As afirmações I e III estão corretas.', 'Nao', 16);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES (' Todas as afirmações estão corretas.', 'Nao', 16);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Modelo conceitual.', 'Nao', 17);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Modelo lógico.', 'Sim', 17);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Modelo físico.', 'Nao', 17);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Modelo orientado a objeto.', 'Nao', 17);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('A afirmação I está correta.', 'Nao', 18);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('A afirmação II está correta.', 'Sim', 18);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Nenhuma afirmação está correta.', 'Nao', 18);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES (' Todas as afirmações estão corretas.', 'Nao', 18);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Primeira forma normal.', 'Sim', 19);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Segunda forma normal.', 'Nao', 19);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Terceira forma normal.', 'Nao', 19);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Quarta forma normal.', 'Nao', 19);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('por conter valores repetidos.', 'Nao', 20);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('por não possuir relacionamentos.', 'Nao', 20);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('por não possuir atributos multivalorados.', 'Nao', 20);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('por não possuir um atributo chave.', 'Sim', 20);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('banco de informações relacionado a outros bancos.', 'Nao', 21);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('conjunto de IDEs desenvolvidas para criar programas.', 'Nao', 21);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('conjunto de tabelas, cada qual designada por apenas um nome.', 'Sim', 21);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('coleção de relações que constituem os registros de um atributo.', 'Nao', 21);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('I e II, somente.', 'Nao', 22);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('II e III, somente.', 'Sim', 22);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('I e III, somente.', 'Nao', 22);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('todas', 'Nao', 22);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('físico; lógica; conceitual', 'Sim', 23);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('lógico; física; conceitual', 'Nao', 23);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('lógico; lógica; conceitual', 'Nao', 23);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('conceitual; lógica; lógico', 'Nao', 23);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('William', 'Sim', 24);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Fulano', 'Nao', 24);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('da Silva', 'Nao', 24);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Carlos', 'Nao', 24);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('SELECT Nome As Sobrenome, Sobrenome AS Nome FROM Pessoa', 'Nao', 25);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('UPDATE Nome=Sobrenome, Sobrenome=Nome FROM Pessoa', 'Nao', 25);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('UPDATE Pessoa SET Nome,Sobrenome WITH (SELECT Sobrenome,Nome FROM Pessoa)', 'Nao', 25);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('UPDATE Pessoa SET Nome=Sobrenome, Sobrenome=Nome', 'Sim', 25);


-- Questões SO
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Relacione os seguintes comandos do sistema operacional Debian com seus respectivos objetivos.

Comandos
1. apt-get 
2. sudo 
3. tail 
4. cat 

Objetivos
( ) Exibir o conteúdo final de um arquivo. 
( ) Executar um comando como outro usuário. 
( ) Gerenciamento de pacotes. 
( ) Concatenar arquivos ou entrada padrão e exibir na saída padrão. 

Assinale a alternativa que indica a sequência correta, de cima para baixo.', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('No console do sistema operacional Linux, alguns comandos permitem executar operações com arquivos e diretórios do disco.

Os comandos utilizados para criar, acessar e remover um diretório vazio são, respectivamente,', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('A estrutura de diretórios em árvore é utilizada em diversos sistemas operacionais. Uma das características dessa estrutura é:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Com relação a tipos de sistemas operacionais, utilização de recursos e forma como esses tipos são estruturados, assinale a opção correta.', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Um sistema operacional', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Organizar o disco e possibilitar trabalhar fazendo, por exemplo, cópia, exclusão e mudança no local dos arquivos são ações importantes nas atividades cotidianas em informática.

Qual a estrutura usada para organizar arquivos e demais informações no meio digital, no ambiente dos sistemas operacionais?', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Sobre sistemas operacionais é INCORRETO afirmar:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('O Ubuntu é um sistema operacional open source que foi criado com base na distribuição Linux Debian. Ele possui uma ferramenta gerenciadora de pacotes, denominada apt, que traz facilidade na instalação de novas aplicações para esse SO.

O comando necessário para buscar um pacote denominado provati por meio do apt, é:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Um sistema operacional, no geral, tem como funções: o gerenciamento de processos, o gerenciamento de memória, o sistema de arquivos e a entrada e saída de dados. Independente do sistema operacional utilizado, essas funções são executadas. Os sistemas operacionais podem ser classificados em relação ao seu projeto, ou seja, a arquitetura quanto ao gerenciamento de processos e ao número de usuários que podem utilizar o sistema simultaneamente. Sobre a classificação dos sistemas operacionais, assinale A (Arquitetura) e P (Processos) nos sistemas apresentados a seguir.

( ) Sistema em camadas.
( ) Monitor de máquinas virtuais.
( ) Multiprogramação.
( ) Micronúcleo.
( ) Multitarefa.

A sequência está correta em', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Sobre comandos do MS-DOS está INCORRETO o que se afirma em:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Trata-se do conjunto de programas que faz o computador funcionar adequadamente, além de fornecer uma interface gráfica amigável e possibilitar o uso dos demais programas de computador. Esse conceito refere-se ao:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Atualmente, no mercado, há vários sistemas operacionais. Caracterizam-se como exemplos de sistema operacional:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('São exemplos de versões ou distribuições de sistemas operacionais, EXCETO:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES (' Analise as seguintes sentenças:

I. O UNIX é um sistema operacional de grande eficiência, escrito na linguagem C, que se caracteriza por sua grande portabilidade.
II. O DOS é um sistema operacional de 32 bits, que possui um ambiente gráfico e objetos caracterizados por janelas, ícones e botões.
III. O Windows Vista possui uma versão popular denominada ultimate, com recursos limitados, encontrada somente em fabricantes de máquinas prontas (OEM).

Sobre as sentenças acima, pode-se afirmar que apenas:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Existem vários sistemas operacionais no mercado. Todos, porém, realizam as mesmas operações básicas. Com relação aos sistemas operacionais, podemos considerar:

I. Conjunto de programas que gerenciam os recursos do computador, como acesso ao disco, gerenciamento de memória e gerenciamento de arquivos.
II. Conjunto de editores de textos, banco de dados, planilhas eletrônicas para automação comercial.
III. Conjunto de programas que faz a interface entre o usuário e o computador.
IV. Conjunto de programas que tem como objetivo a segurança do computador, como firewall, antivírus e criação de cópias de segurança.

É correto o que se afirma APENAS em:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Para garantir a execução apropriada do Sistema Operacional (SO), há pelo menos duas modalidades de execução. No momento da inicialização do SO, o hardware começa a operar na modalidade ..I.... . O SO é carregado e dá início às aplicações das pessoas que utilizam o computador na modalidade ..II.... . 

As lacunas I e II são, correta e respectivamente, preenchidas com:', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Assinale a alternativa que indica corretamente o parâmetro do comando ipconfg, responsável por renovar todos os adaptadores de rede no Sistema Operacional Windows 7.', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Assinale a alternativa que indica corretamente a sequência padrão utilizada no Sistema Operacional Linux para configuração, compilação e instalação de um programa a partir de seu código fonte.', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Os sistemas operacionais', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('O tipo de virtualização utilizada para separar o sistema operacional e suas aplicações do dispositivo físico é denominado virtualização de', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Quando um usuário executa um programa, processos são criados e inseridos em uma lista. Um processo vai passando para o topo da lista à medida que outros concluem sua vez de usar o processador. Quando um processo chega ao topo da lista e há um processador disponível, aquele processo é designado a um processador e diz-se que ele fez uma transição de estado, passando do estado de', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Nos sistemas operacionais multiprogramáveis e(ou) multitarefas, os mecanismos básicos que tornam possível a execução de tarefas concorrentes são', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Em um cenário no qual os processos trabalham concorrendo e compartilhando recursos, ocorrerá deadlock quando', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Quando um computador é multiprogramado, muitas vezes há dois ou mais processos no estado de pronto que competem pela CPU ao mesmo tempo. Nesse contexto,', 22222);
INSERT INTO questao (texto_questao, codigo_disciplina) VALUES ('Considere o trecho a seguir no contexto de sistemas operacionais.

Um conjunto de processos está num bloqueio perpétuo quando cada processo do conjunto está esperando por um evento que apenas outro processo do conjunto pode causar.

A situação descrita é típica da ocorrência de um:', 22222);



-- Alternativas
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('1 – 2 – 3 – 4', 'Nao', 26);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('2 – 1 – 3 – 4', 'Nao', 26);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('2 – 4 – 1 – 3', 'Nao', 26);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('3 – 2 – 1 – 4', 'Sim', 26);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('pwd, mv e rm. ', 'Nao', 27);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('md, ls e rm. ', 'Nao', 27);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('mkdir, cd e rmdir. ', 'Sim', 27);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('cdir, lsdir e erase.', 'Nao', 27);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('cada usuário pode criar vários níveis de diretórios (ou subdiretórios), sendo que cada um pode conter arquivos e subdiretórios.', 'Sim', 28);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('cada usuário possui o seu diretório exclusivo, no qual todos os seus arquivos são armazenados, e não tem acesso e nem conhecimento de outros diretórios.', 'Nao', 28);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('o caminho absoluto para um arquivo é quando ele é referenciado a partir do diretório corrente.', 'Nao', 28);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('um arquivo é especificado por meio de um caminho relativo, que descreve todos os diretórios percorridos a partir da raiz até o diretório no qual o arquivo se encontra.', 'Nao', 28);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('No sistema operacional do tipo monotarefa, as aplicações são executadas de maneira simultânea, ou seja, o tempo de processamento é dividido entre as aplicações em execução.', 'Nao', 29);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('No sistema operacional do tipo cliente-servidor, utiliza-se uma máquina virtual criada por um programa que simule o processador e outros recursos.', 'Nao', 29);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('No sistema operacional do tipo monolítico, uma coleção de rotinas pode chamar qualquer outra rotina, uma vez que cada uma delas possui interface definida.', 'Sim', 29);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('O sistema operacional do tipo batch organiza-se em camadas, cada uma das quais faz referência apenas aos módulos das camadas anteriores.', 'Nao', 29);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('possui um kernel, que é responsável pelas funções de baixo nível, como gerenciamento de memória, de processos, dos subsistemas de arquivos e suporte aos dispositivos e periféricos conectados ao computador.', 'Sim', 30);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('é do tipo BIOS quando se encarrega de ativar os recursos da máquina, como processador, placa de vídeo, unidades de disco e memória ROM e RAM.', 'Nao', 30);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('é do tipo firmware quando precisa ser carregado para a memória RAM de um dispositivo de hardware, como scanners e impressoras a laser.', 'Nao', 30);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('multiusuário permite que diversos usuários utilizem simultaneamente os recursos de um computador monotarefa.', 'Nao', 30);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Diretórios.', 'Sim', 31);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Assessórios.', 'Nao', 31);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Painel de Controle.', 'Nao', 31);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Propriedades do Sistema.', 'Nao', 31);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('O sistema operacional é uma camada de hardware que separa as aplicações do software que elas acessam e fornece serviços que permitem que cada aplicação seja executada com segurança e efetividade.', 'Sim', 32);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Na maioria dos sistemas operacionais um usuário requisita ao computador que execute uma ação (por exemplo, imprimir um documento), e o sistema operacional gerencia o software e o hardware para produzir o resultado esperado.', 'Nao', 32);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Um usuário interage com o sistema operacional via uma ou mais aplicações de usuário e, muitas vezes, por meio de uma aplicação especial denominada shell ou interpretador de comandos.', 'Nao', 32);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('O software que contém os componentes centrais do sistema operacional chama-se núcleo (kernel).', 'Nao', 32);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('sudo apt update provati.', 'Nao', 33);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('sudo apt-get cache provati.', 'Nao', 33);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('sudo apt search provati.', 'Sim', 33);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('sudo apt edit-sources provati.', 'Nao', 33);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('A, P, A, P, A.', 'Nao', 34);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('P, A, P, P, A.', 'Nao', 34);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('A, A, P, A, P.', 'Sim', 34);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('P, P, A, P, A.', 'Nao', 34);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('LS é utilizado para mudar a pasta corrente para a pasta especificada.', 'Sim', 35);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('COPY é utilizado para copiar um ou mais arquivos para o diretório especificado.', 'Nao', 35);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('CLS é utilizado para limpar a tela e posicionar o cursor na primeira linha do prompt.', 'Nao', 35);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('MD é utilizado para criar uma pasta no diretório corrente com o nome especificado.', 'Nao', 35);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Driver básico de periférico.', 'Nao', 36);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Sistema operacional.', 'Sim', 36);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Plugin.', 'Nao', 36);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Hotswap.', 'Nao', 36);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Internet Explorer e Windows XP.', 'Nao', 37);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Windows Vista e Firefox.', 'Nao', 37);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Write e Windows Vista.', 'Nao', 37);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Ubuntu e Windows 7.', 'Sim', 37);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Windows XP.', 'Nao', 38);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Red Hat Linux.', 'Nao', 38);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Windows Chrome.', 'Sim', 38);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Linux Ubuntu.', 'Nao', 38);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('I é verdadeira;', 'Sim', 39);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('II é verdadeira;', 'Nao', 39);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('III é verdadeira;', 'Nao', 39);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('I e III são verdadeiras;', 'Nao', 39);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('I e III.', 'Sim', 40);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('I e IV.', 'Nao', 40);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('I e II.', 'Nao', 40);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('Todas são corretas.', 'Nao', 40);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('de firmware - de aplicativo', 'Nao', 41);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('prioritária - de programa', 'Nao', 41);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('prioritária - sem privilégios', 'Nao', 41);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('de kernel - de usuário', 'Sim', 41);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('ipconfg', 'Nao', 42);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('ipconfg / all', 'Nao', 42);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('ipconfg / renew', 'Sim', 42);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('ipconfg / release', 'Nao', 42);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('./confgure; make; makeinstal', 'Sim', 43);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('makeconfg; make; makeinstall', 'Nao', 43);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('makeinstall; make; ./confgure', 'Nao', 43);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('make; makeinstall; ./confgure', 'Nao', 43);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('fazem parte dos chamados softwares aplicativos, incorporando diversas funções.', 'Nao', 44);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('servem para armazenar dados enquanto o computador estiver ligado.', 'Nao', 44);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('incorporam muitos recursos à máquina, tornando-a quase sempre multiprocessadora e plug-and-play.', 'Nao', 44);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('têm rotinas que não são executadas de forma linear, mas, sim, concorrentemente, em função de eventos assíncronos.', 'Sim', 44);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('hardware.', 'Nao', 45);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('servidor.', 'Nao', 45);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('aplicação.', 'Nao', 45);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('desktop.', 'Nao', 45);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('espera para o estado de pronto.', 'Nao', 46);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('bloqueado para o estado de pronto.', 'Nao', 46);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('pronto para o estado de execução.', 'Nao', 46);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('bloqueado para o estado de execução.', 'Nao', 46);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('o acesso direto à memória e a reentrância.', 'Nao', 47);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('a interrupção e a exceção.', 'Sim', 47);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('o buffering e o spooling.', 'Nao', 47);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('a interrupção e a memória secundária.', 'Nao', 47);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('recursos já alocados possam ser retirados do processo que os alocou, a qualquer momento, por qualquer processo.', 'Nao', 48);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('um processo A espera por um processo B, que espera pelo processo C, que espera pelo processo A.', 'Sim', 48);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('processos não obtêm acesso exclusivo a recursos.', 'Nao', 48);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('um recurso possa ser alocado para um processo em qualquer momento.', 'Nao', 48);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('a unidade de controle de interrupções, parte do sistema operacional, escolhe qual processo entrará em execução.', 'Nao', 49);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('o sistema utiliza o algoritmo de fila duplamente encadeada para escalonar os processos.', 'Nao', 49);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('quando se usa um algoritmo de escalonamento não preemptivo, o processo executa até o fim, sem ser interrompido.', 'Sim', 49);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('quando se usa um algoritmo de escalonamento preemptivo, o processo executa em fatias de tempo chamadas quantum, determinadas pelo usuário.', 'Nao', 49);

INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('timeout;', 'Nao', 50);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('deadlock;', 'Sim', 50);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('timestamp;', 'Nao', 50);
INSERT INTO alternativa (Texto_Alternativa, Eh_Correta, ID_Questao) VALUES ('system halt;', 'Nao', 50);

