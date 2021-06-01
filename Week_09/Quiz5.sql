use DBS211;

CREATE TABLE Student(
student_ID numeric(9) primary key not null
, student_name varchar(128) not null
, dateofBirth date not null
, student_address varchar(256) not null);


CREATE TABLE Course(
course_ID varchar(6) primary key not null,
course_name varchar(256) not null);


CREATE TABLE Student_Course(
student_ID numeric(9) not null
, course_ID varchar(6) not null
, course_enrolment_date date not null

PRIMARY KEY(student_ID, course_ID)
, CONSTRAINT stdId_fk FOREIGN KEY (student_ID) REFERENCES Student(student_ID)
, CONSTRAINT courseId_fk FOREIGN KEY (course_ID) REFERENCES Course(course_ID));


