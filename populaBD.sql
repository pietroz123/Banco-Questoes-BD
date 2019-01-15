INSERT INTO questao (texto_questao) VALUES ('PostgreSQL é');
INSERT INTO questao (texto_questao) VALUES ('A instrução JOIN em SQL é utilizada para consultar informações de duas ou mais tabelas, baseadas em relações entre colunas destas tabelas. Um dos tipos de JOIN é o INNER JOIN que retorna linhas ');
INSERT INTO questao (texto_questao) VALUES ('Analise os seguintes comandos em SQL:

CREATE TABLE nota (id INT PRIMARY KEY,data TEXT,valor REAL); 
INSERT INTO nota SET id=1,data="01012012",valor=15.5; 
INSERT INTO nota SET id=1,data="03022012",valor=11.5; 
INSERT INTO nota SET id=2,data="01042012",valor=25.5; 
INSERT INTO nota SET id=20,data="10062012",valor=12.5; 
SELECT COUNT(*) FROM nota WHERE valor < 20; 

O resultado para a consulta efetuada será:');
INSERT INTO questao (texto_questao) VALUES ('A integridade dos dados é um termo abrangente que inclui, simultaneamente, os conceitos de consistência, precisão e correção dos dados armazenados em um banco de dados. Um dos tipos de integridade é caracterizado por meio das condições listadas a seguir.

- É a forma mais elementar de restrição de integridade; 
- O valor de um campo deve obedecer ao tipo de dados e às restrições de valores admitidos para a coluna;
- Funciona ao nível da coluna do banco de dados. 

O tipo descrito acima é denominado integridade de:');
INSERT INTO questao (texto_questao) VALUES ('Em um banco de dados, uma transação constitui uma operação, como inclusão, leitura, atualização ou exclusão, realizada em um banco de dados. Nesse contexto, alguns princípios devem ser atendidos, tais como:

I. se ocorrerem falhas que interrompam o processo de atualização de valores de estoque, o sistema deve manter os valores antigos.
II. se a transação for completada sem problemas, a soma das quantidades existentes em estoque do produto transferido (nos dois estoques), antes e depois da transação, deve ser a mesma.

Os princípios definidos em I e II são denominados, respectivamente:');
INSERT INTO questao (texto_questao) VALUES ('PGSQL é uma linguagem procedural carregável desenvolvida para o sistema de banco de dados PostgreSQL. Como a maioria dos produtos de banco de dados relacional, o PostgreSQL suporta funções de agregação. Uma função de agregação computa um único resultado para várias linhas de entrada. Por exemplo, para calcular a média deve ser usada a seguinte função de agregação:');
INSERT INTO questao (texto_questao) VALUES ('No que diz respeito à normalização em bancos de dados, duas formas normais são descritas a seguir.

I. Se somente todos os domínios básicos contiverem exclusivamente valores atômicos. Para atingir esta forma normal deve-se eliminar os grupos de repetição.
II. Se e somente se todos os atributos não chave forem totalmente dependentes da chave primária.

As descrições em I e II indicam condições que devem ser atendidas, respectivamente, pelas seguintes formas normais:');
INSERT INTO questao (texto_questao) VALUES ('No que diz respeito às consultas SQL em bancos de dados, duas cláusulas devem ser utilizadas na sintaxe do comando SELECT com as finalidades especificadas a seguir. 

I. Para expressar a condição que deve satisfazer cada grupo. 
II. Para ordenar os registros selecionados com uma ordem específica. 

As cláusulas I e II são, respectivamente:');
INSERT INTO questao (texto_questao) VALUES ('Em PGSQL, é usado, para o operador de atribuição, o seguinte símbolo:');
INSERT INTO questao (texto_questao) VALUES ('Em TSQL, um comando permite a remoção de uma ou mais definições de tabela e todos os dados, índices, gatilhos, restrições e especificações de permissão dessas tabelas. Esse comando é:');
INSERT INTO questao (texto_questao) VALUES ('Existem diversas notações para o Modelo Entidade-Relacionamento. A notação original foi proposta por Peter Chen e é composta de entidades, relacionamentos, atributos, representados, respectivamente, por:');
INSERT INTO questao (texto_questao) VALUES ('Considere a existência da seguinte tabela de um Banco de Dados relacional:

                              Produto (ID, Item, Tipo, Custo)

A consulta SQL para obter o Custo médio dos Itens de cada Tipo de Produto é

                        SELECT Tipo, AVG (Custo)
                        FROM Produto
                        Cláusula 3

O conteúdo da Cláusula 3 para completar a consulta e atender o especificado na questão');
INSERT INTO questao (texto_questao) VALUES ('Assinale a alternativa que corresponde ao recurso do modelo de entidade-relacionamento, cuja definição é “ser um conjunto de um ou mais atributos que, tomados coletivamente, permite-se identificar de maneira unívoca uma entidade em um conjunto de entidades”:');
INSERT INTO questao (texto_questao) VALUES ('A estrutura básica de uma expressão SQL consiste em três cláusulas. Assinale-as:');
INSERT INTO questao (texto_questao) VALUES ('Sobre o modelo de entidade-relacionamento, assinale a alternativa correta:');
INSERT INTO questao (texto_questao) VALUES ('Durante a modelagem de um projeto de banco de dados é necessário aplicar o processo de normalização. Esse processo é composto por várias regras ou “forma normal”. Analise as afirmativas a seguir:

I – A primeira forma normal (1FN) diz que toda relação deve ter uma chave primária e deve-se garantir que todo atributo seja atômico.
II – A segunda forma normal (2FN) diz que toda relação deve estar na 2FN e devem-se eliminar dependências funcionais transitivas, ou seja, todo atributo não chave deve ser mutuamente independente.
III – A terceira forma normal (3FN) diz que devem-se eliminar dependências funcionais parciais, ou seja, todo atributo não chave deve ser totalmente dependente da chave primária.

Assinale a alternativa correta:');
INSERT INTO questao (texto_questao) VALUES ('Na fase de modelagem de um banco de dados, o modelo que analisa os limites impostos por alguma tecnologia de banco de dados é o:');
INSERT INTO questao (texto_questao) VALUES (' Analise as afirmações a seguir a respeito de Store Procedure:

I – Uma Store Procedure é um procedimento armazenado em um arquivo executável que pode ser chamado através de comandos SQL.
II – Uma Store Procedure armazena tarefas repetitivas dentro de um banco de dados e aceita parâmetros de entrada para que a tarefa seja efetuada de acordo com a necessidade individual.
III – Uma Store Procedure é disparada automaticamente após a execução de Insert, ou Update, ou Delete.

Assinale a alternativa correta:');
INSERT INTO questao (texto_questao) VALUES ('Como é conhecido em banco de dados o processo de normalização que requer apenas que todos os atributos sejam atômicos, ou seja, não contenham repetições dentro de um campo?');
INSERT INTO questao (texto_questao) VALUES ('Uma entidade fraca na modelagem conceitual de banco de dados é a que se caracteriza');
INSERT INTO questao (texto_questao) VALUES ('Um banco de dados relacional pode ser definido como um(a)');
INSERT INTO questao (texto_questao) VALUES ('Para responder a esta questão, sobre os níveis de abstração de um SGBD, leia cuidadosamente as afirmações a seguir.

I. O nível Físico é o nível mais alto de abstração e descreve como os dados estão realmente armazenados. 
II. O nível Conceitual descreve todos os dados que estão armazenados de fato no banco de dados e as relações existentes entre eles.
III. O nível de Visões descreve o banco de dados em partes que são de interesse de cada usuário ou aplicação. 

Está correto o que se afirma em:');
INSERT INTO questao (texto_questao) VALUES ('Assinale a alternativa que apresenta as palavras que preenchem, respectivamente, as lacunas do seguinte texto, sobre os níveis de independência de um banco de dados relacional. 

A independência física de dados é a habilidade de se modificar o esquema _______ sem a necessidade de rescrever o modelo conceitual, enquanto a independência ________ de dados é a habilidade de se modificar o esquema _______ sem a necessidade de reescrever as aplicações.');
INSERT INTO questao (texto_questao) VALUES ('Considere o seguinte código SQL:

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

será');
INSERT INTO questao (texto_questao) VALUES ('Em um banco de dados, a tabela Pessoa foi criada com a seguinte instrução:

CREATE TABLE Pessoa (     PessoaID int ,
                                           Nome varchar (255) ,
                                           Sobrenome varchar (255),
                                           Endereco varchar (255) ,
                                           Cidade varchar (255)) ;

Após a criação, a tabela foi preenchida, porém o programador percebeu que todos os Nomes foram colocados no lugar do Sobrenome e vice-versa.

Que instrução SQL pode ser usada para realizar a troca, corrigindo a base?');