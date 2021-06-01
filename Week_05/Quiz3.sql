use DBS211

CREATE TABLE student
(Campus_no varchar(1) 
, mn int 
, Stud_lname varchar(15)
, Stud_fname varchar(15)
, Stud_pgm varchar(3) default 'CPA'
, Locker_no int unique
, primary key(Campus_no, mn)
, CONSTRAINT fk_Pgm_id FOREIGN KEY (Stud_pgm) REFERENCES PGM(Pgm_id)
, CONSTRAINT check_mn_lenght CHECK (mn between 0 and 9)
, CONSTRAINT check_locker_no_lenght CHECK (Locker_no between 0 and 999))


CREATE TABLE PGM
(Pgm_id varchar(3) primary key
, Pgm_name varchar(40) not null unique
, No_semesters int not null default 6
, CONSTRAINT check_pgm_id CHECK (Pgm_id = 'CPA' or Pgm_id = 'CPD')
, CONSTRAINT check_No_semesters CHECK (No_semesters >= 0 and No_semesters <= 9))