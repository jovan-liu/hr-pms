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
<title>用户操作日志列表</title>
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
						value="${operatelogList.pageNumber}" />
					<div class="form-group">
						<label for="worker"> 操作者 </label> <input id="worker"
							name="worker" class="form-control" placeholder="可模糊查询"
							value="${worker}">
					</div>
					<div class="form-group">
						<label for="operateLog"> 操作记录 </label> <input
							id="operateLog" name="operateLog" class="form-control"
							placeholder="可模糊查询" value="${operateLog}">
					</div>
					<div class="form-group">
						<label>创建日期从</label>
					</div>
					<div class="form-group">
						<input placeholder="开始时间" class="form-control  form-date date"
							   type="text" name="beginDate" id="beginDate" value="${beginDate}"
							   readonly> <span class="clearButton"> <i class="glyphicon glyphicon-remove"></i></span>
					</div>
					<div class="form-group">
						<label>到</label>
					</div>
					<div class="form-group">
						<input id="endDate" name="endDate" type="text"
							   class="form-control  form-date date" placeholder="结束时间"
							   value="${endDate}" readonly> <span class="clearButton">
								<i class="glyphicon glyphicon-remove"></i>
							</span>
					</div>	
					<button type="button" class="btn btn-danger"
						onclick="formSubmit(1,'false');">搜索</button>
					<button type="button" class="btn btn-info"
						onclick="resetForm(this);">重置</button>
				</form>

			<br>
			<div class="table-cont">
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th>操作者</th>
								<th style="width: 40%;">操作记录</th>
								<th style="width: 20%;">操作时间</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="operatelog"
								items="${operatelogList.pageList}">
								<tr>
									<td>${operatelog.id}</td>
									<td>${operatelog.worker}</td>
									<td>${operatelog.operateLog}</td>
									<td>
									<fmt:formatDate value="${operatelog.createtime }"
											pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
				<!-- 分页div结束 -->
				<div class="col-xs-6">
					<div class="dataTables_info" id="example2_info">总共
						${operatelogList.totalRow} 记录</div>
				</div>
				<div class="col-xs-6">
					<div class="dataTables_paginate paging_bootstrap">
						<ul class="pagination">
							<c:if test="${operatelogList.totalPage>0 }">
								<li class="prev" onclick="formSubmit('1','false')"><a>首页</a></li>
								<li
									class="prev <c:if test="${operatelogList.pageNumber <=1}">disabled</c:if>"><a
									<c:if test="${operatelogList.pageNumber > 1}">onclick="formSubmit('${operatelogList.pageNumber-1}','false')";</c:if>>←
										上一页</a></li>
							</c:if>
							<c:forEach begin="1" end="${operatelogList.totalPage}"
								var="pageNumber">
								<c:if
									test="${pageNumber+3>operatelogList.pageNumber&&pageNumber-3<operatelogList.pageNumber}">
									<li
										<c:if test="${pageNumber == operatelogList.pageNumber}">class="active"</c:if>>
										<a onclick="formSubmit('${pageNumber}','false');">${pageNumber}</a>
									</li>
								</c:if>
							</c:forEach>
							<c:if test="${operatelogList.totalPage>0 }">
								<li
									class="next <c:if test="${operatelogList.pageNumber == operatelogList.totalPage}">disabled</c:if>"><a
									<c:if test="${operatelogList.pageNumber < operatelogList.totalPage}">onclick="formSubmit('${operatelogList.pageNumber+1}','false');"</c:if>>下一页
										→ </a></li>
								<li class="next"
									onclick="formSubmit('${operatelogList.totalPage}','false')"><a>尾页</a></li>
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
			language:  'zh-CN',
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
			window.location.href = '${appName}/operatelog/operatelog-list?pageNumber='
					+ pageNumber;
		}
	</script>
</body>
</html>
