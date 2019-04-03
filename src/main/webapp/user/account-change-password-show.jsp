<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">修改密码</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" class="form-horizontal" id="addForm">
				<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
				<input type="hidden" name="accountId" value="${accountId}">
				<div class="form-group">
					<label class="col-sm-3 control-label">旧密码</label>
					<div class="col-sm-9">
						<input type="password" placeholder="必填" class="form-control"
							name="oldPassword" value="${oldPassword}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">新密码</label>
					<div class="col-sm-9">
						<input type="password" placeholder="必填" class="form-control"
							name="newPassword" value="${newPassword}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">重复新密码</label>
					<div class="col-sm-9">
						<input type="password" placeholder="必填" class="form-control"
							name="newPasswordAgain" value="${newPasswordAgain}">
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default reload-button"
				data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" id="saveButton"
				onclick="saveRole();">保存</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$(".chosen-select").chosen({width:"250px"});
	});
  	function saveRole(){
  		var oldPassword=$("input[name='oldPassword']").val();
  		if(oldPassword==''||oldPassword==null){
  			$("#errorMsg").addClass("alert-danger alert").html("旧密码不为空！").show();
  			return;
  		}
  		var newPassword=$("input[name='newPassword']").val();
  		if(newPassword==''||newPassword==null){
  			$("#errorMsg").addClass("alert-danger alert").html("新密码不为空！").show();
  			return;
  		}
  		var newPasswordAgain=$("input[name='newPasswordAgain']").val();
  		if(newPasswordAgain==''||newPasswordAgain==null){
  			$("#errorMsg").addClass("alert-danger alert").html("重复新密码不为空！").show();
  			return;
  		}
  		$("#errorMsg").removeClass().hide();
  		$.ajax({
		        url:"<%=request.getContextPath()%>/account/account-change-password",  
		        type:"post",
		        data:{"accountId":$("input[name='accountId']").val(),
		        	  "oldPassword":oldPassword,
		        	  "newPassword":newPassword,
		        	  "newPasswordAgain":newPasswordAgain
		        	  },
		        dataType:"json",  
		        success:function(jsonData){
		        	if(jsonData.status=="success"&&jsonData.data.result){
		        		$("#content-body").html("修改成功");
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

