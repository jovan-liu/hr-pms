<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">新增帖子</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" action="${appName}/post/post-add" enctype="multipart/form-data" onsubmit="return check()" method="post" class="form-horizontal">
			<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
					
				<div class="form-group">
					<label class="col-sm-3 control-label">创建帖子用户ID：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="createUserId" id="createUserId" required>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">分类ID：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="categoryId" id="categoryId" required>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">标题：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="title" id="title" required>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">内容：</label>
					<div class="col-sm-9">
						<textarea class="form-control" rows="10"
							name="content" id="content"></textarea>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">图片：</label>
					<div class="col-sm-9 localImag2" id="localImag2">
						<input id="lefile2" type="file" name="fileName2"
							style="display: none"> <input type="hidden"
							id="bg_picture"> <a class="btn btn-warning"
							onclick="$('input[id=lefile2]').click();">浏览</a>
						<div class="localImag2" id="localImag2" style="margin-top: 5px">
							<img
								src="<%=request.getContextPath()%>/resources/css/background.png"
								id="preview2" width="200px" height="100px" style="diplay: none" />
			       		</div>
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
	});
	
  	function check(){
  		var createUserId=$("input[name='createUserId']").val();
  		if(createUserId==''||createUserId==null){
  			$("#errorMsg").addClass("alert-danger alert").html("创建帖子用户ID不能为空！").show();
  			return false;
  		}
  		var categoryId=$("input[name='categoryId']").val();
  		if(categoryId==''||categoryId==null){
  			$("#errorMsg").addClass("alert-danger alert").html("分类ID不能为空！").show();
  			return false;
  		}
  		var title=$("input[name='title']").val();
  		if(title==''||title==null){
  			$("#errorMsg").addClass("alert-danger alert").html("标题不能为空！").show();
  			return false;
  		}
  		return true;
  	}
  </script>

