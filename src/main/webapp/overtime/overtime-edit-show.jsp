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
					<label class="col-sm-3 control-label">照片：</label>
					<div class="col-sm-9 localImag2" id="localImag2">
						<input id="lefile2" type="file" name="fileName2"
							style="display: none"> <input type="hidden"
							id="bg_picture"> <a class="btn btn-warning"
							onclick="$('input[id=lefile2]').click();">浏览</a>
						<div class="localImag2" id="localImag2" style="margin-top: 5px">
							<c:if test="${emp.photo!=null}">
								<img
									src="${emp.photo}"
									id="preview2" width="200px" height="100px" style="diplay: none" />
							</c:if>
							<c:if test="${emp.photo==null}">
                       			<img src="<%=request.getContextPath()%>/resources/css/background.png"
                       	 		id="preview2" width="300px" height="300px" style="diplay:none"/>
                       	 	</c:if>
			       		</div>
						<div class="btn btn-info text2" >删除</div>
					</div>
				</div>
				
				<input type="hidden" type="text" name="del2" id="del2"  value="" />
				
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
	
	$('input[id=lefile2]').change(function() {
		var path = $(this).val();
		var index = path.lastIndexOf(".");
		var picture_type = path.substring(index+1,path.length);
		
		if(picture_type.toUpperCase()=='JPG' || picture_type.toUpperCase()=='PNG' || picture_type.toUpperCase()=='JPEG' ||picture_type.toUpperCase()=='GIF'){
			var docObj = document.getElementById("lefile2");
			var imgObjPreview = document.getElementById("preview2");
			$("#bg_picture").val(path);
			
			if (docObj.files && docObj.files[0]) {
				//火狐下，直接设img属性
				imgObjPreview.style.display = 'block';
				imgObjPreview.style.width = '150px';
				imgObjPreview.style.height = '150px';
	
				//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式  
				imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
	
			} else {
				//IE下，使用滤镜
				docObj.select();
				var imgSrc = document.selection.createRange().text;
				var localImagId = document.getElementById("localImag2");
				//必须设置初始大小
				localImagId.style.width = "150px";
				localImagId.style.height = "150px";
				//图片异常的捕捉，防止用户修改后缀来伪造图片
				try {
					localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
					localImagId.filters
							.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
				} catch (e) {
					alert("您上传的图片格式不正确，请重新选择!");
					return false;
				}
				imgObjPreview.style.display = 'none';
				document.selection.empty();
			}
		}else{
			alert("您上传的图片格式不正确，请重新选择!");
		}
	}); 
	
	$("document").ready(function(){
		 $(".chosen-select").chosen({width:"250px"});
		 
		 $(".localImag2").hover(function(){
		    $(this).find(".text2").slideDown();
		    },function(){
		    $(this).find(".text2").slideUp();
		 });
			
		$(".text2").bind("click", function(){
			$("#preview2").attr("src","");
			var elem = document.getElementById("del2");
			elem.value = "true";
		});
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
