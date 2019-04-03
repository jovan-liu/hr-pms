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
<title>权限列表</title>
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

				<button class="btn btn-primary" id="addButton">增加权限</button>
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped">
						<thead>
							<tr>
								<th>权限ID</th>
								<th>权限Action</th>
								<th>描述</th>
								<th>是否需授权</th>
								<!-- <th style="width: 9%;">授权人RTX账号</th> -->
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="perm" items="${permList}">
								<tr>
									<td>${perm.id}</td>
									<td>${perm.permission}</td>
									<td>${perm.description }</td>
									<td><c:if test="${perm.impower==1 }">
											<span style="color: red">需授权</span>
										</c:if> 
										 <c:if test="${perm.impower==null }">
											<span style="color: blue">不需授权</span>
										</c:if><td>
									<%-- <td><span style="color: green">${perm.rtxnumber }</span><td> --%>
									<td>
										<div class="btn-group">
											<button style="margin-right: 10px;" onclick="toEditPerm('${perm.id}');" type="button" class="btn btn-primary">编辑</button>
											<button onclick="toDelPerm('${perm.id}');"  type="button" class="btn btn-danger">删除</button>
										</div>
									<td>
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
     		$('#myModal').load("<%=request.getContextPath()%>/account/account-perm-add-show",function(){
    			$('#myModal').modal('show');
    		});
     	});
     	function toEditPerm(permId){
     		$('#myModal').load("<%=request.getContextPath()%>/account/account-perm-edit-show",{"permId":permId},function(){
    			$('#myModal').modal('show');
    		});
     	}
     	function toDelPerm(permId){
     		$('#myModal').load("<%=request.getContextPath()%>/account/account-perm-del-show",{"permId":permId},function(){
    			$('#myModal').modal('show');
    		});
     	}
     </script>
</body>
</html>

</html>