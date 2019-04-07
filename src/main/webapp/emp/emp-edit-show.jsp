<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">编辑员工</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" action="${appName}/emp/emp-update" enctype="multipart/form-data" onsubmit="return check()" method="post" class="form-horizontal">
			<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
				<input type="hidden" name="id" value="${emp.id}" id="icon">
				
				<div class="form-group">
					<label class="col-sm-3 control-label">员工编号：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="number" id="number" value="${emp.number}" readonly>
					</div>
				</div>
					
				<div class="form-group">
					<label class="col-sm-3 control-label">部门：</label>
					<div class="col-sm-9">
						<select class="form-control" name="deptId">
							<c:forEach items="${deptList }" var="dept">
								<option value="${dept.id }" <c:if test="${emp.deptId == dept.id}">checked</c:if> >${dept.name }</option>
							</c:forEach>
							
						</select>
					</div>
				</div>
					
				<div class="form-group">
					<label class="col-sm-3 control-label">员工姓名：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="name" id="name" value="${emp.name}" required>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">年龄：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="age" id="age" value="${emp.age}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">身份证号：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="IDCard" id="IDCard" value="${emp.IDCard}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">手机号：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="phone" id="phone" value="${emp.phone}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">邮箱：</label>
					<div class="col-sm-9">
						<input type="email" class="form-control"
							name="email" id="email" value="${emp.email}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">出生日：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control  form-date date"
							name="birthday" id="birthday" value="<fmt:formatDate value='${emp.birthday}' type='date'/>">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">性别：</label>
					<div class="col-sm-9">
						<c:choose>
							<c:when test="${emp.sex == 1}">
								<input name="sex" type="radio" value="1" checked>&nbsp;&nbsp;男&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="sex" type="radio" value="0">&nbsp;&nbsp;女
							</c:when>
							<c:otherwise>
								<input name="sex" type="radio" value="1">&nbsp;&nbsp;男&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="sex" type="radio" value="0" checked>&nbsp;&nbsp;女
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">婚否：</label>
					<div class="col-sm-9">
						<c:choose>
							<c:when test="${emp.maritalStatus}">
								<input name="maritalStatus" type="radio" value="1" checked>&nbsp;&nbsp;已婚&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="maritalStatus" type="radio" value="0">&nbsp;&nbsp;未婚
							</c:when>
							<c:otherwise>
								<input name="maritalStatus" type="radio" value="1">&nbsp;&nbsp;已婚&nbsp;&nbsp;&nbsp;&nbsp;
								<input name="maritalStatus" type="radio" value="0" checked>&nbsp;&nbsp;未婚
							</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">出生地：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="placeOfBirth" id="placeOfBirth" value="${emp.placeOfBirth}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">目前所在地：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="currentCity" id="currentCity" value="${emp.currentCity}">
					</div>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label">入职时间：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control  form-date date"
							name="hiredate" id="hiredate" value="<fmt:formatDate value='${emp.hiredate}' type='date'/>">
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
		language:  'zh-CN',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		forceParse: 0,
		format: 'yyyy-mm-dd',
		pickerPosition: "bottom-right",
		endDate:new Date(),
		initialDate:new Date(),
	});
	
	
	
	$("document").ready(function(){
		 $(".chosen-select").chosen({width:"250px"});
	});
	
  	function check(){
  		var name=$("input[name='name']").val();
  		if(name==''||name==null){
  			$("#errorMsg").addClass("alert-danger alert").html("员工姓名不能为空！").show();
  			return false;
  		}
  		return true;
  	}
</script>
