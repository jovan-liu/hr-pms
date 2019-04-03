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
<title>论坛列表</title>
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
			<!-- 
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
             -->
             
             <script type="text/javascript">
             
             </script>
             
            <button class="btn btn-info" style="width:150px;height:40px;margin-right: 100px;" id="addPost">添加帖子</button>
            
			<a class="<c:choose><c:when test='${type == "recommend" }'>btn btn-danger</c:when><c:otherwise>btn btn-info</c:otherwise></c:choose>" style="width:150px;height:40px;margin-right: 100px;" id="recommend" href="${appName}/post/post-list">精华帖子列表</a>
			
			<a class="<c:choose><c:when test='${type == "category1" }'>btn btn-danger</c:when><c:otherwise>btn btn-info</c:otherwise></c:choose>" style="width:150px;height:40px;margin-right: 100px;" id="category1" href="${appName}/post/category-post-list?categoryId=1">论道帖子列表</a>
			
			<a class="<c:choose><c:when test='${type == "category2" }'>btn btn-danger</c:when><c:otherwise>btn btn-info</c:otherwise></c:choose>" style="width:150px;height:40px;margin-right: 100px;" id="category2" href="${appName}/post/category-post-list?categoryId=2">读经帖子列表</a>
			
			<a class="<c:choose><c:when test='${type == "category3" }'>btn btn-danger</c:when><c:otherwise>btn btn-info</c:otherwise></c:choose>" style="width:150px;height:40px;margin-right: 100px;" id="category3" href="${appName}/post/category-post-list?categoryId=3">心路帖子列表</a>
			
			<br><br>
			<div class="table-cont">
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped" width="100%">
						<thead>
							<tr>
								<th width="5%">序号</th>
								<th width="5%">分类</th>
								<th width="5%">标签</th>
								<th width="15%">标题</th>
								<th width="43%">内容</th>
								<th width="10%">创建帖子用户</th>
								<th width="6%">点赞数</th>
								<th width="6%">评论数</th>
								<th width="5%">是否推荐</th>
							</tr>
						</thead>
						<tbody id="data-cont">
							<c:forEach var="postList"
								items="${postList}">
								<tr id="dashboard-${postList.id}" class="post">
									<td>${postList.id}</td>
									<td>${postList.categoryName}</td>
									<td>
										<c:forEach var="tag" items="${postList.tags}">
										   <li class="btn btn-info">${tag.name}</li>
										</c:forEach>
									</td>
									<td>
									   <a href="${appName}/post/post-comment-list?postId=${postList.id}">${postList.title}</a>
									</td>
									<td>${postList.content}</td>
									<td>${postList.createUserId} - ${postList.createUserName}</td>
									<td>${postList.points}</td>
									<td>${postList.commentCount}</td>
									<td>
									   <c:choose>
									       <c:when test="${postList.isRecommend }">
									           <button
                                                onclick="cancleRecommend('${postList.id}')"
                                                type="button" class="btn btn-info" data-toggle="dropdown"
                                                style="margin-right: 10px;">取消精华</button>
									       </c:when>
									       <c:otherwise>
									           <button
                                                onclick="setRecommend('${postList.id}')"
                                                type="button" class="btn btn-info" data-toggle="dropdown"
                                                style="margin-right: 10px;">设为精华</button>
									       </c:otherwise>
									   </c:choose>
									</td>
									<td>
										<div class="btn-group">
											<button
												onclick="editTags('${postList.id}')"
												type="button" class="btn btn-info" data-toggle="dropdown"
												style="margin-right: 10px;">编辑标签</button>	
											
										</div>
									</td>
									<td>
                                        <div class="btn-group">
                                            <button
                                                onclick="replyPost('${postList.id}', '${postList.createUserId}')"
                                                type="button" class="btn btn-info" data-toggle="dropdown"
                                                style="margin-right: 10px;">回复帖子</button>   
                                            
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <button
                                                onclick="deletePost('${postList.id}')"
                                                type="button" class="btn btn-danger" data-toggle="dropdown"
                                                style="margin-right: 10px;">删除帖子</button>   
                                            
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
	
		$("#addPost").click(function(){
	        $('#myModal').load("<%=request.getContextPath()%>/post/post-add-show",function(){
	            $('#myModal').modal('show');
	        });
	    });
		
		$("document").ready(function(){
			$("#load_enable_mark").bind("click", function(){loadmore();});
			}
		);
		
		function setRecommend(id){
            if(confirm("^_^确定要设为精华帖子吗^_^")) {
	            $.post("${appName}/post/post-update",{"id":id, "isRecommend": true},
	            function(data){
	                if(data.data.result == false) {
	                    alert("网络异常或服务器内部错误");
	                }
	            }, "json");
	            setInterval(refresh, 100);
            }
        }
		
		function cancleRecommend(id){
            if(confirm("^_^确定要取消精华帖子吗^_^")) {
                $.post("${appName}/post/post-update",{"id":id, "isRecommend": false},
                function(data){
                    if(data.data.result == false) {
                        alert("网络异常或服务器内部错误");
                    }
                }, "json");
                setInterval(refresh, 100);
            }
        }
		
		function refresh() {
            window.location.reload();
        }
		
		function editTags(id) {
            $('#myModal').load(
                    "<%=request.getContextPath()%>/post/post-edit-show",
                    {"id":id},
                    function() {
                        $('#myModal').modal('show');
                    });
        }
		
		function replyPost(id, createUserId) {
            $('#myModal').load(
                    "<%=request.getContextPath()%>/post/post-reply-show",
                    {"id":id, "createUserId":createUserId},
                    function() {
                        $('#myModal').modal('show');
                    });
        }
		
		function deletePost(id){
            if(confirm("^_^确定要用删除吗^_^")) {
	            $.post("${appName}/post/delete-post",{"id":id},
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
