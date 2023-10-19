/* Mostrar os bancos de dados existentes no servidor */
show databases;

/* Criar um novo banco */
create database dbHotel;

/* Selecionar o banco de dados */
use dbHotel;

/*Criar uma nova tabela */
create table funcionarios (
	/*int se refere ao tipo do campo na tabela 
    primary key determina que o campo idFunc seja uma chave primária responsável por identificar cada funcionário 
    auto_increment determina que o MySQL dê um id novo a cada cadastro */
	idFunc int primary key auto_increment,
	/* varchar é a quantidade variável de caracteres no nome (nesse caso, até 100 caracteres)
    not null determina que o campo seja obrigatório */
    nomeFunc varchar (100) not null,
    /* unique determina que o campo seja único e o valor não possa repetir */
    login varchar(20) not null unique,
    senha varchar(255) not null,
    cargo varchar(20)
);

/* Mostrar as tabelas */
show tables;

insert into funcionarios(nomeFunc, login, senha, cargo) values ("Administrador", "admin", md5("admin"), "Administrador");

select * from funcionarios;




