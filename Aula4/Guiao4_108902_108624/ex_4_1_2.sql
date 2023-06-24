create table voos4.Airport(
	airport_code smallint not null,
	city varchar(50) not null,
	[state] varchar(50) not null,
	[name] varchar(50) not null,
	constraint PK_Airport primary key(airport_code)
)
go

create table voos4.Airplane_Type(
	[type_name] varchar(50) not null,
	max_seats int not null,
	company varchar(50) not null,
	constraint PK_Airplane_Type primary key([type_name])
)
go


create table voos4.Can_Land(
	[type_airplane] varchar(50) not null,
	airport_code smallint not null,
	constraint FK_Airplane_Type foreign key([type_airplane]) references voos4.Airplane_Type([type_name]),
	constraint FK_Airport foreign key(airport_code) references voos4.Airport(airport_code)
)
go

create table voos4.Airplane(
	airplane_id int not null,
	total_num_seats int not null,
	[type_name] varchar(50) not null,
	constraint PK_Airplane primary key(airplane_id),
	constraint FK_AirplaneAirplane_Type foreign key([type_name]) references voos4.Airplane_Type([type_name])
)
go
create table voos4.Flight(
	number int not null,
	airline varchar(100) not null,
	weekdays varchar(100) not null,
	constraint PK_Flight primary key(number)
)
go


create table voos4.Flight_Leg(
	leg_num int not null unique,
	flight_number int not null references voos4.Flight(number),
	schedule_dep_time datetime not null,
	schedule_arr_time datetime not null,
	arrival_airport smallint not null,
	departure_airport smallint not null,
	constraint PK_Flight_Leg primary key(leg_num,flight_number),
	constraint FK_Flight_Leg_Airport foreign key(arrival_airport) references voos4.Airport(airport_code),
	constraint FK_Flight_Leg_Airport2 foreign key(departure_airport) references voos4.Airport(airport_code),
)
go

create table voos4.Leg_Instance(
	[date] date not null unique,
	leg_num int not null references voos4.Flight_Leg(leg_num),
	flight_number int not null references voos4.Flight(number),
	num_available_seats int not null,
	dep_time datetime not null,
	arr_time datetime not null,
	arrival_airport smallint not null,
	departure_airport smallint not null,
	airplane_id int not null,
	constraint PK_Leg_Instance primary key([date],leg_num,flight_number),
	constraint FK_Leg_Instance_Airport foreign key(arrival_airport) references voos4.Airport(airport_code),
	constraint FK_Leg_Instance_Airport2 foreign key(departure_airport) references voos4.Airport(airport_code),
	constraint FK_Leg_InstanceAirplane foreign key(airplane_id) references voos4.Airplane(airplane_id)
)
go

create table voos4.Seat(
	seat_num int not null,
	constraint PK_Seat primary key(seat_num)
)
go

create table voos4.Reservations(
	seat_num int not null references voos4.Seat(seat_num),
	[date] date not null references voos4.Leg_Instance([date]),
	leg_num int not null references voos4.Flight_Leg(leg_num),
	flight_number int not null references voos4.Flight(number),
	constraint PK_Reservations primary key(seat_num,[date],leg_num,flight_number),
)
go

create table voos4.Fare(
	code int not null,
	flight_number int not null references voos4.Flight(number),
	amount int not null,
	restrictions varchar(200) null,
	constraint PK_Fare primary key(code,flight_number)
)
go