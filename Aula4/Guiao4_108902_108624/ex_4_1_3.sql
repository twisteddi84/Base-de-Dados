create table stocks4.Empresa(
	codigo_armazem smallint not null,
	constraint PK_Empresa primary key(codigo_armazem)
)
go

create table stocks4.Produto(
	codigo smallint not null,
	nome varchar(50) not null,
	taxa_de_iva smallint not null,
	preco smallint not null,
	constraint PK_codigo primary key(codigo)
)
go

create table stocks4.Armazem_Produtos(
	codigo smallint not null,
	codigo_armazem smallint not null,
	num_produtos_armazem int not null,
	constraint FK_Produto foreign key(codigo) references stocks4.Produto(codigo),
	constraint FK_Empresa foreign key(codigo_armazem) references stocks4.Empresa(codigo_armazem)
)
go

create table stocks4.Tipo_Fornecedor(
	codigo_interno smallint not null,
	constraint PK_Tipo_Fornecedor primary key(codigo_interno)
)
go

create table stocks4.Fornecedor(
	NIF smallint check(NIF>=100000000 and NIF<=999999999) not null,
	nome varchar(30) not null,
	condicoes_pagamento varchar(200) not null,
	endereco varchar(30) not null,
	num_fax smallint null,
	codigo_interno smallint not null,
	constraint PK_Fornecedor primary key(NIF),
	constraint FK_Tipo_Fornecedor foreign key(codigo_interno) references stocks4.Tipo_Fornecedor(codigo_interno)
)
go

create table stocks4.Encomenda(
	num_encomenda smallint not null,
	data_encomenda date not null,
	NIF smallint check(NIF>=100000000 and NIF<=999999999) not null,
	constraint PK_Encomenda primary key(num_encomenda),
	constraint FK_Fornecedor foreign key(NIF) references stocks4.Fornecedor(NIF)
)
go

create table stocks4.Encomenda_Produtos(
	num_encomenda smallint not null,
	codigo smallint not null,
	quantidade_produto int not null,
	constraint FK_Encomenda foreign key(num_encomenda) references stocks4.Encomenda(num_encomenda),
	constraint FK_ProdutoEncomenda foreign key(codigo) references stocks4.Produto(codigo)
)
go