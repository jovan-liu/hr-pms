<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">编辑部门</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" action="${appName}/dept/dept-update" enctype="multipart/form-data" onsubmit="return check()" method="post" class="form-horizontal">
			<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
				<input type="hidden" name="id" value="${id}" id="icon">
					
				<div class="form-group">
					<label class="col-sm-3 control-label">部门名称：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="name" id="name" value="${name}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">部门描述：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="desc" id="desc" value="${desc}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">部门状态：</label>
					<div class="col-sm-9">
						<label class="btn btn-info"><input id="${id }" name="status" type="radio" value="1" <c:if test="${status}">checked </c:if> >有效</label>
						<label class="btn btn-info"><input id="${id }" name="status" type="radio" value="0" <c:if test="${!status}">checked </c:if> >无效</label>
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
  		var name=$("input[name='name']").val();
  		if(name==''||name==null){
  			$("#errorMsg").addClass("alert-danger alert").html("部门名称不能为空！").show();
  			return false;
  		}
  		return true;
  	}
</script>
