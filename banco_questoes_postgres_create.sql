CREATE TABLE "Disciplina" (
	"codigo_disciplina" serial NOT NULL,
	"nome_disciplina" varchar(256) NOT NULL,
	"departamento_disciplina" varchar(256) NOT NULL,
	"professor_disciplina" varchar(256) NOT NULL,
	CONSTRAINT Disciplina_pk PRIMARY KEY ("codigo_disciplina")
);


CREATE TABLE "Aluno" (
	"ra_aluno" serial NOT NULL,
	"cpf_aluno" varchar(14) NOT NULL UNIQUE,
	"nome_aluno" varchar(256) NOT NULL,
	"email_aluno" varchar(50) NOT NULL,
	"tel_residencial" varchar(15),
	"tel_celular" varchar(15) NOT NULL,
	"codigo_disciplina" integer NOT NULL,
	CONSTRAINT Aluno_pk PRIMARY KEY ("ra_aluno")
);



CREATE TABLE "Responde" (
	"ra_aluno" integer NOT NULL,
	"id_questao" integer NOT NULL,
	"id_resposta" integer NOT NULL,
	"opcao_aluno" BOOLEAN NOT NULL,
	CONSTRAINT Responde_pk PRIMARY KEY ("ra_aluno","id_questao","id_resposta")
);



CREATE TABLE "Questao" (
	"id_questao" serial NOT NULL,
	"texto_questao" varchar(1000) NOT NULL,
	"peso" integer(1) NOT NULL,
	"codigo_disciplina" integer NOT NULL,
	CONSTRAINT Questao_pk PRIMARY KEY ("id_questao")
);



CREATE TABLE "Alternativa" (
	"id_questao" integer NOT NULL,
	"id_alternativa" serial NOT NULL,
	"texto_alternativa" varchar(500) NOT NULL,
	"eh_correta" BOOLEAN NOT NULL,
	CONSTRAINT Alternativa_pk PRIMARY KEY ("id_questao","id_alternativa")
);




ALTER TABLE "Aluno" ADD CONSTRAINT "Aluno_fk0" FOREIGN KEY ("codigo_disciplina") REFERENCES "Disciplina"("codigo_disciplina");

ALTER TABLE "Responde" ADD CONSTRAINT "Responde_fk0" FOREIGN KEY ("ra_aluno") REFERENCES "Aluno"("ra_aluno");
ALTER TABLE "Responde" ADD CONSTRAINT "Responde_fk1" FOREIGN KEY ("id_questao") REFERENCES "Questao"("id_questao");

ALTER TABLE "Questao" ADD CONSTRAINT "Questao_fk0" FOREIGN KEY ("codigo_disciplina") REFERENCES "Disciplina"("codigo_disciplina");

ALTER TABLE "Alternativa" ADD CONSTRAINT "Alternativa_fk0" FOREIGN KEY ("id_questao") REFERENCES "Questao"("id_questao");

