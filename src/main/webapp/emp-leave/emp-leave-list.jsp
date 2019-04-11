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
<title>请假列表</title>
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
					value="${leaveList.pageNumber}" />
				
				<div class="form-group">
					<label for="empNumber"> 员工编码 </label> <input id="empNumber"
						name="empNumber" class="form-control" 
						placeholder="可模糊查询" value="${leaveRequest.empNumber}">
				</div>
				<div class="form-group">
					<label>申请日期从</label>
				</div>
				<div class="form-group">
					<input placeholder="开始时间" class="form-control  form-date date"
						   type="text" name="beginDate" id="beginDate" value="<fmt:formatDate value='${leaveRequest.beginDate }' type='both'/>"
						   readonly> <span class="clearButton"> <i class="glyphicon glyphicon-remove"></i></span>
				</div>
				<div class="form-group">
					<label>到</label>
				</div>
				<div class="form-group">
					<input id="endDate" name="endDate" type="text"
						   class="form-control  form-date date" placeholder="结束时间"
						   value="<fmt:formatDate value='${leaveRequest.endDate }' type='both'/>" readonly> <span class="clearButton">
							<i class="glyphicon glyphicon-remove"></i>
						</span>
				</div>
				
				<button type="button" class="btn btn-danger"
					onclick="formSubmit(1,'false');">搜索</button>
				<button type="button" class="btn btn-info"
					onclick="resetForm(this);">重置</button>
			</form>
			<br>
			
			<br><br>
			<div class="table-cont">
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped">
						<thead>
							<tr>
								<th>序号</th>
								<th>员工编号</th>
								<th>请假类型</th>
								<th>开始时间</th>
								<th>结束时间</th>
								<th>请假理由</th>
								<th>状态</th>
								<th>申请时间</th>
								<th>回复时间</th>
								<th>创建人</th>
								<th>创建时间</th>
								<th>更新人</th>
								<th>更新时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="data-cont">
							<c:forEach var="leave"
								items="${leaveList.pageList}">
								<tr id="dashboard-${leave.id}" class="post">
									<td>${leave.id}</td>
									<td>${leave.empNumber}</td>
									<td>
										<c:choose>
											<c:when test="${leave.type != null}">
												<c:choose>
													<c:when test="${leave.type == 1}">事假</c:when>
													<c:otherwise>
														<c:if test="${leave.type == 2}">病假</c:if>
														<c:if test="${leave.type == 3}">年假</c:if>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</td>
									<td>
										<fmt:formatDate value="${leave.startTime}" type="both"/> 
									</td>
									<td>
										<fmt:formatDate value="${leave.endTime}" type="both"/> 
									</td>
									<td>${leave.reason}</td>
									<td>
										<c:choose>
											<c:when test="${leave.status != null}">
												<c:choose>
													<c:when test="${leave.status == 0}">待审核</c:when>
													<c:otherwise>
														<c:if test="${leave.status == 1}">已通过</c:if>
														<c:if test="${leave.status == 2}">未通过</c:if>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</td>
									<td>
										<fmt:formatDate value="${leave.applyTime}" type="both"/> 
									</td>
									<td>
										<fmt:formatDate value="${leave.replyTime}" type="both"/> 
									</td>
									<td>${leave.createUserName}</td>
									<td>
										<fmt:formatDate value="${leave.createdOn}" type="both"/> 
									</td>
									<td>${leave.updateUserName}</td>
									<td>
										<fmt:formatDate value="${leave.updatedOn}" type="both"/> 
									</td>
									<td>
										<div class="btn-group">
											<c:choose>
												<c:when test="${leave.status != null}">
													<c:choose>
														<c:when test="${leave.status == 0}">
															<button
																onclick="edit('${leave.id}', 1)"
																type="button" class="btn btn-info" data-toggle="dropdown"
																style="margin-right: 10px;">通过</button>
															<button
																onclick="edit('${leave.id}', 2)"
																type="button" class="btn btn-danger" data-toggle="dropdown"
																style="margin-right: 10px;">拒绝</button>
														</c:when>
														<c:otherwise>
															已处理
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise></c:otherwise>
											</c:choose>
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
					${leaveList.totalRow} 记录</div>
			</div>
			<div class="col-xs-6">
				<div class="dataTables_paginate paging_bootstrap">
					<ul class="pagination">
						<c:if test="${leaveList.totalPage>0 }">
							<li class="prev" onclick="formSubmit('1','false')"><a>首页</a></li>
							<li
								class="prev <c:if test="${leaveList.pageNumber <=1}">disabled</c:if>"><a
								<c:if test="${leaveList.pageNumber > 1}">onclick="formSubmit('${leaveList.pageNumber-1}','false')";</c:if>>←
									上一页</a></li>
						</c:if>
						<c:forEach begin="1" end="${leaveList.totalPage}"
							var="pageNumber">
							<c:if
								test="${pageNumber+3>leaveList.pageNumber&&pageNumber-3<leaveList.pageNumber}">
								<li
									<c:if test="${pageNumber == leaveList.pageNumber}">class="active"</c:if>>
									<a onclick="formSubmit('${pageNumber}','false');">${pageNumber}</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${leaveList.totalPage>0 }">
							<li
								class="next <c:if test="${leaveList.pageNumber == leaveList.totalPage}">disabled</c:if>"><a
								<c:if test="${leaveList.pageNumber < leaveList.totalPage}">onclick="formSubmit('${leaveList.pageNumber+1}','false');"</c:if>>下一页
									→ </a></li>
							<li class="next"
								onclick="formSubmit('${leaveList.totalPage}','false')"><a>尾页</a></li>
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
			startView: 0,
			minView: 0,
			forceParse: 0,
			format: 'yyyy-mm-dd hh:ii',
			pickerPosition: "bottom-right",
			endDate:new Date(),
			initialDate:new Date(),
		});
		$(".clearButton").click(function(){
			$(this).prev("input[type='text']").val("");
		});
		
		function edit(id, status){
			$.post("${appName}/emp-leave/emp-leave-update",{"id":id, "status":status},
			function(data){
				if(data.data.result == false) {
					alert("网络异常或服务器内部错误");
				} else {
					window.location.reload();
				}
			}, "json");
		}
	
		$("document").ready(function(){
			
			$("#load_enable_mark").bind("click", function(){loadmore();});
			}
		);
		
		
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
			window.location.href = '${appName}/leave/leave-list?pageNumber='
					+ pageNumber;
		}
		
	</script>
</body>
</html>
