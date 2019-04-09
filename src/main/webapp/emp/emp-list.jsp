<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="../../assets/ico/favicon.ico">
<title>员工列表</title>
<%@ include file="/commons/html-css.jsp"%>
<%@ include file="/commons/html-compatible.jsp"%>

<link href="<%=request.getContextPath()%>/resources/css/dashboard.css"
	rel="stylesheet">
</head>
<body>
	<style type="text/css">
		table td{  
			word-break: keep-all;  
			white-space:nowrap;  
		}
	</style>
	<!-- 头部嵌入页面 -->
	<%@ include file="/commons/head.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<!-- 左边菜单栏 -->
			<%@ include file="/commons/left.jsp"%>
			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<form id="searchForm" class="form-inline" role="form" method="post">
				<input type="hidden" name="pageNumber"
					value="${empList.pageNumber}" />
				<div class="form-group">
					<label for="number"> 员工编码 </label> <input id="number"
						name="number" class="form-control" value="${empDto.number}">
				</div>
				<div class="form-group">
					<label for="name"> 员工姓名</label> <input
						id="name" name="name" class="form-control"
						placeholder="可模糊查询" value="${empDto.name}">
				</div>
				<div class="form-group">
					<label for="deptName"> 所属部门</label> <input
						id="deptName" name="deptName" class="form-control"
						placeholder="可模糊查询" value="${empDto.deptName}">
				</div>
				<div class="form-group">
					<label for="status"> 状态</label>
					<select name="status">
						<option value="1">在职</option>
						<option value="0">离职</option>
					</select>
				</div>
				
				<button type="button" class="btn btn-danger"
					onclick="formSubmit(1,'false');">搜索</button>
				<button type="button" class="btn btn-info"
					onclick="resetForm(this);">重置</button>
			</form>
			<br>
			<button class="btn btn-info" style="width:150px;height:40px;margin-right: 300px;" id="addButton">新增员工</button>
			<br><br>
			<div class="table-cont">
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped">
						<thead>
							<tr>
								<th>序号</th>
								<th>员工编号</th>
								<th>员工照片</th>
								<th>所属部门</th>
								<th>员工姓名</th>
								<th>年龄</th>
								<th>身份证号</th>
								<th>手机号</th>
								<th>邮箱</th>
								<th>出生日</th>
								<th>性别</th>
								<th>婚否</th>
								<th>出生地</th>
								<th>目前所在地</th>
								<th>状态</th>
								<th>入职日期</th>
								<th>离职日期</th>
								<th>创建人</th>
								<th>创建时间</th>
								<th>更新人</th>
								<th>更新时间</th>
							</tr>
						</thead>
						<tbody id="data-cont">
							<c:forEach var="emp"
								items="${empList.pageList}">
								<tr id="dashboard-${emp.id}" class="post">
									<td>${emp.id}</td>
									<td>${emp.number}</td>
									<td><!-- /upload/xxx.png -->
										<img src="${emp.photo}" width="100px" height="100px">
									</td>
									<td>${emp.deptName}</td>
									<td>${emp.name}</td>
									<td>${emp.age}</td>
									<td>${emp.IDCard}</td>
									<td>${emp.phone}</td>
									<td>${emp.email}</td>
									<td>
										<fmt:formatDate value="${emp.birthday}" type="date"/> 
									</td>
									<td>
										<c:if test="${emp.sex == 1}">男</c:if>
										<c:if test="${emp.sex == 0}">女</c:if>
									</td>
									<td>
										<c:choose>
											<c:when test="${emp.maritalStatus}">已婚</c:when>
											<c:otherwise>未婚</c:otherwise>
										</c:choose>
									</td>
									<td>${emp.placeOfBirth}</td>
									<td>${emp.currentCity}</td>
									<td>
										<c:choose>
											<c:when test="${emp.status}">在职</c:when>
											<c:otherwise>离职</c:otherwise>
										</c:choose>
										
									</td>
									<td>
										<fmt:formatDate value="${emp.hiredate}" type="date"/> 
									</td>
									<td>${emp.offdate}</td>
									<td>${emp.createUserName}</td>
									<td>
										<fmt:formatDate value="${emp.createdOn}" type="both"/> 
									</td>
									<td>${emp.updateUserName}</td>
									<td>
										<fmt:formatDate value="${emp.updatedOn}" type="both"/> 
									</td>
									<td>
										<div class="btn-group">
											<button
												onclick="edit('${emp.id}')"
												type="button" class="btn btn-info" data-toggle="dropdown"
												style="margin-right: 10px;">编辑</button>
											<button
												onclick="delete2('${emp.id}')"
												type="button" class="btn btn-danger" data-toggle="dropdown"
												style="margin-right: 10px;">删除</button>	
											
										</div>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="dataTables_info" id="example2_info">总共
					${empList.totalRow} 记录</div>
			</div>
			<div class="col-xs-6">
				<div class="dataTables_paginate paging_bootstrap">
					<ul class="pagination">
						<c:if test="${empList.totalPage>0 }">
							<li class="prev" onclick="formSubmit('1','false')"><a>首页</a></li>
							<li
								class="prev <c:if test="${empList.pageNumber <=1}">disabled</c:if>"><a
								<c:if test="${empList.pageNumber > 1}">onclick="formSubmit('${empList.pageNumber-1}','false')";</c:if>>←
									上一页</a></li>
						</c:if>
						<c:forEach begin="1" end="${empList.totalPage}"
							var="pageNumber">
							<c:if
								test="${pageNumber+3>empList.pageNumber&&pageNumber-3<empList.pageNumber}">
								<li
									<c:if test="${pageNumber == empList.pageNumber}">class="active"</c:if>>
									<a onclick="formSubmit('${pageNumber}','false');">${pageNumber}</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${empList.totalPage>0 }">
							<li
								class="next <c:if test="${empList.pageNumber == empList.totalPage}">disabled</c:if>"><a
								<c:if test="${empList.pageNumber < empList.totalPage}">onclick="formSubmit('${empList.pageNumber+1}','false');"</c:if>>下一页
									→ </a></li>
							<li class="next"
								onclick="formSubmit('${empList.totalPage}','false')"><a>尾页</a></li>
						</c:if>
					</ul>
				</div>
			</div>
			</div>
		</div>
	</div>
	<%@ include file="/commons/html-js.jsp"%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"></div>
	<script type="text/javascript">
	
		$("#addButton").click(function(){
	 		$('#myModal').load("<%=request.getContextPath()%>/emp/emp-add-show",function(){
				$('#myModal').modal('show');
			});
	 	});
	
	
		$("document").ready(function(){
			
			$("#load_enable_mark").bind("click", function(){loadmore();});
			}
		);
		
		function edit(id) {
			$('#myModal').load(
					"<%=request.getContextPath()%>/emp/emp-edit-show",
					{"id":id},
					function() {
						$('#myModal').modal('show');
					});
		}
		
		function delete2(id){
			if(confirm("^_^确定要用删除吗^_^")) {
			$.post("${appName}/emp/delete",{"id":id},
			function(data){
				if(data.data.result == false) {
					alert("网络异常或服务器内部错误");
				} else {
					$("#dashboard-"+id).remove();
				}
			}, "json");
			}
		}
		
		function formSubmit(pageNumber, flag) {
			var form = $("#searchForm");
			if (flag == 'true') {
				resetForm();
			}
			$("input[type='hidden'][name='pageNumber']").val(pageNumber);
			$(form).submit();
		}
		function resetForm(btn) {
			var form = $("#searchForm");
			form[0].reset();
			$(form).find("select,input").each(function() {
				$(this).val("");
			});
		}
		
		function gotoPage() {
			var pageNumber = $("#goto").val();
			if (pageNumber == "") {
				pageNumber = 1;
			}
			window.location.href = '${appName}/emp/emp-list?pageNumber='
					+ pageNumber;
		}
		
	</script>
</body>
</html>
