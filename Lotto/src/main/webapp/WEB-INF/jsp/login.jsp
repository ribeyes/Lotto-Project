<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 페이지</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
<fieldset style="width: 400px">
		<legend>Login</legend>
	<form>
		<input type="text" id="userId" placeholder="아이디">
		<label id="idCheck" style="font-size: 9pt; color: red"></label><br>
		<input type="password" id="userPw" placeholder="비밀번호">
		<label id="pwCheck" style="font-size: 9pt; color: red"></label><br>
			
		<input type="button" id="login" value="로그인" style="margin-top:5px">
		<input type="button" value="회원가입" style='margin-top:5px' onclick="signUp()">
	</form>
</fieldset>
</body>
<script>

	function signUp(){
		location.replace("signUp.do");
	}
	
	$("#userId").on("propertychange change keyup paste input", function() {
		let id = $("#userId").val();
		
		//입력 받은 ID에 공백 혹은 특수문자가 있는 경우
		if(id.search(/\W|\s/g) > -1){
			$("#idCheck").text("공백 또는 특수문자가 입력되었습니다");
		    return;
		}
		else{
			$("#idCheck").text("");
			return;
		}
		
	});
	
	$("#userPw").on("propertychange change keyup paste input", function() {
		let pw = $("#userPw").val();
		
		//입력 받은 PW에 공백 혹은 특수문자가 있는 경우
		if(pw.search(/\W|\s/g) > -1){
			$("#pwCheck").text("공백 또는 특수문자가 입력되었습니다");
		    return;
		}
		else{
			$("#pwCheck").text("");
			return;
		}
	});
	
	$("#login").click(function () {
		let id = $("#userId").val();
		let pw = $("#userPw").val();
		let noInputId = $("#userId").val().length;
		let noInputPw = $("#userPw").val().length;
		
		//'아이디' 입력창에 아무것도 입력하지 않은 경우
		if(noInputId == 0){
		    alert( '아이디가 입력되지 않았습니다.');
		    return;
		}

		//'비밀번호' 입력창에 아무것도 입력하지 않은 경우
		if(noInputPw == 0){
		    alert( '비밀번호 입력되지 않았습니다.');
		    return;
		}
		
		//입력 받은 ID에 공백 혹은 특수문자가 있는 경우
		if(id.search(/\W|\s/g) > -1){
		    alert( '아이디에 특수문자 또는 공백이 입력되었습니다.');
		    return;
		}
		
		//입력 받은 PW에 공백 혹은 특수문자가 있는 경우
		if(pw.search(/\W|\s/g) > -1){
			alert( '비밀번호에 특수문자 또는 공백이 입력되었습니다.');
		    return;
		}
		
		$.ajax({
			  url : "/loginAttempt.do",
			  type : 'POST',
			  data: {
				  "id": id,
				  "password": pw
			  },
			  dataType : "text",
			  success : function(data) {
				  console.log(data);
				  if(data == "true"){
					  alert( '로그인 되었습니다!');
					  location.replace("view.do");
				  }
				  if(data == "false"){
					  alert( '아이디 또는 비밀번호가 올바르지 않습니다!');
					  location.replace("login.do");
				  }
				  
			  },
			  error : function(){
					alert("ajax 실패");
				}
		});
		
	});
	
</script>
</html>
