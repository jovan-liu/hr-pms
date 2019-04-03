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
<title>标签列表</title>
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
			<br>
			<button class="btn btn-info" style="width:150px;height:40px;margin-right: 300px;" id="addButton">新增标签</button>
			<br><br>
			<div class="table-cont">
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped">
						<thead>
							<tr>
								<th>序号</th>
								<th>标签名称</th>
								<th>标签描述</th>
							</tr>
						</thead>
						<tbody id="data-cont">
							<c:forEach var="tagList"
								items="${tagList}">
								<tr id="dashboard-${tagList.id}" class="post">
									<td>${tagList.id}</td>
									<td>${tagList.name}</td>
									<td>${tagList.desc}</td>
									<td>
										<div class="btn-group">
											<button
												onclick="edit('${tagList.id}')"
												type="button" class="btn btn-info" data-toggle="dropdown"
												style="margin-right: 10px;">编辑</button>
											<button
												onclick="delete2('${tagList.id}')"
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
			</div>
		</div>
	</div>
	<%@ include file="/commons/html-js.jsp"%>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"></div>
	<script type="text/javascript">
	
		$("#addButton").click(function(){
	 		$('#myModal').load("<%=request.getContextPath()%>/tag/tag-add-show",function(){
				$('#myModal').modal('show');
			});
	 	});
	
	
		$("document").ready(function(){
			
			$("#load_enable_mark").bind("click", function(){loadmore();});
			}
		);
		
		function edit(id) {
			$('#myModal').load(
					"<%=request.getContextPath()%>/tag/tag-edit-show",
					{"id":id},
					function() {
						$('#myModal').modal('show');
					});
		}
		
		function delete2(id){
			if(confirm("^_^确定要用删除吗^_^")) {
			$.post("${appName}/tag/delete",{"id":id},
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
		
	</script>
</body>
</html>
