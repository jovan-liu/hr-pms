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
<title>我的考勤</title>
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
			<form id="searchForm" class="form-inline" role="form" method="post">
				<input type="hidden" name="pageNumber"
					value="${attendanceList.pageNumber}" />
				
				<div class="form-group">
					<label>考勤日期从</label>
				</div>
				<div class="form-group">
					<input placeholder="开始时间" class="form-control  form-date date"
						   type="text" name="beginDate" id="beginDate" value="<fmt:formatDate value='${attendanceRequest.beginDate }' type='date'/>"
						   readonly> <span class="clearButton"> <i class="glyphicon glyphicon-remove"></i></span>
				</div>
				<div class="form-group">
					<label>到</label>
				</div>
				<div class="form-group">
					<input id="endDate" name="endDate" type="text"
						   class="form-control  form-date date" placeholder="结束时间"
						   value="<fmt:formatDate value='${attendanceRequest.endDate }' type='date'/>" readonly> <span class="clearButton">
							<i class="glyphicon glyphicon-remove"></i>
						</span>
				</div>
				
				<button type="button" class="btn btn-danger"
					onclick="formSubmit(1,'false');">搜索</button>
				<button type="button" class="btn btn-info"
					onclick="resetForm(this);">重置</button>
			</form>
			<br>
			
			<c:choose>
				<c:when test="${attendance.signIn == null }">
					<a class="btn btn-danger" style="width:150px;height:40px;margin-right: 100px;" id="signIn" href="${appName}/attendance/attendance-add">签到</a>
				</c:when>
				<c:otherwise>
					<label class="btn btn-info">已签到 &nbsp; <fmt:formatDate value="${attendance.signIn }" type="time"/></label>
				</c:otherwise>
			</c:choose>
			<br>
			<br>
			<c:choose>
				<c:when test="${attendance.signOut == null }">
					<a class="btn btn-danger" style="width:150px;height:40px;margin-right: 100px;" id="signIn" href="${appName}/attendance/attendance-update">签退</a>
				</c:when>
				<c:otherwise>
					<label class="btn btn-info">已签退 &nbsp; <fmt:formatDate value="${attendance.signOut }" type="time"/></label>
				</c:otherwise>
			</c:choose>
			
			<br><br>
			<div class="table-cont">
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped">
						<thead>
							<tr>
								<th>序号</th>
								<th>员工编号</th>
								<th>考勤日期</th>
								<th>签到时间</th>
								<th>签退时间</th>
								<th>考勤状态</th>
							</tr>
						</thead>
						<tbody id="data-cont">
							<c:forEach var="attendance"
								items="${attendanceList.pageList}">
								<tr id="dashboard-${attendance.id}" class="post">
									<td>${attendance.id}</td>
									<td>${attendance.empNumber}</td>
									<td>
										<fmt:formatDate value="${attendance.attendanceDate}" type="date"/> 
									</td>
									<td>
										<fmt:formatDate value="${attendance.signIn}" type="time"/> 
									</td>
									<td>
										<fmt:formatDate value="${attendance.signOut}" type="time"/> 
									</td>
									<td>
										<c:choose>
											<c:when test="${attendance.status != null}">
												<c:choose>
													<c:when test="${attendance.status == 1}">正常</c:when>
													<c:otherwise>异常</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</td>
									<%-- <td>
										<div class="btn-group">
											<button
												onclick="edit('${attendance.id}')"
												type="button" class="btn btn-info" data-toggle="dropdown"
												style="margin-right: 10px;">编辑</button>
											
										</div>
									</td> --%>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="dataTables_info" id="example2_info">总共
					${attendanceList.totalRow} 记录</div>
			</div>
			<div class="col-xs-6">
				<div class="dataTables_paginate paging_bootstrap">
					<ul class="pagination">
						<c:if test="${attendanceList.totalPage>0 }">
							<li class="prev" onclick="formSubmit('1','false')"><a>首页</a></li>
							<li
								class="prev <c:if test="${attendanceList.pageNumber <=1}">disabled</c:if>"><a
								<c:if test="${attendanceList.pageNumber > 1}">onclick="formSubmit('${attendanceList.pageNumber-1}','false')";</c:if>>←
									上一页</a></li>
						</c:if>
						<c:forEach begin="1" end="${attendanceList.totalPage}"
							var="pageNumber">
							<c:if
								test="${pageNumber+3>attendanceList.pageNumber&&pageNumber-3<attendanceList.pageNumber}">
								<li
									<c:if test="${pageNumber == attendanceList.pageNumber}">class="active"</c:if>>
									<a onclick="formSubmit('${pageNumber}','false');">${pageNumber}</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${attendanceList.totalPage>0 }">
							<li
								class="next <c:if test="${attendanceList.pageNumber == attendanceList.totalPage}">disabled</c:if>"><a
								<c:if test="${attendanceList.pageNumber < attendanceList.totalPage}">onclick="formSubmit('${attendanceList.pageNumber+1}','false');"</c:if>>下一页
									→ </a></li>
							<li class="next"
								onclick="formSubmit('${attendanceList.totalPage}','false')"><a>尾页</a></li>
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
	
		$('.form-date').datetimepicker({
			language:  'en',
			weekStart: 1,
			todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0,
			format: 'yyyy-mm-dd',
			pickerPosition: "bottom-right",
			endDate:new Date(),
			initialDate:new Date(),
		});
		$(".clearButton").click(function(){
			$(this).prev("input[type='text']").val("");
		});
	
		$("#addButton").click(function(){
	 		$('#myModal').load("<%=request.getContextPath()%>/attendance/attendance-add-show",function(){
				$('#myModal').modal('show');
			});
	 	});
	
	
		$("document").ready(function(){
			
			$("#load_enable_mark").bind("click", function(){loadmore();});
			}
		);
		
		function edit() {
			$('#myModal').load(
					"<%=request.getContextPath()%>/attendance/attendance-edit-show",
					function() {
						$('#myModal').modal('show');
					});
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
			window.location.href = '${appName}/attendance/attendance-list?pageNumber='
					+ pageNumber;
		}
		
	</script>
</body>
</html>
