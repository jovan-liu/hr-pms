<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">新增经书</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" action="${appName}/book/book-add" enctype="multipart/form-data" onsubmit="return check()" method="post" class="form-horizontal">
			<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
					
				<div class="form-group">
					<label class="col-sm-3 control-label">经书名称：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="name" id="name" required>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">作者：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="author" id="author" required>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">封面图：</label>
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
				
				<div class="form-group">
                    <label class="col-sm-3 control-label">白话版：</label>
                    <div class="col-sm-9" id="localNormal">
                        <input id="lefile3" name="normal" type="file" style="display: none" />
                        <a class="btn btn-warning" onclick="$('input[id=lefile3]').click();">浏览</a>
                        <div>
                            <a target="_blank" id="normalA"></a>
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="col-sm-3 control-label">古译版：</label>
                    <div class="col-sm-9" id="localAncient">
                        <input id="lefile4" name="ancient" type="file" style="display: none" />
                        <a class="btn btn-warning" onclick="$('input[id=lefile4]').click();">浏览</a>
                        <div>
                            <a target="_blank" id="ancientA"></a>
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
		
		// 经书封面只允许使用PNG格式的图片
		if(picture_type.toUpperCase()=='PNG'){
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
					alert("您上传的图片格式不正确，经书封面只允许使用PNG格式的图片，请重新选择!");
					return false;
				}
				imgObjPreview.style.display = 'none';
				document.selection.empty();
			}
		}else{
			alert("您上传的图片格式不正确，请重新选择!");
		}
	}); 
	
	$('input[id=lefile3]').change(function() {
        var path = $(this).val();
        var index = path.lastIndexOf(".");
        var picture_type = path.substring(index+1,path.length);
        
        if(picture_type.toUpperCase()=='TXT'){
            var docObj = document.getElementById("lefile3");
            var imgObjPreview = document.getElementById("normal");
            $("#normalA").text(path);
            imgObjPreview.style.display = 'block';
            
            
        }else{
            alert("您上传的文件格式不正确，经书只允许使用TXT格式的文件，请重新选择!");
        }
    });
    
    $('input[id=lefile4]').change(function() {
        var path = $(this).val();
        var index = path.lastIndexOf(".");
        var picture_type = path.substring(index+1,path.length);
        
        if(picture_type.toUpperCase()=='TXT'){
            var docObj = document.getElementById("lefile4");
            var imgObjPreview = document.getElementById("ancient");
            $("#ancientA").text(path);
            imgObjPreview.style.display = 'block';
            
            
        }else{
            alert("您上传的文件格式不正确，经书只允许使用TXT格式的文件，请重新选择!");
        }
    });
	
	$("document").ready(function(){
		 $(".chosen-select").chosen({width:"250px"});
	});
	
  	function check(){
  		var name=$("input[name='name']").val();
  		if(name==''||name==null){
  			$("#errorMsg").addClass("alert-danger alert").html("经书名称不能为空！").show();
  			return false;
  		}
        var normal=$("input[name='normal']").val();
        if(normal==''||normal==null){
            $("#errorMsg").addClass("alert-danger alert").html("白话版不能为空！").show();
            return false;
        }
        var ancient=$("input[name='ancient']").val();
        if(ancient==''||ancient==null){
            $("#errorMsg").addClass("alert-danger alert").html("古译版不能为空！").show();
            return false;
        }
  		return true;
  	}
  </script>

