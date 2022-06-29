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
	<form>
		<table>
			<tr>
				<td><label>아이디 : </label></td><td><input type="text" id="userId" placeholder="아이디를 입력하세요."></td>
			</tr>
			<tr>
				<td>비밀번호 : </td><td><input type="text" id="userPw" placeholder="비밀번호를 입력하세요."></td>
			</tr>
		</table>
		<input type="button" value="회원가입" onclick="signUp()">
		<input type="button" id="login" value="로그인">
	</form>
</body>
<script>

	function signUp(){
		location.replace("signUpPage.do");
	}
	
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
				  "pw": pw
			  },
			  dataType : "text",
			  success : function(data) {
				  
				  console.log(data);
				  if(data == "true"){
					  alert( '로그인 되었습니다!');
					  //location.replace("view.do");
				  }
				  else{
					  alert( '아이디 또는 비밀번호가 올바르지 않습니다!');
					  //location.replace("login.do");
				  }
			  },
			  error : function(){
					alert("ajax 실패");
				}
		});
		
	});
	
</script>
</html>