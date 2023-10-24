show databases;

show tables;

/* SELECIONAR O BANCO */
use dbPamella;

use dbHotel;

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

insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Nathan Matheus", "nathanmatheus", "nathanmatheus@yahoo.com.br", md5("123@senac"), "Gerência");

/* READ */
/* Ler/Buscar as informações da tabela funcionários */
select * from funcionarios;

/* Buscar o login e a senha da tabela funcionarios em que login seja admin e senha seja admin */
select login as Login, senha as Senha from funcionarios where login = "admin" and senha = md5("admin");
   
/*Buscar o ID e o nome do funcionário da tabela funcionarios ordenando o nome alfabeticamente (ascendente, de A a Z) */
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc asc;  

/*Buscar o ID e o nome do funcionário da tabela funcionarios ordenando o nome alfabeticamente (descendente, de Z a A) */
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc desc;

/* 
Buscar os campos ID com o apelido ID_Funcionario, nomeFunc com o apelido Nome_Funcionario e cargo com o apelido Cargo_Funcionario
da tabela funcionarios ordenando de forma descendente (do maior ID para o menor) */
select IDFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as Cargo_Funcionario from funcionarios order by IDFunc desc;

/* Buscar os campos ID com apelido ID_Funcionario, nomeFunc com o apelido Nome_Funcionario e cargo com o apelido Cargo_Funcionario
da tabela funcionarios onde cargo seja diferente de nulo e ordenando de forma ascendente o ID (do maior para o menor) 
<> ESTE SINAL SIGNIFICA DIFERENTE, SIGNIFICA ESSE CARINHA AQUI --> ≠
*/
select IDFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as Cargo_Funcionario from funcionarios where cargo <> 'null' order by IDFunc desc;

/* Buscar todos os campos dos funcionários que tenham o cargo de Gerência, ordenando alfabeticamente */
select * from funcionarios where cargo = "Gerência" order by nomeFunc asc;

/* UPDATE */
/* Atualizar o campo login na tabela funcionarios especificando o id */
update funcionarios set login = "fellipecoelho" where idFunc = 1;

update funcionarios set cargo = "Gerência" where idFunc = 3;

/* DELETE */
delete from funcionarios where idFunc = 5;


create table quartos (
	idQuarto int primary key auto_increment,
    andar varchar(10) not null,
    tipoQuarto varchar(50) not null,
    ocupacaoMax int not null,
    situacao char(3) not null,
    nome varchar(50) not null,
    descricao text,
    preco decimal(10,2) not null,    
    tipoCama varchar(20),
    varanda char(3)
);


describe quartos;

alter table quartos add column numeroQuarto varchar(10) not null after andar;

/* ADICIONAR COMANDOS ABAIXO */
alter table quartos add column cafeDaManha char(3) not null after preco;   
alter table quartos add column foto varchar(255) not null after descricao;

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, preco, tipoCama, varanda) values ("5º", "505", "Superior Premier", 3, "não",
"Familiar", "O quarto de 32m² com piso frio, varanda - vista para o mar. Oferece ar condicionado individual, TV LCD 42’’, wi-fi grátis, cofre digital, 
frigobar abastecido e banheiro com secador de cabelo e amenities e mesa de trabalho.", 750.90, "Queen Size", "sim");

update quartos set cafeDaManha = "sim" where idQuarto = 1;
update quartos set foto = "https://imagens-revista.vivadecora.com.br/uploads/2019/05/quarto-de-hotel-decorado-em-cores-neutras-com-amplas-janelas.jpg" where idQuarto = 1;

select * from quartos;


insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, tipoCama, varanda) values
("3º", "302", "Luxo", 2, "sim", "Casal", "O quarto de 23m² com piso frio, sacada com belíssima vista mar. Oferece ar condicionado individual, TV LCD 42’’, wi-fi grátis,
cofre digital, frigobar abastecido, banheiro com secador de cabelo, amenities e mesa de trabalho.",
"https://images.trvl-media.com/lodging/1000000/40000/34900/34877/7ccc8057.jpg?impolicy=resizecrop&rw=500&ra=fit", 572.90, "sim", "King Size", "não");


insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, tipoCama, varanda) values
("6º", "602", "Luxo", 2, "não", "Júnior", "Quarto com wi-fi, frigobar e vista para o mar.",
"https://cf.bstatic.com/xdata/images/hotel/max1024x768/408896408.jpg?k=a03783216a34dd0df1a21cf7bb6527df3b68c3d92bd54b7b4d06b0e116705408&o=&hp=1",
334.90, "sim", "Queen Size", "não");



select * from quartos where situacao = "não" order by preco asc;

select * from quartos where cafeDaManha = "sim" and situacao = "não";

select * from quartos where varanda = "sim" and cafeDaManha = "sim" and situacao = "não";

select * from quartos where preco < 700.00 and situacao = "não";


create table clientes (
	idCliente int primary key auto_increment,
    nomeCompleto varchar(100) not null,
    cpf char(14) not null unique,
    rg char(12) not null unique,
    email varchar(50) unique,
    celular varchar(20) not null,
    numeroCartao varchar(20) not null unique,
	nomeTitular varchar(100) not null, 
    validade date not null,
    cvv char(3) not null,
    checkin datetime not null,
    checkout datetime not null,
    idQuarto int not null,
    foreign key (idQuarto) references quartos (idQuarto)
);

describe clientes;

/* VERIFICAR QUAIS QUARTOS ESTEJAM DISPONÍVEIS */
select * from quartos where situacao = "não";


insert into clientes (nomeCompleto, cpf, rg, email, celular, numeroCartao, nomeTitular, validade, cvv, checkin, checkout, idQuarto) values
("José de Assis", "829.942.570-09", "48.353.888-7", "josedeassis@gmail.com", "(96) 99338-2803", "5526 4863 8286 2543", "José de Assis", "2025-03-31", "452",
"2023-11-02 14:00:00", "2023-11-05 12:00:00", 1);


insert into clientes (nomeCompleto, cpf, rg, email, celular, numeroCartao, nomeTitular, validade, cvv, checkin, checkout, idQuarto) values
("Cecília Vitória Barros", "839.909.408-05", "32.059.425-7", "ceciliabarros@gmail.com", "(11) 99134-4682", "3767 044740 87387", "Cecília Vitória Barros",
"2025-02-28", "924", "2023-10-21 14:00:00", "2023-10-25 12:00:00", 3);


select * from clientes;

/* Buscar TODAS AS INFORMAÇÕES da tabela quartos que está vinculada à tabela clientes pelo campo idQuarto */
select * from quartos inner join clientes on quartos.idQuarto = clientes.idQuarto;

/*Buscar o nome completo e o celular do cliente que alugou o quarto de número 505, pois a tabela quartos está vinculada à tabela clientes pelo campo idQuarto */
select clientes.nomeCompleto, clientes.celular from quartos inner join clientes on quartos.idQuarto = clientes.idQuarto where numeroQuarto = 505;

/*Buscar o nome completo e data/horário do checkout do cliente que alugou o quarto de número 505 */
select clientes.nomeCompleto as Nome, date_format(clientes.checkout, '%d/%m/%Y - %H:%i') as Checkout from quartos inner join clientes
on quartos.idQuarto = clientes.idQuarto where numeroQuarto = 505;


/* ATIVIDADE AVALIATIVA */






   
   