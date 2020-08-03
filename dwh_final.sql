--Создание новой схемы
create schema dwh_final;

--Создание таблиц справочников
create table Dim_passenger(
passenger_id varchar(15) primary key,
passenger_name varchar(100) not null
);

create table Dim_Aircrafts(
aircraft_code varchar(10) primary key,
model varchar (100) not null
);

create table Dim_Airports(
Airport_code varchar(10) primary key,
Airport_name varchar(100) not null,
City varchar(100) not null
);

create table Dim_Tariffs(
ticket_no bigint primary key,
cost int not null,
fare_conditions varchar(25) not null
);

create table Dim_Calendar (
date_key int primary key,
year int not null,
month int not null,
week int not null,
day int not null,
hour int not null,
week_day int not null
);

--Создание таблицы фактов
create table Fact_flights(
aircraft_code varchar(10) references Dim_Aircrafts (aircraft_code),
passenger_id varchar(15) references dim_passenger (passenger_id),
flight_id bigint primary key,
ticket_no bigint not null,
Passenger_name varchar(100),
Departure_act timestamp not null,
Arrival_act timestamp not null,
Departure_delay int not null,
Arrival_delay int not null,
Departure_airport varchar (100) references dim_airports (airport_code),
Arrival_airport varchar (100)references dim_airports (airport_code),
fare_conditions varchar(25),
cost int,
diff_from_today int,
dept_date_ref int not null,
arriv_date_ref int not null,
FOREIGN KEY (ticket_no) REFERENCES dim_tariffs (ticket_no),
foreign key (dept_date_ref) references dim_calendar (date_key),
foreign key (arriv_date_ref) references dim_calendar (date_key)
);

--Создание таблиц с ошибками
create table Errors_Fact_flights(
flight_id bigInt,
passenger_id varchar(15),
ticket_no bigint,	
error_descr varchar(400)
);

create table Errors_Tarrifs(
flight_id bigInt,
passenger_id varchar(15),
ticket_no bigint,	
error_descr varchar(400)
);

create table Errors_Passenger(
flight_id bigInt,
passenger_id varchar(15),
ticket_no bigint,	
error_descr varchar(400)
);

create table Errors_Aircrafts(
aircraft_code varchar(10),	
error_descr varchar(400)
);

create table Errors_Airports(
Airport_code varchar(10),
Airport_name varchar(100),
error_descr varchar(400)
);

create table Errors_Calendar(
date_key int,
error_descr varchar(400)
);

--Запросы для проверки
select * from dim_airports da ;
select * from dim_aircrafts da ;
select * from dim_passenger dp ;
select * from dim_tariffs dt ;
select * from fact_flights ff ;
select * from errors_fact_flights eff ;
select * from dim_calendar;
select * from errors_calendar;

delete from dim_aircrafts ;
delete from dim_airports ;
