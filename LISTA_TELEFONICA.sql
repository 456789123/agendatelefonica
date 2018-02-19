/* #############################################################################
#                                                                              #
#                                                                              #
#                               Lista telefonica                               #
#                                                                              #
#                                                                              #
################################################################################
*/

/*
################################################################################
#                               gerando as sequences                           #
################################################################################
*/

CREATE SEQUENCE co_seq_contato
	INCREMENT 1
	MINVALUE 0
	MAXVALUE 9999
	START 1
	CACHE 1;

/*
################################################################################
#                              gerando as tabelas                              #
################################################################################
*/

CREATE TABLE TB_OPERADORA (
	COD_OPERADORA  INTEGER     UNIQUE NULL,
	NO_OPERADORA   VARCHAR(20) UNIQUE NULL,
	CATEGORIA      VARCHAR(20) NOT NULL,
	PRECO          INTEGER     NOT NULL,
	PRIMARY KEY (COD_OPERADORA)
);

CREATE TABLE TB_CONTATO (
	COD_SEQ_CONTATO INTEGER     UNIQUE NULL,
	NO_CONTATO      VARCHAR(15) NOT NULL,
	TELEFONE        VARCHAR(10) NOT NULL,
	DATA_CADASTRO   TIMESTAMP   NOT NULL,
	COD_OPERADORA   INTEGER     NOT NULL,
	PRIMARY KEY (COD_SEQ_CONTATO)
);

/*
################################################################################
#              vinculando a sequences na tabela de contato                     #
################################################################################
*/

ALTER TABLE  TB_CONTATO
ALTER COLUMN COD_SEQ_CONTATO
SET DEFAULT  NEXTVAL('co_seq_contato'::regclass);
UPDATE       TB_CONTATO
SET          COD_SEQ_CONTATO = NEXTVAL('co_seq_contato');

/*
################################################################################
#                         realacionando as tabelas                             #
################################################################################
*/

ALTER TABLE    TB_CONTATO
ADD CONSTRAINT fk_contato
FOREIGN KEY    (COD_OPERADORA)
REFERENCES     TB_OPERADORA(COD_OPERADORA);

/*
################################################################################
#                         inserindo os dados                                   #
################################################################################
*/

--                        TB_OPERADORA

INSERT INTO TB_OPERADORA ( COD_OPERADORA, NO_OPERADORA, CATEGORIA, PRECO )
VALUES ( 14, 'Oi', 'Celular', 2 );
INSERT INTO TB_OPERADORA ( COD_OPERADORA, NO_OPERADORA, CATEGORIA, PRECO )
VALUES ( 15, 'Vivo', 'Celular', 1 );
INSERT INTO TB_OPERADORA ( COD_OPERADORA, NO_OPERADORA, CATEGORIA, PRECO )
VALUES ( 21, 'Embratel', 'Fixo', 3 );
INSERT INTO TB_OPERADORA ( COD_OPERADORA, NO_OPERADORA, CATEGORIA, PRECO )
VALUES ( 25, 'GVT', 'Fixo', 1 );
INSERT INTO TB_OPERADORA ( COD_OPERADORA, NO_OPERADORA, CATEGORIA, PRECO )
VALUES ( 41, 'Tim', 'Celular', 2 );


--                        TB_CONTATO

INSERT INTO TB_CONTATO ( NO_CONTATO, TELEFONE, DATA_CADASTRO, COD_OPERADORA )
VALUES ( 'Pedro', '9999-8888', '2017-02-21', 14 );
INSERT INTO TB_CONTATO ( NO_CONTATO, TELEFONE, DATA_CADASTRO, COD_OPERADORA )
VALUES ( 'Ana', '9999-8877', '2017-02-21', 15 );
INSERT INTO TB_CONTATO ( NO_CONTATO, TELEFONE, DATA_CADASTRO, COD_OPERADORA )
VALUES ( 'Maria', '9999-8866', '2017-02-21', 41 );


DROP TABLE TB_CONTATO;
DROP TABLE TB_OPERADORA;
DROP SEQUENCE co_seq_contato;
ALTER TABLE TB_CONTATO    DROP CONSTRAINT fk_contato;


