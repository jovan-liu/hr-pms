<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/commons/jsp-head.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="../../assets/ico/favicon.ico">
<title>授权验证</title>
<%@ include file="/commons/html-css.jsp"%>
<%@ include file="/commons/html-compatible.jsp"%>
<link href="<%=request.getContextPath()%>/resources/css/dashboard.css"
	rel="stylesheet">
</head>
<%@ page session="false" %>
<body>

	<!-- 头部嵌入页面 -->
	<%@ include file="/commons/head.jsp"%>
	<div class="container-fluid">
		<div class="row">
			<!-- 左边菜单栏 -->
			<%@ include file="/commons/left.jsp"%>
			<div class="container" margin-left:50%; left:-384px;>
				<form class="form-signin" role="form" method="post" onsubmit="formSubmit()" action="<%=request.getContextPath()%>/base/base-power-check" style="margin: auto; width: 315px;">
					<h2 class="form-signin-heading">输入${rtxnumber}授予的授权码</h2>
					<div id="errorMsg" class="alert alert-danger" style="display:none;"></div>
						<input name="acceptcode" size="50" style="height: 40px;"
							type="text" size="50" class="form-control" placeholder="授权码" required autofocus>
					<button size="50" class="btn btn-lg btn-primary btn-block" type="submit">确认</button>
					<input type="hidden" name="fromUrl" value="${fromUrl}" />
					<input type="hidden" name="permission" value="${permission}" />
					<input type="hidden" name="powercode" value="${powercode}" />
				</form>
			</div>
		</div>
	</div>
</body>
<%@ include file="/commons/html-js.jsp"%>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true"></div>
<script type="text/javascript">
		
      var errMsg="${errorMsg}";

      $(function(){
          $("#errorMsg").hide();
          if(errMsg!="")
          {
              $("#errorMsg").empty().append(errMsg).show();
          }
      });
      
      function formSubmit() {
			return true;
		}
  </script>
</html>
