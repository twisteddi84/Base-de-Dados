create table medicamentos4.Medico(
	num_identificacao_SNS int not null,
	nome varchar(30) not null,
	especialidade varchar(50) not null,
	constraint PK_Medico primary key(num_identificacao_SNS)
)
go

create table medicamentos4.Paciente(
	num_utente int not null,
	nome varchar(30) not null,
	data_nascimento date not null,
	endereco varchar(30) not null,
	constraint PK_Paciente primary key(num_utente)
)
go

create table medicamentos4.Farmaco(
	formula varchar(100) not null,
	constraint PK_Farmaco primary key(formula)
)
go
create table medicamentos4.Farmacia(
	NIF int check(NIF>=100000000 and NIF<=999999999) not null,
	nome varchar(30) not null,
	endereco varchar(30) not null,
	telefone int check(telefone>=100000000 and telefone<=999999999) not null,
	constraint PK_Farmacia primary key(NIF)
)
go

create table medicamentos4.Farmaco_Farmacia(
	formula varchar(100) not null,
	farmacia_NIF int check(farmacia_NIF>=100000000 and farmacia_NIF<=999999999) not null,
	nome_comercial varchar(30) not null,
	constraint FK_Farmaco_Farmacia foreign key(formula) references medicamentos4.Farmaco(formula),
	constraint FK_Farmacia foreign key(farmacia_NIF) references medicamentos4.Farmacia(NIF)
)
go

create table medicamentos4.Prescricao(
	numero_unico int not null,
	data_prescricao date not null,
	medico int not null,
	paciente int not null,
	farmaco varchar(100) not null,
	constraint PK_Prescricao primary key(numero_unico),
	constraint FK_MedicoPrescricao foreign key(medico) references medicamentos4.Medico(num_identificacao_SNS),
	constraint FK_PacientePrescricao foreign key(paciente) references medicamentos4.Paciente(num_utente),
	constraint FK_FarmacoPrescricao foreign key(farmaco) references medicamentos4.Farmaco(formula)
)
go

create table medicamentos4.Companhias_Farmaceuticas(
	nome varchar(100) not null,
	telefone int check(telefone>=100000000 and telefone<=999999999) not null,
	registo_nacional int not null,
	endereco varchar(40) not null,
	constraint PK_Companhias_Farmaceuticas primary key(telefone)
)
go


create table medicamentos4.Companhia_Farmaco(
	telefone int check(telefone>=100000000 and telefone<=999999999) not null,
	formula varchar(100) not null,
	nome_unico varchar(50) not null,
	constraint FK_Companhia foreign key(telefone) references medicamentos4.Companhias_Farmaceuticas(telefone),
	constraint FK_Farmaco foreign key(formula) references medicamentos4.Farmaco(formula)
)
go


create table medicamentos4.Processamentos(
	data_processamento date not null,
	farmacia_NIF int check(farmacia_NIF>=100000000 and farmacia_NIF<=999999999) not null,
	prescricao_numero int not null,
	constraint PK_Processamentos primary key(data_processamento),
	constraint FK_ProcessamentosFarmacia foreign key(farmacia_NIF) references medicamentos4.Farmacia(NIF),
	constraint FK_ProcessamentosPrescricao foreign key(prescricao_numero) references medicamentos4.Prescricao(numero_unico)
)
go