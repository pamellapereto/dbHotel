/* Banco de dados para gerenciamento de um hotel */
create database dbHotel;
show databases;
use dbHotel;


create table funcionarios (
	idFunc int primary key auto_increment,
    nomeFunc varchar(100) not null,
    login varchar(20) not null unique,
    email varchar(50) not null,
    senha varchar(255) not null,
    cargo varchar(20)
);
describe funcionarios;

insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Administrador", "admin", "administrador@gmail.com", md5("admin"), "Administrador");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Pamella Pereto", "pamellapereto", "pamellapereto@gmail.com", md5("123@senac"), "TI");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Breno Silva", "brenosilva", "brenosilva@gmail.com", md5("123@senac"), "Gerencia");
insert into funcionarios(nomeFunc, login, email, senha, cargo) values ("Victória Cardoso", "victoriacardoso", "victoriacardoso@gmail.com", md5("123@senac"), "Gerencia");
insert into funcionarios(nomeFunc, login, email, senha) values ("Laura Lopes", "lauralopes", "lauralopes@gmail.com", md5("123@senac"));

select * from funcionarios;
select login as Login, senha as Senha from funcionarios where login = "admin" and senha = md5("admin");
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc asc;  
select idFunc as ID_Funcionario, nomeFunc as Nome_Funcionario from funcionarios order by nomeFunc desc;
select IDFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as Cargo_Funcionario from funcionarios order by IDFunc desc;
select IDFunc as ID_Funcionario, nomeFunc as Nome_Funcionario, cargo as Cargo_Funcionario from funcionarios where cargo <> 'null' order by IDFunc desc;
select * from funcionarios where cargo = "Gerência" order by nomeFunc asc;


create table quartos (
	idQuarto int primary key auto_increment,
    andar varchar(10) not null,
    numeroQuarto varchar(10) not null,
    tipoQuarto varchar(50) not null,
    ocupacaoMax int not null,
    situacao char(3) not null,
    nome varchar(50) not null,
    descricao text,
    foto varchar(255) not null,
    preco decimal(10,2) not null,  
    cafeDaManha char(3) not null,
    precoCafe decimal(10,2),
    tipoCama varchar(20),
    varanda char(3)
);
describe quartos;

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, precoCafe, tipoCama, varanda) values
 ("5º", "505", "Superior Premier", 3, "não", "Familiar", "O quarto de 32m² com piso frio, varanda - vista para o mar. Oferece ar condicionado
 individual, TV LCD 42'', wi-fi grátis, cofre digital, frigobar abastecido e banheiro com secador de cabelo e amenities e mesa de trabalho.",
 "https://imagens-revista.vivadecora.com.br/uploads/2019/05/quarto-de-hotel-decorado-em-cores-neutras-com-amplas-janelas.jpg", 750.90, "sim",
 60.00, "Queen Size", "sim");

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, precoCafe, tipoCama, varanda) values
 ("7º", "703", "Superior Premier Twin", 5, "sim", "Familiar", "O quarto de 54m² com piso frio, varanda - vista para o mar. Oferece ar condicionado
 individual, TV LCD 64'', Playstation 5, wi-fi grátis, cofre digital, frigobar abastecido e banheiro com secador de cabelo, chapinha e amenities e mesa de trabalho.",
 "https://www.revistasim.com.br/wp-content/uploads/2021/03/revistaSIM_Arquitetura_Quarto-de-hotel-em-casa_Destaque_Credito_Eduardo-Pozella-1155x500.jpg",
 1150.90, "sim", 60.00, "King Size", "sim");

insert into quartos (andar, numeroQuarto, tipoQuarto, ocupacaoMax, situacao, nome, descricao, foto, preco, cafeDaManha, precoCafe, tipoCama, varanda) values
 ("2º", "203", "Classic Premier", 2, "não", "Familiar", "O quarto de 84m² com piso frio, varanda - vista para o mar. Oferece ar condicionado
 individual, TV LCD 32'', wi-fi grátis, cofre digital, frigobar abastecido e banheiro com secador de cabelo e amenities e mesa de trabalho.",
 "https://i.pinimg.com/736x/54/99/8d/54998daa4afc482a4b42b1dd7a9a53b4.jpg", 650.90, "sim", 60.00, "Queen Size", "sim");
 
select * from quartos;
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
    celular varchar(20) not null
);
describe clientes;

insert into clientes (nomeCompleto, cpf, rg, email, celular) values
("José de Assis", "829.942.570-09", "48.353.888-7", "josedeassis@gmail.com", "(96) 99338-2803");
insert into clientes (nomeCompleto, cpf, rg, email, celular) values
("Cecília Vitória Barros", "839.909.408-05", "32.059.425-7", "ceciliabarros@gmail.com", "(11) 99134-4682");

select * from clientes;


create table pedido (
	idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum("Pendente", "Finalizado", "Cancelado") not null,
    idCliente int not null,
    foreign key (idCliente) references clientes(idCliente)
);
describe pedido;

insert into pedido (statusPedido, idCliente) values ("Pendente", 1);
insert into pedido (statusPedido, idCliente) values ("Finalizado", 2);

select * from pedido;
select * from pedido inner join clientes on pedido.idCliente = clientes.idCliente;


create table reservas (
	idReserva int primary key auto_increment,
    idPedido int not null,
    idQuarto int not null,
	foreign key (idPedido) references pedido(idPedido),
    foreign key (idQuarto) references quartos(idQuarto),
    checkin datetime not null,
    checkout datetime not null
);
describe reservas;

insert into reservas (idPedido, idQuarto, checkin, checkout) values (1, 1, "2023-10-21 14:00:00", "2023-10-25 12:00:00");
insert into reservas (idPedido, idQuarto, checkin, checkout) values (1, 3, "2023-10-21 14:00:00", "2023-10-25 12:00:00");

insert into reservas (idPedido, idQuarto, checkin, checkout) values (2, 2, "2023-10-17 14:00:00", "2023-10-23 12:00:00");

select * from reservas;


/*OBJETIVO: selecionar o nome do cliente, seu cpf e email, o id do pedido do cliente, a data do pedido, quais quartos fazem parte desse pedido, os tipos dos quartos e seus nomes, assim como
os andares em que estão, os números de cada quarto, seus preços e suas datas de checkin e checkout. */


select clientes.nomeCompleto, clientes.cpf, clientes.email, pedido.idPedido, pedido.dataPedido, quartos.tipoQuarto,
quartos.nome, quartos.andar, quartos.numeroQuarto, quartos.preco, reservas.checkin, reservas.checkout from
clientes inner join pedido on clientes.idCliente = pedido.idCliente inner join
reservas on reservas.idPedido = pedido.idPedido inner join quartos
on reservas.idQuarto = quartos.idQuarto;


/*Soma total do pedido feito pelo cliente */
select sum(quartos.preco) as Total from reservas inner join quartos on reservas.idQuarto = quartos.idQuarto where idPedido = 1;



