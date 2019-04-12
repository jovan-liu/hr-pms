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
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped">
						<thead>
							<tr>
								<th>用户ID</th>
								<th>用户名称</th>
								<th>角色</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="account" items="${accountList}">
								<tr>
									<td>${account.accountId}</td>
									<td>${account.username}</td>
									<td>
										<c:forEach var="roles" items="${account.roleList}">
											<c:if test="${roles.exist }">【${roles.description}】<br/></c:if>
										</c:forEach>
									</td>
									<td>
										<div class="btn-group">
											<button onclick="toEditUser('${account.accountId}')" style="margin-right: 10px;"
												type="button" class="btn btn-primary" data-toggle="dropdown">
												修改角色</button>
											<button onclick="password('${account.accountId}')" style="margin-right: 10px;"
												type="button" class="btn btn-info" data-toggle="dropdown">
												修改密码</button>
											<!-- <button onclick="toDeleteUser()" type="button" class="btn btn-danger">删除</button> -->
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
	<%@ include file="/commons/html-js.jsp"%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"></div>
	<script>
	function toDeleteUser(){
		alert("请联系jovan删除");
	}
	function toEditUser(id){
		$('#myModal').load("<%=request.getContextPath()%>/account/account-edit-show",{"accountId":id},function(){
			$("input[name='accountId']").val(id);
			$('#myModal').modal('show');
		});
	}
	function password(id){
		$('#myModal').load("<%=request.getContextPath()%>/account/account-change-password-show",{"accountId":id},function(){
			$("input[name='accountId']").val(id);
			$('#myModal').modal('show');
		});
	}
	
	</script>
</body>
</html>

</html>