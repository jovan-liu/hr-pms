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
<title>login</title>
<%@ include file="/commons/html-css.jsp"%>
<%@ include file="/commons/html-compatible.jsp"%>
<%@ page session="true" %>
<link href="<%=request.getContextPath()%>/resources/css/account/signin.css"
	rel="stylesheet">
</head>
<body>
	
	<div class="container">
		<form class="form-signin" role="form" method="post" onsubmit="formSubmit()" action="<%=request.getContextPath()%>/account/login">
			<h2 class="form-signin-heading">Please sign in</h2>
			<div id="errorMsg" class="alert alert-danger" style="display:none;"></div>
			<input name="username" type="text" class="form-control"
				placeholder="用户名" required autofocus> 
			<input name="password"
				type="password" class="form-control" placeholder="密码" required>
			<%-- <c:if test="${isouterIP==1}">
				<input name="acceptcode"  
					type="text" size="50" class="form-control" placeholder="手机验证码" required autofocus>
			 </c:if> --%>
			<button class="btn btn-lg btn-primary btn-block" type="submit">Sign
				in</button>
		</form>
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
	    	var username=$("input[name='username']").val();
	  		if(username==''||username==null){
	  			$("#errorMsg").addClass("alert-danger alert").html("用户名不能为空！").show();
	  			return false;
	  		}
	  		var password=$("input[name='password']").val();
	  		if(password==''||password==null){
	  			$("#errorMsg").addClass("alert-danger alert").html("名称不能为空！").show();
	  			return false;
	  		}
			return true;
		}
  </script>
</html>
