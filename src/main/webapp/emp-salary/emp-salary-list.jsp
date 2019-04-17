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
<title>薪资列表</title>
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
					value="${salaryList.pageNumber}" />
				
				<div class="form-group">
					<label for="empNumber"> 员工编码 </label> <input id="empNumber"
						name="empNumber" class="form-control" 
						placeholder="可模糊查询" value="${salaryRequest.empNumber}">
				</div>
				<div class="form-group">
					<label>发放日期从</label>
				</div>
				<div class="form-group">
					<input placeholder="开始日期" class="form-control  form-date date"
						   type="text" name="beginDate" id="beginDate" value="${salaryRequest.beginDate }"
						   readonly> <span class="clearButton"> <i class="glyphicon glyphicon-remove"></i></span>
				</div>
				<div class="form-group">
					<label>到</label>
				</div>
				<div class="form-group">
					<input id="endDate" name="endDate" type="text"
						   class="form-control  form-date date" placeholder="结束日期"
						   value="${salaryRequest.endDate }" readonly> <span class="clearButton">
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
								<th>发放月份</th>
								<th>正常上班天数</th>
								<th>基本薪资</th>
								<th>加班薪资</th>
								<th>全勤奖</th>
								<th>请假扣款</th>
								<th>迟到/早退扣款</th>
								<th>实际发放</th>
								<th>状态</th>
								<th>创建人</th>
								<th>创建时间</th>
								<th>更新人</th>
								<th>更新时间</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="data-cont">
							<c:forEach var="salary"
								items="${salaryList.pageList}">
								<tr id="dashboard-${salary.id}" class="post">
									<td>${salary.id}</td>
									<td>${salary.empNumber}</td>
									<td>${salary.salaryDate}</td>
									<td>${salary.workCount}</td>
									<td>${salary.basicMoney}</td>
									<td>${salary.otMoney}</td>
									<td>${salary.bonus}</td>
									<td>${salary.leaveMoney}</td>
									<td>${salary.lateMoney}</td>
									<td>${salary.actualMoney}</td>
									<td>
										<div class="btn-group">
											<c:choose>
												<c:when test="${salary.status != null}">
													<c:choose>
														<c:when test="${salary.status == 0}">
															未发放
														</c:when>
														<c:otherwise>
															已发放
														</c:otherwise>
													</c:choose>
												</c:when>
												<c:otherwise></c:otherwise>
											</c:choose>
										</div>
									</td>
									<td>${salary.createUserName}</td>
									<td>
										<fmt:formatDate value="${salary.createdOn}" type="both"/> 
									</td>
									<td>${salary.updateUserName}</td>
									<td>
										<fmt:formatDate value="${salary.updatedOn}" type="both"/> 
									</td>
									<td>
										<div class="btn-group">
											<c:choose>
												<c:when test="${salary.status != null}">
													<c:choose>
														<c:when test="${salary.status == 0}">
															<button
																onclick="edit('${salary.id}', 1)"
																type="button" class="btn btn-info" data-toggle="dropdown"
																style="margin-right: 10px;">发放</button>
														</c:when>
													</c:choose>
												</c:when>
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
					${salaryList.totalRow} 记录</div>
			</div>
			<div class="col-xs-6">
				<div class="dataTables_paginate paging_bootstrap">
					<ul class="pagination">
						<c:if test="${salaryList.totalPage>0 }">
							<li class="prev" onclick="formSubmit('1','false')"><a>首页</a></li>
							<li
								class="prev <c:if test="${salaryList.pageNumber <=1}">disabled</c:if>"><a
								<c:if test="${salaryList.pageNumber > 1}">onclick="formSubmit('${salaryList.pageNumber-1}','false')";</c:if>>←
									上一页</a></li>
						</c:if>
						<c:forEach begin="1" end="${salaryList.totalPage}"
							var="pageNumber">
							<c:if
								test="${pageNumber+3>salaryList.pageNumber&&pageNumber-3<salaryList.pageNumber}">
								<li
									<c:if test="${pageNumber == salaryList.pageNumber}">class="active"</c:if>>
									<a onclick="formSubmit('${pageNumber}','false');">${pageNumber}</a>
								</li>
							</c:if>
						</c:forEach>
						<c:if test="${salaryList.totalPage>0 }">
							<li
								class="next <c:if test="${salaryList.pageNumber == salaryList.totalPage}">disabled</c:if>"><a
								<c:if test="${salaryList.pageNumber < salaryList.totalPage}">onclick="formSubmit('${salaryList.pageNumber+1}','false');"</c:if>>下一页
									→ </a></li>
							<li class="next"
								onclick="formSubmit('${salaryList.totalPage}','false')"><a>尾页</a></li>
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
			format: 'yyyy-mm',
			pickerPosition: "bottom-right",
			endDate:new Date(),
			initialDate:new Date(),
		});
		$(".clearButton").click(function(){
			$(this).prev("input[type='text']").val("");
		});
		
		function edit(id, status){
			$.post("${appName}/emp-salary/emp-salary-update",{"id":id, "status":status},
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
			window.location.href = '${appName}/salary/salary-list?pageNumber='
					+ pageNumber;
		}
		
	</script>
</body>
</html>
