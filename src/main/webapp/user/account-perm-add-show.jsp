<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">新增权限</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" class="form-horizontal" id="addForm">
				<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
				<div class="form-group">
					<label class="col-sm-3 control-label">权限Action</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="permission">
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label">权限描述</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="description">
					</div>
				</div>
				<!-- <div class="form-group" >
				    <label class="col-sm-3 control-label">若需授权请打勾</label>
				   	<div class="col-sm-9">
				    	 <input type="checkbox" name="rtxFlag" id="rtxFlag" value="false" />
				    </div>
				</div>
				<div class="form-group" >
				    <label class="col-sm-3 control-label">授权人RTX账号</label>
				   	<div class="col-sm-9">
				    	 <input style="display:none" type="text" class="form-control" id="rtxNumber" name="rtxNumber" placeholder="必填"/>
				    </div>
				</div> -->
				
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-default reload-button"
				data-dismiss="modal">关闭</button>
			<button type="button" class="btn btn-primary" id="saveButton"
				onclick="savePerm();">保存</button>
		</div>
	</div>
</div>
<script>
	$(document).ready(function(){
		$(".chosen-select").chosen({width:"250px"});
		$("#rtxFlag").on("change", function(){
			var rtxFlag = $(this).attr("checked");
			if(rtxFlag){
				$("#rtxNumber").show();
				$(this).attr("value", true);
			} else {
				$("#rtxNumber").hide();
				$(this).attr("value", false);
			}
		});
	});
  	function savePerm(){
  		var permission=$("input[name='permission']").val();
  		if(permission==''||permission==null){
  			$("#errorMsg").addClass("alert-danger alert").html("权限Action不为空！").show();
  			return;
  		}
  		var description=$("input[name='description']").val();
  		if(description==''||description==null){
  			$("#errorMsg").addClass("alert-danger alert").html("描述不为空！").show();
  			return;
  		}
  		var rtxnumber=$("input[name='rtxNumber']").val();
  		var impower=null;
  		if(rtxnumber!=''&&rtxnumber!=null){
  			impower=1;
  		}
  		$("#errorMsg").removeClass().hide();
  		$.ajax({
	        url:"<%=request.getContextPath()%>/account/account-perm-validate",  
	        type:"post",
	        data:{"permission":permission},
	        dataType:"json",  
	        success:function(jsonData){
	        	if(jsonData.status=="success"){
	        		if(!jsonData.data.result){
	        			$("#errorMsg").addClass("alert-danger alert").html("权限名Action存在，请输入其他字符串").show();	
	        		}else{
	        			$.ajax({
	        		        url:"<%=request.getContextPath()%>/account/account-perm-add-operate",  
	        		        type:"post",
	        		        data:{"permission":permission,
	        		        	  "description":description,
	      		        		  "impower":impower,
	        		        	  "rtxnumber":rtxnumber
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

