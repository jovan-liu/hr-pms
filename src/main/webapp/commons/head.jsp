<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %> 
    
<c:set var="appName" value="${pageContext.request.contextPath}"/>
<div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<button type="button"  class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse2">
				<span class="glyphicon glyphicon-th"></span>
			</button>
			<a class="navbar-brand" href="#">禅迹 管理后台 ${titleName} 环境</a>
		</div>

		<div class="navbar-collapse  collapse">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="../account/logout.action">Logout</a></li>
				<!-- <li><a href="javascript:void(0)" onclick="showHelp();">使用操作说明</a></li> -->
			</ul>
		</div>
	</div>
</div>

<%@ include file="/commons/html-js.jsp"%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true"></div>
<script>
	function showHelp() {
		$('#myModal').load("${appName}/observeaccount/help",function(){
			$('#myModal').modal('show');
		});
	}

</script>