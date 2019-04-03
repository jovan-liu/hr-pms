<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">编辑用户</h4>
		</div>
		<div class="modal-body" id="content-body">
			<div aria-hidden="true" id="errorMsg"></div>
			<form role="form" class="form-horizontal" id="addForm">
				<input type="hidden" name="accountId" value="${account.accountId }" />
				<div class="form-group">
					<label class="col-sm-3 control-label">用户名</label>
					<div class="col-sm-5">
						${account.username}
					</div>
				</div>
				<!-- 
				<div class="form-group">
					<label class="col-sm-3 control-label">密码</label>
					<div class="col-sm-5">
						请在内网环境下通过http://www.jiaxu.oa.com/ltb/修改
					</div>
				</div>
				 -->
				<div class="form-group  control-group">
					<label class="col-sm-3 control-label">选择角色</label>
					<div class="col-sm-9 chosen-container chosen-container-multi">
						<select data-placeholder="选择角色" name="roles"
							class="chosen-select form-control" style="width: 350px;" multiple>
							<c:forEach var="role" items="${rolesList}">
								<option <c:if test="${role.exist }">selected</c:if>
									value="${role.id }">${role.roleName }</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default reload-button"
				data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" id="saveButton"
				onclick="editUser(this);">修改</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$(".chosen-select").chosen({width:"200px"});
	});
  	function editUser(btn){
  		$.ajax({
		        url:"<%=request.getContextPath()%>/account/account-edit-operate",
		        data:{"accountId":$("input[name='accountId']").val(),
		        	  "roles":$("select[name='roles']").val()+"",
				},
		        type:"post",  
		        dataType:"json",  
		        success:function(jsonData){
		        	if(jsonData.status=="success"&&jsonData.data.result){
		        		$("#content-body").html("修改成功");
		        		$("#saveButton").remove();
		        		$(".reload-button").attr("onclick","javascript:window.location.reload();");
		        	}else{
		        		$("#content-body").html("系统错误，请稍后再试！");
		        		$("#saveButton").remove();
		        	}
		        },
		        error:function(e){
		        	$("#content-body").html("网络错误，请稍后再试！");
	        		$("#myModal").modal('show');
	        		$("#saveButton").remove();
		        }
 		});
  	}
  </script>

