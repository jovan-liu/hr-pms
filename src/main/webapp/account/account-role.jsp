<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="../../assets/ico/favicon.ico">
<title>用户列表</title>
<%@ include file="/commons/html-css.jsp"%>
<%@ include file="/commons/html-compatible.jsp"%>
<link href="<%=request.getContextPath()%>/resources/css/dashboard.css"
	rel="stylesheet">
</head>

<body>
	<!-- 头部嵌入页面 -->
	<%@ include file="/commons/head.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<!-- 左边菜单栏 -->
			<%@ include file="/commons/left.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">

				<button class="btn btn-primary" id="addButton">增加角色</button>
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped">
						<thead>
							<tr>
								<th>角色ID</th>
								<th>角色名称</th>
								<th>角色描述</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="role" items="${rolesList}">
								<tr>
									<td>${role.id}</td>
									<td>${role.roleName}</td>
									<td>${role.description }</td>
									<td>
										<div class="btn-group">
											<button onclick="toEditRole('${role.id}');" type="button" class="btn btn-primary">编辑</button>
											<button onclick="toDelRole('${role.id}');"  type="button" class="btn btn-danger">删除</button>
										</div>
									</td>

								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- 分页div结束 -->
			</div>
		</div>
	</div>

	<!-- Bootstrap core JavaScript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<%@ include file="/commons/html-js.jsp"%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"></div>
	<script>
     	$("#addButton").click(function(){
     		$('#myModal').load("<%=request.getContextPath()%>/account/account-role-add-show",function(){
    			$('#myModal').modal('show');
    		});
     	});
     	function toEditRole(roleId){
     		$('#myModal').load("<%=request.getContextPath()%>/account/account-role-edit-show",{"roleId":roleId},function(){
    			$('#myModal').modal('show');
    		});
     	}
     	function toDelRole(roleId){
     		$('#myModal').load("<%=request.getContextPath()%>/account/account-role-del-show",{"roleId":roleId},function(){
    			$('#myModal').modal('show');
    		});
     	}
     </script>
</body>
</html>

</html>