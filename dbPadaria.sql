show databases;

create database dbPadaria;

use dbPadaria;


create table fornecedores (
	idFornecedor int primary key auto_increment,
    nomeFornecedor varchar(50) not null,
    cnpjFornecedor varchar(20) not null,
    telefoneFornecedor varchar(20),
    emailFornecedor varchar(50) not null unique,
    cep varchar(9),
    enderecoFornecedor varchar(100),
    numeroEndereco varchar(10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

insert into fornecedores (nomeFornecedor, cnpjFornecedor, emailFornecedor) values ("Ana Rosa Confeitaria", "03.266.407/0001-53", "anarosaconfeitaria@gmail.com");
select * from fornecedores;

create table produtos (
	idProduto int primary key auto_increment,
    nomeProduto varchar(50) not null,
    descricaoProduto text,
    precoProduto decimal (10,2) not null,
    estoqueProduto int not null,
    categoriaProduto enum("Pães", "Bolos", "Confeitaria", "Salgados"),
    idFornecedor int not null,
    foreign key (idFornecedor) references fornecedores (idFornecedor)
);

alter table produtos add ingredientesProduto text after descricaoProduto;
alter table produtos add pesoProduto decimal(10,2) after ingredientesProduto;
alter table produtos add validadeProduto date after pesoProduto;

describe produtos;


insert into produtos (nomeProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Bolo de laranja", 44.99, 5, "Bolos", 1); 
insert into produtos (nomeProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values ("Farinha", 14.90, 7, "Confeitaria", 1); 

insert into produtos (nomeProduto, ingredientesProduto, pesoProduto, validadeProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values
("Coxinha", "sem glúten", 300.00, "2023-12-07", 8.90, 10, "Salgados", 1);


insert into produtos (nomeProduto, ingredientesProduto, pesoProduto, validadeProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor) values
("Bolinho de queijo", "sem lactose", 120, "2023-12-07", 13.50, 5, "Salgados", 1);

insert into produtos (nomeProduto, ingredientesProduto, pesoProduto, validadeProduto, precoProduto,
estoqueProduto, categoriaProduto, idFornecedor) values
("Pão italiano", "trigo", 0.450, "2023-12-07", 7.90, 5, "Salgados", 1);


select * from produtos;

select * from produtos where categoriaProduto = "Pães";

select * from produtos where precoProduto < 50.00 order by precoProduto asc;

create table clientes (
	idCliente int primary key auto_increment,
    nomeCliente varchar(50),
    cpfCliente varchar(15) not null unique, 
    telefoneCliente varchar(20),
    emailCliente varchar(50) unique,
    cep varchar (9),
    enderecoCliente varchar(100),
    numeroEndereco varchar (10),
    bairro varchar(40),
    cidade varchar(40),
    estado char(2)
);

insert into clientes (nomeCliente, cpfCliente, telefoneCliente, emailCliente, cep, enderecoCliente, numeroEndereco, bairro, cidade, estado) values 
("Julio vaz", "988.189.750-56", "(21) 2521-3564", "julio2@gmail.com", "22790-520", "Rua Leiloeiro Ernani Mello", "4667", "Recreio dos Bandeirantes", "Rio de Janeiro", "RJ");

select * from clientes;

create table pedidos (
	idPedido int primary key auto_increment,
    dataPedido timestamp default current_timestamp,
    statusPedido enum ("Pendente", "Finalizado", "Cancelado") not null,
    idCliente int not null,
    foreign key (idCliente) references clientes (idCliente)
);

insert into pedidos (statusPedido, idCliente) values ("Pendente", 1);

select * from pedidos inner join clientes on pedidos.idCliente = clientes.idCliente;

create table itensPedidos (
	idItensPedidos int primary key auto_increment,
    idPedido int not null,
    idProduto int not null,
    foreign key (idPedido) references pedidos (idPedido),
    foreign key (idProduto) references produtos (idProduto),
	quantidade int not null
);

select idPedido from pedidos;
insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 1, 3);
insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 2, 5);


/* OBJETIVO: consultar o nome do cliente que abriu seu pedido em determinada data para verificar o que ele comprou de itens nesse pedido e a respectiva quantidade,
ou seja, quais produtos e quanto de cada um 
QUEM COMPROU? QUANDO COMPROU? O QUE COMPROU? QUANTO COMPROU? */

select clientes.nomeCliente, pedidos.idPedido, pedidos.dataPedido, itensPedidos.quantidade, produtos.nomeProduto, produtos.precoProduto
from clientes inner join pedidos on clientes.idCliente = pedidos.idCliente inner join
itensPedidos on pedidos.idPedido = itensPedidos.idPedido inner join
produtos on produtos.idProduto = itensPedidos.idProduto;


select sum(produtos.precoProduto * itensPedidos.quantidade) as Total from produtos inner join itensPedidos on produtos.idProduto = itensPedidos.idProduto where idPedido = 1;



/*POSSÍVEIS FILTROS PARA PADARIA */

/* Filtrar produtos por validade (por exemplo, produtos com validade maior que a data atual,
ou seja, PRODUTOS QUE NÃO ESTÃO VENCIDOS) */
select * from produtos where validadeProduto > curdate();




/* Filtrar produtos que contenham um ingrediente específico */
select * from produtos where ingredientesProduto like "%gluten%";

/*ATIVIDADE: FILTRAR PÃES QUE NÃO SEJAM FEITOS À BASE DE FARINHA DE TRIGO, COM VALOR ATÉ 7.90*/
/*QUERO UM RESULTADO AO MENOS! */

select * from produtos where ingredientesProduto like "%f%" and precoProduto <= 7.90; 











