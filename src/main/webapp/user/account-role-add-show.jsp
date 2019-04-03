<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">增加角色</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" class="form-horizontal" id="addForm">
				<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
				<div class="form-group">
					<label class="col-sm-3 control-label">角色名称</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="roleName" required>
					</div>
				</div>


				<div class="form-group">
					<label class="col-sm-3 control-label">角色描述</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="description" required>
					</div>
				</div>
				<div class="form-group  control-group">
					<label class="col-sm-3 control-label">分配权限</label>
					<div class="col-sm-9 chosen-container chosen-container-multi">
						<select data-placeholder="分配权限" name="perms"
							class="chosen-select form-control" style="width: 350px;" multiple>
							<c:forEach var="perm" items="${permList}">
								<option value="${perm.id }">${perm.permission}----${perm.description }</option>
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
				onclick="saveRole();">保存</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$(".chosen-select").chosen({width:"250px"});
	});
  	function saveRole(){
  		var roleName=$("input[name='roleName']").val();
  		if(roleName==''||roleName==null){
  			$("#errorMsg").addClass("alert-danger alert").html("角色名称不为空！").show();
  			return;
  		}
  		var description=$("input[name='description']").val();
  		if(description==''||description==null){
  			$("#errorMsg").addClass("alert-danger alert").html("描述不为空！").show();
  			return;
  		}
  		$("#errorMsg").removeClass().hide();
  		$.ajax({
	        url:"<%=request.getContextPath()%>/account/account-role-validate",  
	        type:"post",
	        data:{"roleName":roleName},
	        dataType:"json",  
	        success:function(jsonData){
	        	if(jsonData.status=="success"){
	        		if(!jsonData.data.result){
	        			$("#errorMsg").addClass("alert-danger alert").html("角色名称存在，请输入其他字符串").show();	
	        		}else{
	        			$.ajax({
	        		        url:"<%=request.getContextPath()%>/account/account-role-add-operate",  
	        		        type:"post",
	        		        data:{"roleName":roleName,
	        		        	  "description":description,
	        		        	  "perms":$("select[name='perms']").val()+""
	        		        	  },
	        		        dataType:"json",  
	        		        success:function(jsonData){
	        		        	if(jsonData.status=="success"&&jsonData.data.result){
	        		        		$("#content-body").html("增加成功");
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

