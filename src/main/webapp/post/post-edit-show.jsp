<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">编辑标签</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" action="${appName}/post/post-tag-update" enctype="multipart/form-data" onsubmit="return check()" method="post" class="form-horizontal">
			<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
					
				<div class="form-group">
					<label class="col-sm-3 control-label">编号：</label>
					<div class="col-sm-9">
						<input type="text" readonly="readonly" class="form-control"
							name="id" id="id" value="${id}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">标题：</label>
					<div class="col-sm-9">
						<input type="text" readonly="readonly" class="form-control"
							name="title" id="title" value="${title}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">标签：</label>
					<div class="col-sm-9">
						<c:forEach items="${tagList}" var="tag">
                            <label class="btn btn-info"><input id="${tag.id }" name="tagIds" type="checkbox" value="${tag.id }">${tag.name}</label>
                        </c:forEach>
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
	});
	
  	function check(){
  	}
  </script>

