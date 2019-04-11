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
<title>加班列表</title>
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
					value="${overtimeList.pageNumber}" />
				
				<div class="form-group">
					<label for="empNumber"> 员工编码 </label> <input id="empNumber"
						name="empNumber" class="form-control" 
						placeholder="可模糊查询" value="${overtimeRequest.empNumber}">
				</div>
				<div class="form-group">
					<label>申请日期从</label>
				</div>
				<div class="form-group">
					<input placeholder="开始时间" class="form-control  form-date date"
						   type="text" name="beginDate" id="beginDate" value="<fmt:formatDate value='${overtimeRequest.beginDate }' type='both'/>"
						   readonly> <span class="clearButton"> <i class="glyphicon glyphicon-remove"></i></span>
				</div>
				<div class="form-group">
					<label>到</label>
				</div>
				<div class="form-group">
					<input id="endDate" name="endDate" type="text"
						   class="form-control  form-date date" placeholder="结束时间"
						   value="<fmt:formatDate value='${overtimeRequest.endDate }' type='both'/>" readonly> <span class="clearButton">
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
								<th>开始时间</th>
								<th>结束时间</th>
								<th>加班理由</th>
								<th>状态</th>
								<th>申请时间</th>
								<th>回复时间</th>
								<th>创建人</th>
								<th>创建时间</th>
								<th>更新人</th>
								<th>更新时间</th>
							</tr>
						</thead>
						<tbody id="data-cont">
							<c:forEach var="overtime"
								items="${overtimeList.pageList}">
								<tr id="dashboard-${overtime.id}" class="post">
									<td>${overtime.id}</td>
									<td>${overtime.empNumber}</td>
									<td>
										<fmt:formatDate value="${overtime.startTime}" type="both"/> 
									</td>
									<td>
										<fmt:formatDate value="${overtime.endTime}" type="both"/> 
									</td>
									<td>${overtime.reason}</td>
									<td>
										<c:choose>
											<c:when test="${overtime.status != null}">
												<c:choose>
													<c:when test="${overtime.status == 0}">待审核</c:when>
													<c:otherwise>
														<c:if test="${overtime.status == 1}">已通过</c:if>
														<c:if test="${overtime.status == 2}">未通过</c:if>
													</c:otherwise>
												</c:choose>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</td>
									<td>
										<fmt:formatDate value="${overtime.applyTime}" type="both"/> 
									</td>
									<td>
										<fmt:formatDate value="${overtime.replyTime}" type="both"/> 
									</td>
									<td>${overtime.createUserName}</td>
									<td>
										<fmt:formatDate value="${overtime.createdOn}" type="both"/> 
									</td>
									<td>${overtime.updateUserName}</td>
									<td>
										<fmt:formatDate value="${overtime.updatedOn}" type="both"/> 
									</td>
									<td>
										<div class="btn-group">
											<c:choose>
												<c:when test="${overtime.status != null}">
													<c:choose>
														<c:when test="${overtime.status == 0}">
															<button
																onclick="edit('${overtime.id}', 1)"
																type="button" class="btn btn-info" data-toggle="dropdown"
																style="margin-right: 10px;">通过</button>
															<button
																onclick="edit('${overtime.id}', 2)"
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
					${overtimeList.totalRow} 记录</div>
			</div>
			<div class="col-xs-6">
				<div class="dataTables_paginate paging_bootstrap">
					<ul class="pagination">
						<c:if test="${overtimeList.totalPage>0 }">
							<li class="prev" onclick="formSubmit('1','false')"><a>首页</a></li>
							<li
								class="prev <c:if test="${overtimeList.pageNumber <=1}">disabled</c:if>"><a
								<c:if test="${overtimeList.pageNumber > 1}">onclick="formSubmit('${overtimeList.pageNumber-1}','false')";</c:if>>←
									上一页</a></li>
						</c:if>
						<c:forEach begin="1" end="${overtimeList.totalPage}"
							var="pageNumber">
							<c:if
								test="${pageNumber+3>overtimeList.pageNumber&&pageNumber-3<overtimeList.pageNumber}">
								<li
									<c:if test="${pageNumber == overtimeList.pageNumber}">class="active"</c:if>>
									<a onclick="formSubmit('${pageNumber}','false');">${pageNumber}</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${overtimeList.totalPage>0 }">
							<li
								class="next <c:if test="${overtimeList.pageNumber == overtimeList.totalPage}">disabled</c:if>"><a
								<c:if test="${overtimeList.pageNumber < overtimeList.totalPage}">onclick="formSubmit('${overtimeList.pageNumber+1}','false');"</c:if>>下一页
									→ </a></li>
							<li class="next"
								onclick="formSubmit('${overtimeList.totalPage}','false')"><a>尾页</a></li>
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
	
		$("document").ready(function(){
			
			$("#load_enable_mark").bind("click", function(){loadmore();});
			}
		);
		
		function edit(id, status){
			$.post("${appName}/emp-overtime/emp-overtime-update",{"id":id, "status":status},
			function(data){
				if(data.data.result == false) {
					alert("网络异常或服务器内部错误");
				} else {
					window.location.reload();
				}
			}, "json");
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
			window.location.href = '${appName}/emp-overtime/emp-overtime-list?pageNumber='
					+ pageNumber;
		}
		
	</script>
</body>
</html>
