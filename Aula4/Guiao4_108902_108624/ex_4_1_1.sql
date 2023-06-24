create table rent_a_car4.Balcao(
	numero int not null,
	nome varchar(30) not null,
	endereco varchar(30) not null,
	constraint PKBalcao primary key(numero)
)
go

create table rent_a_car4.Cliente(
	NIF int check (NIF>=100000000 and NIF<=999999999) not null,
	nome varchar(30) not null,
	endereco varchar(30) not null,
	num_carta int not null,
	constraint PKCliente primary key(NIF)
)
go

create table rent_a_car4.Tipo_Veiculo(
	codigo smallint not null,
	arcondicionado bit not null,
	designacao varchar(100),
	constraint PKTipo_Veiculo primary key(codigo)
)
go

create table rent_a_car4.Veiculo(
	matricula varchar(8) not null,
	ano smallint check(ano>=1000 and ano<=3000) not null,
	marca varchar(100) not null,
	fk_tipo_veiculo smallint not null,
	constraint PKVeiculo primary key(matricula),
	constraint FKTipo_Veiculo foreign key(fk_tipo_veiculo) references rent_a_car4.Tipo_Veiculo(codigo)
)
go

create table rent_a_car4.Aluguer(
	numero int not null,
	duracao date not null,
	fk_balcao int not null,
	fk_cliente int not null,
	fk_veiculo varchar(8) not null,
	constraint FKBalcao foreign key(fk_balcao) references rent_a_car4.Balcao(numero),
	constraint FKCliente foreign key(fk_cliente) references rent_a_car4.Cliente(NIF),
	constraint FKVeiculo foreign key(fk_veiculo) references rent_a_car4.Veiculo(matricula),
	constraint PKAluguer primary key(numero)
)
go


create table rent_a_car4.Ligeiro(
	codigo smallint not null,
	num_lugares smallint not null,
	portas smallint not null,
	combustivel varchar(20) not null,
	constraint PKLigeiro foreign key(codigo) references rent_a_car4.Tipo_Veiculo(codigo)
)
go

create table rent_a_car4.Pesado(
	codigo smallint not null,
	peso smallint not null,
	passageiros smallint not null,
	constraint PKPesado foreign key(codigo) references rent_a_car4.Tipo_Veiculo(codigo)
)
go

create table rent_a_car4.Similaridade(
	codigo1 smallint not null references rent_a_car4.Tipo_Veiculo(codigo),
	codigo2 smallint not null references rent_a_car4.Tipo_Veiculo(codigo),
)
go