<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
    <style>
		<!--
		.myicon{
		    float:right;
		 }
    	.nav-self{
    		display:none;
    		margin-left:50px;
    	}
		-->
</style>


<c:set var="appName" value="${pageContext.request.contextPath}"/>

<div class="col-sm-3 col-md-2 sidebar navbar-collapse2 collapse">

     <ul class="nav nav-sidebar" >

         <shiro:hasPermission name="account">
        <li>
     		<a href="#" class="tree">
              <i class="glyphicon glyphicon-th-large"></i>
              <span>权限管理</span>
              <i class="glyphicon  <c:if test="${menu==6||menu==7||menu==8||menu==9}">glyphicon-chevron-down</c:if><c:if test="${!(menu==6||menu==7||menu==8||menu==9)}">glyphicon-chevron-left</c:if> myicon"></i>
          </a>
          <ul class="nav nav-self" <c:if test="${menu==6||menu==7||menu==8||menu==9}">style='display:block;'</c:if>>
            
            <!-- 有account-list权限的才可以使用 -->
            <shiro:hasPermission name="account-list">
            	<li><a href="${appName}/account/account-list" <c:if test="${menu==6}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>用户列表</a></li>
            </shiro:hasPermission>


			<!-- 有account-role-list权限的才可以使用 -->
            <shiro:hasPermission name="account-role-list">
            	<li><a href="${appName}/account/account-role-list" <c:if test="${menu==7}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>角色列表</a></li>
            </shiro:hasPermission>
            
            <!-- 有account-perm-list权限的才可以使用 -->
            <shiro:hasPermission name="account-perm-list">
            	<li><a href="${appName}/account/account-perm-list" <c:if test="${menu==8}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>权限列表</a></li>
            </shiro:hasPermission>
          </ul>
     	</li>
         </shiro:hasPermission>

         <shiro:hasPermission name="hr">
     	<li>
             <a href="#" class="tree">
              <i class="glyphicon glyphicon-th-large"></i>
              <span>人事使用</span>
              <i class="glyphicon  <c:if test="${menu==10||menu==11||menu==12||menu==13||menu==14||menu==15}">glyphicon-chevron-down</c:if><c:if test="${!(menu==10||menu==11||menu==12||menu==13||menu==14||menu==15)}">glyphicon-chevron-left</c:if> myicon"></i>
          </a>
          <ul class="nav nav-self" <c:if test="${menu==10||menu==11||menu==12||menu==13||menu==14||menu==15}">style='display:block;'</c:if>>
             <!-- 有present-list权限的才可以使用 -->
            <shiro:hasPermission name="dept-list">         
                <li><a href="${appName}/dept/dept-list" <c:if test="${menu==10}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>部门列表</a></li>
            </shiro:hasPermission>
              <shiro:hasPermission name="emp-list">
                  <li><a href="${appName}/emp/emp-list" <c:if test="${menu==11}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>员工列表</a></li>
              </shiro:hasPermission>
              <shiro:hasPermission name="emp-list">
                  <li><a href="${appName}/emp/emp-attendance-list" <c:if test="${menu==12}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>考勤列表</a></li>
              </shiro:hasPermission>
              <shiro:hasPermission name="emp-list">
                  <li><a href="${appName}/emp/emp-ot-list" <c:if test="${menu==13}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>加班列表</a></li>
              </shiro:hasPermission>
              <shiro:hasPermission name="emp-list">
                  <li><a href="${appName}/emp/emp-leave-list" <c:if test="${menu==14}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>请假列表</a></li>
              </shiro:hasPermission>
              <shiro:hasPermission name="emp-list">
                  <li><a href="${appName}/emp/emp-salary-list" <c:if test="${menu==15}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>薪资列表</a></li>
              </shiro:hasPermission>
          </ul>
        </li>
         </shiro:hasPermission>

         <shiro:hasPermission name="emp">
             <li>
                 <a href="#" class="tree">
                     <i class="glyphicon glyphicon-th-large"></i>
                     <span>员工使用</span>
                     <i class="glyphicon  <c:if test="${menu==20||menu==21||menu==22||menu==23}">glyphicon-chevron-down</c:if><c:if test="${!(menu==20||menu==21||menu==22||menu==23)}">glyphicon-chevron-left</c:if> myicon"></i>
                 </a>
                 <ul class="nav nav-self" <c:if test="${menu==20||menu==21||menu==22||menu==23}">style='display:block;'</c:if>>
                     <!-- 有present-list权限的才可以使用 -->
                     <shiro:hasPermission name="attendance-list">
                         <li><a href="${appName}/attendance/attendance-list" <c:if test="${menu==20}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>我的考勤</a></li>
                     </shiro:hasPermission>
                     <shiro:hasPermission name="ot-list">
                         <li><a href="${appName}/ot/ot-list" <c:if test="${menu==21}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>我的加班</a></li>
                     </shiro:hasPermission>
                     <shiro:hasPermission name="leave-list">
                         <li><a href="${appName}/leave/leave-list" <c:if test="${menu==22}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>我的请假</a></li>
                     </shiro:hasPermission>
                     <shiro:hasPermission name="salary-list">
                         <li><a href="${appName}/salary/salary-list" <c:if test="${menu==23}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>我的薪资</a></li>
                     </shiro:hasPermission>
                 </ul>
             </li>
         </shiro:hasPermission>

         <shiro:hasPermission name="log">
        <li>
             <a href="#" class="tree">
              <i class="glyphicon glyphicon-th-large"></i>
              <span>日志操作记录</span>
              <i class="glyphicon  <c:if test="${menu==100}">glyphicon-chevron-down</c:if><c:if test="${!(menu==100)}">glyphicon-chevron-left</c:if> myicon"></i>
          </a>
          <ul class="nav nav-self" <c:if test="${menu==100}">style='display:block;'</c:if>>
            <shiro:hasPermission name="operatelog-list">         
            	<li><a href="${appName}/operatelog/operatelog-list" <c:if test="${menu==100}">style='color:white;background-color:#428bca'</c:if>><i class="glyphicon glyphicon-indent-left"></i>日志记录</a></li>
            </shiro:hasPermission>
          </ul>
        </li>
         </shiro:hasPermission>
        
     </ul>
   </div>