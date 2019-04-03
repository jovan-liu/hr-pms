<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">回复帖子</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" action="${appName}/post/post-reply" enctype="multipart/form-data" onsubmit="return check()" method="post" class="form-horizontal">
			<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
					
				<input hidden="hidden" name="toUid" id="toUid" value="${toUid }">
				<input hidden="hidden" name="categoryId" id="categoryId" value="${categoryId }">
				<div class="form-group">
					<label class="col-sm-3 control-label">帖子ID：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="postId" id="postId" readonly="readonly" value="${id }">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">评论用户ID：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="fromUid" id="fromUid" required>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">内容：</label>
					<div class="col-sm-9">
						<textarea placeholder="必填" class="form-control" rows="10"
							name="content" id="content" required></textarea>
					</div>
				</div>
				
				<div class="modal-footer">
					<button type="button" class="btn btn-default reload-button"
						data-dismiss="modal">关闭</button>
					<button type="submit" class="btn btn-primary" id="saveButton"
						onclick="check()">保存</button>
				</div>
			</form>
		</div>
	</div>
</div>


<script type="text/javascript">

	
	$("document").ready(function(){
		 $(".chosen-select").chosen({width:"250px"});
	});
	
  	function check(){
  		var fromUid=$("input[name='fromUid']").val();
  		if(fromUid==''||fromUid==null){
  			$("#errorMsg").addClass("alert-danger alert").html("评论用户ID不能为空！").show();
  			return false;
  		}
  		var content=$("textarea[name='content']").val();
        if(content==''||content==null){
            $("#errorMsg").addClass("alert-danger alert").html("内容不能为空！").show();
            return false;
        }
  		return true;
  	}
  </script>

