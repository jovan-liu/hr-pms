<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">申请请假</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" action="${appName}/leave/leave-add" enctype="multipart/form-data" onsubmit="return check()" method="post" class="form-horizontal">
			<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">请假类型：</label>
					<div class="col-sm-9">
						<select class="form-control" name="type">
							<option value="1">事假</option>
							<option value="2">病假</option>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">开始时间：</label>
					<div class="col-sm-9">
						<input placeholder="开始时间" class="form-control  form-date date"
						   type="text" name="startTime" id="startTime" readonly>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">结束时间：</label>
					<div class="col-sm-9">
						<input placeholder="结束时间" class="form-control  form-date date"
						   type="text" name="endTime" id="endTime" readonly>
					</div>
				</div>
				
				
				<div class="form-group">
					<label class="col-sm-3 control-label">请假理由：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control" placeholder="请填写请假理由"
							name="reason" id="reason" required>
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

	$('.form-date').datetimepicker({
		language:  'en',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 0,
		minView: 0,
		forceParse: 0,
		format: 'yyyy-mm-dd hh:ii',
		pickerPosition: "bottom-right",
		endDate:new Date(),
		initialDate:new Date(),
	});
	
	$("document").ready(function(){
		 $(".chosen-select").chosen({width:"250px"});
	});
	
  	function check(){
  		/* var name=$("input[name='name']").val();
  		if(name==''||name==null){
  			$("#errorMsg").addClass("alert-danger alert").html("部门名称不能为空！").show();
  			return false;
  		} */
  		return true;
  	}
  </script>

