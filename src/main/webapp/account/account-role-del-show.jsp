<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">删除角色</h4>
		</div>
		<div class="modal-body" id="content-body">
			<input type="hidden" name="roleId" value="${roleId}" /> 确认删除角色？
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default reload-button"
				data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" id="saveButton"
				onclick="delRole(this);">确认</button>
		</div>
	</div>
</div>
<script>
  	function delRole(btn){
  		$.ajax({
		        url:"<%=request.getContextPath()%>/account/account-role-del-operate",  
		        type:"post",
		        data:{"roleId":$("input[name='roleId']").val()},
		        dataType:"json",  
		        success:function(jsonData){
		        	if(jsonData.status=="success"&&jsonData.data.result){
		        		$("#content-body").html("删除成功");
		        		$("#saveButton").remove();
		        		$(".reload-button").attr("onclick","javascript:window.location.reload();");
		        	}else{
		        		$("#content-body").html("系统错误，请稍后再试");
		        		$("#saveButton").remove();
		        	}
		        },
		        error:function(e){
		        	$("#content-body").html("网络超时，请稍后再试！");
	        		$("#saveButton").remove();
		        }
 		});
  	}
  </script>

