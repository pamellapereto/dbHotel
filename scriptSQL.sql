show databases;

/* SELECIONAR O BANCO */
use dbPamella;


/* Excluir a tabela do banco */
drop table funcionarios;


/* Adicionar o campo email à tabela funcionarios */
alter table funcionarios add column email varchar(50) not null;



/* Excluir um campo da tabela */
alter table funcionarios drop column email;



/*Modificar o campo email para que se torne obrigatório, ou seja, não nulo (not null) */
alter table funcionarios modify column email varchar(50) not null;



/*Reposicionar o campo email para que ele fique após o campo login */
alter table funcionarios modify column email varchar(50) not null after login;





/* Criar uma nova tabela */
create table funcionarios (
	/*Int: se refere ao tipo do campo na tabela.
    primary key: determina que o campo idFunc seja uma chave primária responsável por identificar cada funcionário.
    auto_increment: determina que o MySQL dê um id novo a cada cadastro. */
	idFunc int primary key auto_increment,
    
    /* varchar: é a quantidade variável de caracteres no nome (nesse caso, até 100 caracteres).
    not null: determina que o campo seja obrigatório */
    nomeFunc varchar(100) not null,
    /* unique: determina que o campo seja único e o valor não possa repetir */
    login varchar(20) not null unique,
    senha varchar(255) not null,
    cargo varchar(20)
);

/*descreve os campos da tabela funcionarios */
describe funcionarios;


/* Mostrar as tabelas */
show tables;

/* CREATE */
/* Inserir um novo funcionário na tabela, com nome, login, senha criptografada e cargo */
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Administrador", "admin", md5("admin"), "Administrador");

/* Inserir um novo funcionário na tabela, com nome, login, senha criptografada e cargo */
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Pamella Pereto", "pamellapereto", md5("123@senac"), "TI");

/* Inserir um novo funcionário na tabela, com nome, login, senha criptografada e cargo */
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Breno Silva", "brenosilva", md5("123@senac"), "Contabilidade");

/* Inserir um novo funcionário na tabela, com nome, login, senha criptografada e cargo */
insert into funcionarios(nomeFunc, login, senha, cargo) values ("Victória Cardoso", "victoriacardoso", md5("123@senac"), "RH");

/* Inserir um novo funcionário na tabela, com nome, login, senha criptografada */
insert into funcionarios(nomeFunc, login, senha) values ("Laura Lopes", "lauralopes", md5("123@senac"));

/*Inserir um novo funcionário na tabela com nome, login, senha criptografada */
insert into funcionarios(nomeFunc, login, senha) values ("Fellipe Coelho", "fellipe", md5("123@senac"));

/* READ */
/* Ler/Buscar as informações da tabela funcionários */
select * from funcionarios;


/* Buscar o login e a senha da tabela funcionarios em que login seja admin e senha seja admin */
select login as Batata, senha as Senha from funcionarios where login = "admin" and senha = md5("admin");
   

/* UPDATE */
/* Atualizar o campo login na tabela funcionarios especificando o id */
update funcionarios set login = "fellipecoelho" where idFunc = 1;

update funcionarios set cargo = "Gerência" where idFunc = 3;




   
   