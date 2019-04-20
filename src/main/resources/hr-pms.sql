-- system
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0未激活   1激活 ',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`,`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `roleName` varchar(45) NOT NULL COMMENT '角色名称',
  `description` varchar(255) DEFAULT NULL COMMENT '角色描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permission` varchar(45) NOT NULL COMMENT '权限Action',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `impower` int(1) DEFAULT NULL,
  `rtxnumber` varchar(20) DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

CREATE TABLE `user_roles` (
  `user_id` int(11) NOT NULL COMMENT '用户Id',
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`user_id`,`role_id`),
  UNIQUE KEY `user_roles_roles_id_fk_idx` (`role_id`,`user_id`) USING BTREE,
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `roles_permissions` (
  `role_id` int(11) NOT NULL COMMENT '角色id',
  `permission_id` int(11) NOT NULL COMMENT '权限id',
  `createTime` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`role_id`,`permission_id`),
  KEY `rolse_permissions_permissions_id_fk_idx` (`permission_id`) USING BTREE,
  CONSTRAINT `roles_permissions_ibfk_1` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`),
  CONSTRAINT `roles_permissions_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `operate_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `worker` varchar(255) DEFAULT NULL,
  `operate_log` varchar(5000) DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_createtime` (`createtime`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

-- hr-pms
CREATE TABLE work_day (
  id INT(10) NOT NULL AUTO_INCREMENT PRIMARY KEY,
  work_day DATE DEFAULT NULL
);

create table dept(
	id int(10) primary key auto_increment comment '部门ID',
	`name` varchar(20) not null comment '部门名称',
	`desc` varchar(255) comment '部门描述',
	`status` tinyint(1) comment '部门状态， 1可用 0不可用，要将部门设为不可用，须将部门下员工转移'
);

create table emp_number(
	number int(4)
);

create table emp(
	id int(10) primary key auto_increment comment '员工ID',
	dept_id int(10) comment '所属部门ID',
    dept_name varchar(20) comment '所属部门名称',
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
	number varchar(10) not null comment '工号，用于前台登录',
	-- password varchar(16) not null comment '工号密码，初始密码与工号相同',
    salary decimal(7, 2) comment '员工基本薪资',
	hiredate date not null comment '入职日期 yyyy-MM-dd',
	offdate date comment '离职日期 yyyy-MM-dd',
	status tinyint(1) not null comment '在职状态，1在职 0离职',
	create_user_name varchar(20) comment '创建人',
	created_on timestamp null comment '创建时间',
	update_user_name varchar(20) comment '更新人',
	updated_on timestamp null comment '更新时间'
);

create table emp_attendance(
	id int(10) not null auto_increment primary key comment '考勤记录ID',
    emp_number varchar(10) not null comment '员工编号',
    attendance_date date comment '考勤日期',
    sign_in time comment '签到时间',
    sign_out time comment '签退时间',
    count tinyint(1) comment '打卡次数',
    late tinyint(1) comment '是否迟到，1迟到 0不迟到',
    `left` tinyint(1) comment '是否早退，1早退 0不早退',
    count_late tinyint(1) comment '当日早退迟到次数',
    work_time float comment '工作时间',
    status tinyint(1) comment '考勤状态 1正常 0异常'
);

create table emp_overtime(
	id int(10) not null auto_increment primary key comment '考勤记录ID',
    emp_number varchar(10) not null comment '员工编号',
    start_time timestamp null comment '开始时间',
    end_time timestamp null comment '结束时间',
    reason varchar(255) comment '加班理由',
    apply_time timestamp null comment '申请时间',
    reply_time timestamp null comment '回复时间',
    status tinyint(1) comment '状态 0待审核 1已通过 2未通过',
	create_user_name varchar(20) comment '创建人',
	created_on timestamp null comment '创建时间',
	update_user_name varchar(20) comment '更新人',
	updated_on timestamp null comment '更新时间'
);

create table emp_leave(
	id int(10) not null auto_increment primary key comment '考勤记录ID',
    emp_number varchar(10) not null comment '员工编号',
    type tinyint(1) comment '请假类型 1事假 2病假 3年假',
    start_time timestamp null comment '开始时间',
    end_time timestamp null comment '结束时间',
    reason varchar(255) comment '请假理由',
    apply_time timestamp null comment '申请时间',
    reply_time timestamp null comment '回复时间',
    status tinyint(1) comment '状态 0待审核 1已通过 2未通过',
	create_user_name varchar(20) comment '创建人',
	created_on timestamp null comment '创建时间',
	update_user_name varchar(20) comment '更新人',
	updated_on timestamp null comment '更新时间'
);

create table emp_salary(
	id int(10) not null auto_increment primary key comment '工资单记录ID',
    emp_number varchar(10) not null comment '员工编号',
	salary_date varchar(10) comment 'yyyy-MM',
	work_count int(4) comment '正常上班天数',
	basic_money decimal(7, 2) comment '基本薪资（联表查询员工表）',
	ot_money decimal(7, 2) comment '加班薪资（加班时间*时薪）',
	leave_money decimal(7, 2) comment '请假扣款（事假扣除当天全部工资，病假扣除当天80%工资）',
	bonus decimal(7, 2) comment '全勤奖',
    late_money decimal(7, 2) comment '迟到/早退扣款',
	actual_money decimal(7, 2) comment '实际发放（基本薪资+加班薪资-请假扣款[+-全勤]）',
    status tinyint(1) comment '状态 1已发 0未发',
    create_user_name varchar(20) comment '创建人SYSTEM',
	created_on timestamp null comment '创建时间',
	update_user_name varchar(20) comment '更新人',
	updated_on timestamp null comment '更新时间'
);

