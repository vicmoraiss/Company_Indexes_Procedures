-- Criando Banco de Dados Company_Constraints
create database company_constraints;

use company_constraints;

create table employee(
	Fname varchar(15) not null, 
	Minit char,
	Lname varchar(16) not null,
	Ssn char(9) not null,
	Bdate date,
	Address varchar(30),
	Sex char,
	Salary decimal(10,2),
	Super_ssn char(9),
	Dno int not null,
    constraint chk_salary_employee check (Salary> 2000.0),
	constraint pk_employee primary key (Ssn)
);

alter table employee
	add constraint fk_employee
    foreign key(Super_ssn) references employee(Ssn)
    on delete set null
    on update cascade;

use company;
create table departament(
	Dname varchar(15) not null,
    Dnumber int not null,
    Mgr_ssn char(9),
    Mgr_start_date date,
    Dept_create_date date,
    constraint chk_dpt_date check (Dept_create_date < Mgr_start_date),
    constraint pk_dpt primary key (Dnumber),
    constraint unique_name_dept unique (Dname),
    foreign key (Mgr_ssn) references employee (Ssn)
);

alter table departament drop constraint departament_ibfk_1;
alter table departament
	add constraint fk_dept foreign key (Mgr_ssn) references employee (Ssn)
    on update cascade;

create table dept_locations(
	Dnumber int not null,
    Dlocation varchar(15) not null,
    primary key (Dnumber, Dlocation),
    foreign key (Dnumber) references departament(Dnumber)
);

create table project(
	Pname varchar(15) not null,
    Pnumber int not null,
    Plocation varchar(15),
    Dnum int not null,
    primary key (Pnumber),
	constraint unique_project unique (Pname),
    constraint fk_project foreign key (Dnum) references departament(Dnumber)
);

create table works_on(
	Essn char(9) not null,
    Pno int not null,
    Hours decimal(3,1) not null,
    primary key (Essn, Pno),
    constraint fk_works_on_employee foreign key (Essn) references employee(Ssn),
    constraint fk_works_on_project foreign key (Pno) references project(Pnumber)
);

create table dependent(
	Essn char(9) not null,
    Dependent_name varchar(15) not null,
    Sex enum('F', 'M'),
    Bdate date,
    Relationship varchar(8),
    Age int not null,
    constraint chk_age check (Age < 22),
    primary key (Essn, Dependent_name),
    constraint fk_dependent foreign key (Essn) references employee(Ssn)
);

-- Inserindo dados no Banco de Dados
use company_constraints;

insert into employee values ('John', 'B', 'Smith', 123456789, '1965-01-09', '731 - Fondrend - Houston - TX', 'M', 30000, null, 5),
	('Victor', 'M', 'Evangelista', 987654321, '1993-08-21', 'Casa de Victor', 'M', 30000, null, 5),
	('Bob', 'M', 'Festas', 111111111, '1999-07-11', 'Casa de Bob', 'F', 30000, 987654321, 5),
	('Eugênia', 'M', 'Foxxxter', 222222222, '1970-09-10', 'Casa de Eugênia', 'F', 30000, null, 5),
	('Antônio', 'E', 'Pereira', 333333333, '1968-07-31', 'Casa de Antônio', 'M', 30000, 222222222, 5),
	('Franklin', 'T', 'Wong', 333445555, '1955-12-08', '638-Voss-Houston-TX', 'M', 40000.000, 123456789, 5),
	('Joyce', 'A', 'English', 453453453, '1972-07-31', '5631-Rice-Houston-TX', 'F', 25000.00, 987654321, 5),
	('Ramesh', 'K', 'Narayan', 666884444, '1962-09-15', '975-Fire-Oak-Humble-TX', 'M', 38000.00, 987654321, 5),
	('James', 'E', 'Borg', 888665555, '1937-11-10', '450-Stone-Houston-Tx', 'M', 55000.00, 333445555, 1),
	('Jeniffer', 'S', 'Wallace', 999999999, '1941-06-20', '291-Berry-Bellaire-TX', 'F', 43000.00, null, 4),
	('Ahmad', 'V', 'Jabbar', 987987987, '1969-03-29', '980-Dallas-Houston-TX', 'M', 25000.00, 123456789, 4),
	('Alicia', 'J', 'Zelaya', 999887777, '1968-01-19', '3321-Castle-Spring-Tx', 'F', 25000.00, 333445555, 4);

insert into dependent values ('987654321', 'Rubi', 'F' , '2023-03-08', 'Cachorra', '01'),
	('222222222', 'Safira', 'F', '2014-04-09', 'Cachorra', '12'),
	('111111111', 'Whisky', 'M', '2007-01-01', 'Whisky', '18'),
	('333333333', 'Carro', 'M', '2018-01-01', 'Carro', '07');

insert into departament values ('Administration', 1, 333333333, '2020-01-01', '2019-01-01'),
('Research', 2, 111111111, '2020-01-01', '2019-01-01'),
('Headquarters', 3, 222222222, '2020-01-01', '2019-01-01'),
('Human Resources', 4, 987987987, '2020-01-01', '2019-01-01'),
('Finances', 5, 666884444, '2020-01-01', '2019-01-01');

insert into dept_locations values (1, 'Patos'),
(2, 'João Pessoa'),
(3, 'Campina Grande'),
(4, 'Cajazeiras'),
(5, 'Sousa');

insert into project values (987654321, 1, 'Patos', 1),
	(222222222, 2, 'João Pessoa', 2),
    (333333333, 3, 'Campina Grande', 3);

insert into works_on values (987654321, 1, 24.0),
	(111111111, 2, 24.0),
    (222222222, 3, 24.0);
    
load data infile 'path' into table employee
	fields terminated by ','
    lines terminated by ';'
;

-- Inserindo Indexes no Banco de Dados
alter table employee add index employee_salary(Salary);
alter table employee add index employee_department(Dno);
alter table employee add index employee_name(Fname);
alter table dependent add index father_mother_code(Essn);
alter table dependent add index relation_dependent(Relationship);
alter table project add index project_location(Plocation);
alter table departament add index mgr_start_at_dept_idx(Mgr_start_date);
alter table departament add index dept_create_dt_idx(Dept_create_date);

-- Qual departamento que tem mais empregados?
select count(*) Qtd_Pessoas, Dnumber as 'Número do Departamento', Dname as 'Nome do Departamento'
	from departament as d left join employee as e
    on e.Dno = d.Dnumber
    group by Dnumber order by Qtd_Pessoas desc;
    
-- Departamentos por Cidade
select Dnumber as 'Número do Departamento',Dname as 'Nome do Departamento',
Dlocation as 'Localização do Departamento' from 
	dept_locations natural join
	departament order by Dnumber desc;
    
-- Funcionários por Departamento    
select CONCAT(Fname,' ',Minit,' ',Lname) as 'Nome do Funcionário', Dname as 'Nome do Departamento', Dnumber as 'Número do Departamento' 
	from Employee e Left Join
	Departament d on e.Dno = d.Dnumber
	order by d.Dnumber desc;

-- Inserção de novos departamentos através de Procedures
delimiter //
create procedure new_departament(Dname_p varchar(30),Dnumber_p int,Dept_create_date_p date)
	begin
		insert into departament (Dname,Dnumber,Dept_create_date) values(Dname_p,Dnumber_p,Dept_create_date_p);
	end //
delimiter ;

call new_departament('Staff',6,null);

delimiter ||
create procedure data_manipulation(num int, dpt_num int,in dept_loc varchar(40))
begin
    
	case num
		when 1 then
			insert into departament(Dnumber,Dname,Dept_create_date) values (dpt_num,dept_loc,current_date());
            select * from company_constraints.departament;
		when 2 then 
			delete from departament where Dnumber = dept_num;
            select * from company_constraints.departament;
		when 3 then
			update departament set Dname = 'Research' where Dnumber = dept_num;
            select * from company_constraints.departament;
		else
			select * from company_constraints.departament;
	END CASE;
end ||
drop procedure data_manipulation;
call data_manipulation(null,null,'');



