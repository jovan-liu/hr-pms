create table dept(
	id int(10) primary key auto_increment comment '部门ID',
	name varchar(20) not null comment '部门名称',
	`desc` varchar(255) comment '部门描述',
	status tinyint(1) comment '部门状态， 1可用 0不可用，要将部门设为不可用，须将部门下员工转移'
);

create table emp(
	id int(10) primary key auto_increment comment '员工ID',
	name varchar(20) not null comment '员工姓名',
	age int(4) comment '年龄',
	ID_card varchar(18) not null comment '18位身份证号',
	phone varchar(11) not null comment '手机号码',
	email varchar(50) not null comment '邮箱',
	birthday date comment '出生日 yyyy-MM-dd',
	sex tinyint(1) not null comment '性别，1男性 0女性',
	marital_status tinyint(1) comment '婚否，1已婚 0未婚',
	place_of_birth varchar(255) comment '出生地',
	current_city varchar(255) comment '现居住地',
	photo varchar(255) comment '照片URL地址',
	job_number varchar(10) not null comment '工号，用于前台登录',
	job_password varchar(16) not null comment '工号密码，初始密码与工号相同',
	dept_id int(10) comment '所属部门ID',
	hiredate date not null comment '入职日期 yyyy-MM-dd',
	offdate date comment '离职日期 yyyy-MM-dd',
	status tinyint(1) not null comment '在职状态，1在职 0离职',
	create_user_name varchar(20) comment '创建人',
	created_on timestamp null comment '创建时间',
	update_user_name varchar(20) comment '更新人',
	updated_on timestamp null comment '更新时间'
);

create table emp_salary(
	bonus comment '奖金'
);

create table emp_attendance(

);


create table emp_overtime(

);

create table emp_leave(

);



























