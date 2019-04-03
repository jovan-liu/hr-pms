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
<title>评论列表</title>
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
            
            <a href="javascript:history.back(-1)">返回帖子列表</a>
			<br><br>
			<div class="table-cont">
				<div class="table-responsive">
					<table id="dataTable" class="table table-striped" width="100%">
						<thead>
							<tr>
								<th width="5%">序号</th>
								<th width="5%">帖子ID</th>
								<th width="10%">父评论ID</th>
								<th width="10%">评论类型</th>
								<th width="40%">内容</th>
								<th width="10%">评论用户</th>
                                <th width="10%">被评论用户</th>
								<th width="5%">点赞数</th>
								<th width="5%">是否推荐</th>
							</tr>
						</thead>
						<tbody id="data-cont">
							<c:forEach var="commentList"
								items="${commentList}">
								<tr id="dashboard-${commentList.id}" class="post">
									<td>${commentList.id}</td>
									<td>${commentList.postId}</td>
									<td>${commentList.parentId}</td>
									<td>${commentList.commentType}</td>
									<td>${commentList.content}</td>
									<td>${commentList.fromUid} - ${commentList.fromUserName}</td>
                                    <td>${commentList.toUid} - ${commentList.toUserName}</td>
									<td>${commentList.points}</td>
									<td>
									   <c:choose>
									       <c:when test="${commentList.isRecommend }">
									           <button
                                                onclick="cancleRecommend('${commentList.id}')"
                                                type="button" class="btn btn-info" data-toggle="dropdown"
                                                style="margin-right: 10px;">取消精华</button>
									       </c:when>
									       <c:otherwise>
									           <button
                                                onclick="setRecommend('${commentList.id}')"
                                                type="button" class="btn btn-info" data-toggle="dropdown"
                                                style="margin-right: 10px;">设为精华</button>
									       </c:otherwise>
									   </c:choose>
									</td>
									<td>
                                        <div class="btn-group">
                                            <button
                                                onclick="replyComment('${commentList.id}', '${commentList.postId}', '${commentList.fromUid}')"
                                                type="button" class="btn btn-info" data-toggle="dropdown"
                                                style="margin-right: 10px;">回复评论</button>   
                                            
                                        </div>
                                    </td>
                                    <td>
                                        <div class="btn-group">
                                            <button
                                                onclick="deleteComment('${commentList.id}')"
                                                type="button" class="btn btn-danger" data-toggle="dropdown"
                                                style="margin-right: 10px;">删除评论</button>   
                                            
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
		$("document").ready(function(){
			$("#load_enable_mark").bind("click", function(){loadmore();});
			}
		);
		
		function replyComment(id, postId, fromUid) {
            $('#myModal').load(
                    "<%=request.getContextPath()%>/post/post-comment-reply-show",
                    {"id":id, "postId":postId, "fromUid":fromUid},
                    function() {
                        $('#myModal').modal('show');
                    });
        }
		
		function deleteComment(id){
            if(confirm("^_^确定要用删除吗^_^")) {
                $.post("${appName}/post/delete-comment",{"id":id},
                function(data){
                    if(data.data.result == false) {
                        alert("网络异常或服务器内部错误");
                    } else {
                        $("#dashboard-"+id).remove();
                    }
                }, "json");
            }
        }
		
		function setRecommend(id){
            if(confirm("^_^确定要设为精华评论吗^_^")) {
	            $.post("${appName}/post/post-comment-update",{"id":id, "isRecommend": true},
	            function(data){
	                if(data.data.result == false) {
	                    alert("网络异常或服务器内部错误");
	                }
	            }, "json");
	            setInterval(refresh, 100);
            }
        }
		
		function cancleRecommend(id){
            if(confirm("^_^确定要取消精华评论吗^_^")) {
                $.post("${appName}/post/post-comment-update",{"id":id, "isRecommend": false},
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
