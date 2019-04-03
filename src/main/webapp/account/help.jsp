<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">关于禅迹管理后台</h4>
		</div>
		<div class="modal-body" id="content-body">
			禅迹管理后台操作说明(最好使用chrome浏览器)<br/>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default reload-button"
				data-dismiss="modal">关闭</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$(".chosen-select").chosen({width:"200px"});
	});
</script>

