<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<div class="modal-dialog">
	<div class="modal-content">
		<div class="modal-header">
			<button type="button" class="close reload-button"
				data-dismiss="modal" aria-hidden="true">&times;</button>
			<h4 class="modal-title" id="myModalLabel">编辑经书</h4>
		</div>
		<div class="modal-body" id="content-body">
			<form role="form" action="${appName}/book/book-update" enctype="multipart/form-data" onsubmit="return check()" method="post" class="form-horizontal">
			<div aria-hidden="true" class="alert alert-danger" id="errorMsg"
					style="display: none;"></div>
				<input type="hidden" name="icon" value="${iconUrl}" id="icon">
				<input type="hidden" name="id" value="${id}" id="icon">
					
				<div class="form-group">
					<label class="col-sm-3 control-label">经书名称：</label>
					<div class="col-sm-9">
						<input type="text" placeholder="必填" class="form-control"
							name="name" id="name" value="${name}">
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">作者：</label>
					<div class="col-sm-9">
						<input type="text" class="form-control"
							name="author" id="author" value="${author}">
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
							<c:if test="${iconUrl!=null}">
								<img
									src="${iconUrl}"
									id="preview2" width="200px" height="100px" style="diplay: none" />
							</c:if>
							<c:if test="${iconUrl==null}">
                       			<img src="<%=request.getContextPath()%>/resources/css/background.png"
                       	 		id="preview2" width="300px" height="300px" style="diplay:none"/>
                       	 	</c:if>
			       		</div>
						<div class="btn btn-info text2" >删除</div>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label">白话版：</label>
					<div class="col-sm-9" id="localNormal">
					    <input id="lefile3" name="normal" type="file" style="display: none" />
					    <a class="btn btn-warning" onclick="$('input[id=lefile3]').click();">浏览</a>
					    <div>
							<c:if test="${normalUrl != null }">
							    <a target="_blank" id="normalA" name="normalA" href="${normalUrl}"> 
	                                ${normalName}
	                            </a>
							</c:if>
						</div>
					    <div class="btn btn-info text3" >删除</div>
					</div>
				</div>
				
				<div class="form-group">
                    <label class="col-sm-3 control-label">古译版：</label>
                    <div class="col-sm-9" id="localAncient">
                        <input id="lefile4" name="ancient" type="file" style="display: none" />
                        <a class="btn btn-warning" onclick="$('input[id=lefile4]').click();">浏览</a>
                        <div>
	                        <c:if test="${ancientUrl != null }">
	                            <a target="_blank" id="ancientA" name="ancientA" href="${ancientUrl}"> 
	                                ${ancientName}
	                            </a>
	                        </c:if>
                        </div>
                        <div class="btn btn-info text4" >删除</div>
                    </div>
                </div>
				
				<input type="hidden" type="text" name="del2" id="del2"  value="" />
				<input type="hidden" type="text" name="del3" id="del3"  value="" />
				<input type="hidden" type="text" name="del4" id="del4"  value="" />
				
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
					alert("您上传的图片格式不正确，请重新选择!");
					return false;
				}
				imgObjPreview.style.display = 'none';
				document.selection.empty();
			}
		}else{
			alert("您上传的图片格式不正确，经书封面只允许使用PNG格式的图片，请重新选择!");
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
		
		// 封面
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
		
		// 白话版
		$("#localNormal").hover(function(){
            $(this).find(".text3").slideDown();
            },function(){
            $(this).find(".text3").slideUp();
         });
            
        $(".text3").bind("click", function(){
            $("#normalA").text("");
            $("#normalA").attr("href", "");
            var elem = document.getElementById("del3");
            elem.value = "true";
        });
        
        // 古译版
        $("#localAncient").hover(function(){
            $(this).find(".text4").slideDown();
            },function(){
            $(this).find(".text4").slideUp();
         });
            
        $(".text4").bind("click", function(){
            $("#ancientA").text("");
            $("#ancientA").attr("href", "");
            var elem = document.getElementById("del4");
            elem.value = "true";
        });
	});
	
	function check(){
        var name=$("input[name='name']").val();
        if(name==''||name==null){
            $("#errorMsg").addClass("alert-danger alert").html("经书名称不能为空！").show();
            return false;
        }
        //var img=$("#preview2")[0].src;
        //if(img==''||img==null){
        //    $("#errorMsg").addClass("alert-danger alert").html("封面图不能为空！").show();
        //    return false;
        //}
        var normalA=$("a[name='normalA']").text();
        if(normalA==''||normalA==null){
            $("#errorMsg").addClass("alert-danger alert").html("白话版不能为空！").show();
            return false;
        }
        var ancientA=$("a[name='ancientA']").text();
        if(ancientA==''||ancientA==null){
            $("#errorMsg").addClass("alert-danger alert").html("古译版不能为空！").show();
            return false;
        }
        return true;
    }
  </script>

