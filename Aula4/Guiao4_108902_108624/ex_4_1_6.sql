create table atl4.Turmas(
	identificador smallint not null,
	ano_letivo smallint not null,
	designacao varchar(100) not null,
	num_max_alunos smallint not null,
	contacto_telefonico int check(contacto_telefonico>=100000000 and contacto_telefonico<=999999999) not null,
	escolaridade smallint not null,
	constraint PK_Turmas primary key(identificador)
)
go


create table atl4.Professor(
	num_funcionario smallint not null,
	nome varchar(100) not null,
	num_cc smallint not null,
	morada varchar(100) not null,
	email varchar(100) not null,
	contacto_telefonico int check(contacto_telefonico>=100000000 and contacto_telefonico<=999999999) not null,
	data_nascimento date not null,
	turma smallint not null,
	constraint PK_Professor primary key(num_funcionario),
	constraint FK_ProfessorTurmas foreign key(turma) references atl4.Turmas(identificador)
)
go

create table atl4.Aluno(
	num_cc smallint not null,
	nome varchar(100) not null,
	morada varchar(100) not null,
	data_nascimento date not null,
	turma smallint not null,
	constraint PK_Aluno primary key(num_cc),
	constraint FK_AlunoTurmas foreign key(turma) references atl4.Turmas(identificador)
)
go

create table atl4.Atividades(
	identificador smallint not null,
	designacao varchar(100) not null,
	custo smallint not null,
	constraint PK_Atividades primary key(identificador)
)
go

create table atl4.Atividades_Turmas(
	identificador_atividade smallint not null,
	identificador_turma smallint not null,
	constraint FK_Atividade foreign key(identificador_atividade) references atl4.Atividades(identificador),
	constraint FK_Turma foreign key(identificador_turma) references atl4.Turmas(identificador)
)
go

create table atl4.Lista_Autorizacao_Levar_Buscar(
	num_cc smallint not null,
	nome varchar(100) not null,
	email varchar(100) not null,
	contacto_telefonico int check(contacto_telefonico>=100000000 and contacto_telefonico<=999999999) not null,
	relacao_com_aluno varchar(50) not null,
	morada varchar(100) not null,
	data_nascimento date not null,
	cc_aluno smallint not null,
	constraint PK_Lista_Autorizacao_Levar_Buscar primary key(num_cc),
	constraint FK_ListaAluno foreign key(cc_aluno) references atl4.Aluno(num_cc)
)
go

create table atl4.EncarregadoEducacao(
	num_cc smallint not null,
	nome varchar(100) not null,
	email varchar(100) not null,
	contacto_telefonico int check(contacto_telefonico>=100000000 and contacto_telefonico<=999999999) not null,
	relacao_com_aluno varchar(50) not null,
	morada varchar(100) not null,
	data_nascimento date not null,
	cc_aluno smallint not null,
	constraint PK_EncarregadoEducacao primary key(num_cc),
	constraint FK_EncarregadoEducacaoAluno foreign key(cc_aluno) references atl4.Aluno(num_cc)
)
go