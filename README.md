# 配置环境
1. JDK1.8
  ```
  下载地址：
    https://www.oracle.com/technetwork/cn/java/javase/downloads/java-archive-javase8-2177648-zhs.html
  ```
  
2. MAVEN3.5.3
  ```
  下载地址：
      https://archive.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.zip
  配置阿里云镜像
    <mirrors>
      <mirror>
        <id>alimaven</id>
        <name>aliyun maven</name>
      <url>http://maven.aliyun.com/nexus/content/groups/public/</url>
        <mirrorOf>central</mirrorOf>        
      </mirror>
    </mirrors>
  ```
    
3. TOMCAT8.0.53
  ```
  下载地址：
		https://archive.apache.org/dist/tomcat/tomcat-8/v8.0.53/bin/apache-tomcat-8.0.53.zip
  配置server.xml，修改文件上传路径
		<Host>
			...
			<Context crossContext="true" debug="0" docBase="D:\upload" path="/upload" reloadable="true"/>
		</Host>
  ```
  
  
# 配置数据库
	```
	安装MYSQL5（注意时区）
		下载地址：
			https://dev.mysql.com/downloads/mysql/
	导入dump文件/SQL文件
		src/main/resources/hr-pms.sql
		src/main/resources/sql/*.sql
		OR
		src/main/resources/hr-pms.dump
	批量增加员工及考勤记录
		emp_batch_insert.xlsx
		attendance_batch_insert.xlsx
	```
  	
# 拉取源代码
	源码地址
		https://github.com/jovan-liu/hr-pms
    
# 导入代码到eclipse
	安装Eclipse MARS2
	配置eclipse环境
		编码
		maven
	解决代码报错
