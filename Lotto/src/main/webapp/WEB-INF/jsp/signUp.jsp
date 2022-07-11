<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
<fieldset style="width: 500px">
		<legend>회원가입</legend>
	<form>
		
		<div>
			<input type="text" id="userId" placeholder="아이디">
			<input type="button" value="중복확인" id="sameId" onclick="sameIdCheck()">
			<label id="idLabel" style="font-size: 9pt; color: red"></label>
		</div>
		
		<div style='margin-top:6px'>
			<input type="password" id="userPw" placeholder="비밀번호">
			<label id="pwLabel" style="font-size: 9pt; color: red"></label>
		</div>
		
		<div style='margin-top:6px'>
			<input type="password" id="pwCheck" placeholder="패스워드 확인">
			<label id="sameCheck" style="font-size: 9pt; color: red"></label>
		</div>
		
		<div style='margin-top:6px'>
			<input type="button" value="가입하기" onclick="signUp()">
		</div>
		
	</form>
</fieldset>
</body>
<script type="text/javascript">

	function sameIdCheck(){
		let id = $("#userId").val();
		
		$.ajax({
			  url : "/sameId.do",
			  type : 'POST',
			  dataType : "text",
			  data: {
				  "id": id
			  },
			  success : function(data) { 
				  if(data == "true"){
					  $("#idLabel").css("color", "red");
					  $("#idLabel").text("이미 존재합니다");
					  $("#userId").val("");
				  }
				  if(data == "false"){
					  $("#idLabel").css("color", "green");
					  $("#idLabel").text("사용 가능한 아이디입니다!");
				  }
			  },
			  error : function(){
					alert("에러");
				}
		});
	}
	
	<%-- 아이디 입력 확인 --%>
	$("#userId").on("propertychange change keyup paste input", function() {
		let id = $("#userId").val();
		let idLength = $("#userId").val().length;
		
		if(idLength > 12){
			alert("12자를 초과했습니다");
			$("#userId").val("");
		}
		
		//입력 받은 PW에 공백 혹은 특수문자가 있는 경우
		if(id.search(/\W|\s/g) > -1){
			$("#idLabel").text("공백 또는 특수문자가 입력되었습니다");
		}
		else{
			$("#idLabel").text("");
		}
	});
	
	<%-- 비밀번호 입력 확인 --%>
	$("#userPw").on("propertychange change keyup paste input", function() {
		let pw = $("#userPw").val();
		let pwLength = $("#userPw").val().length;
		
		if(pwLength > 12){
			alert("12자를 초과했습니다");
			$("#userPw").val("");
		}
		
		//입력 받은 PW에 공백 혹은 특수문자가 있는 경우
		if(pw.search(/\W|\s/g) > -1){
			$("#pwLabel").text("공백 또는 특수문자가 입력되었습니다");
		}
		else{
			$("#pwLabel").text("");
		}
	});
	
	<%-- 비밀번호 일치 확인 --%>
	$("#pwCheck").on("propertychange change keyup paste input", function() {
		let pw = $("#userPw").val();
		let pwCheck = $("#pwCheck").val();
		let pwLength = $("#pwCheck").val().length;
		
		if(pwLength > 12){
			alert("12자를 초과했습니다");
			$("#pwCheck").val("");
		}
		
		if(pw == pwCheck){
			$("#sameCheck").css("color", "green");
			$("#sameCheck").text("비밀번호가 일치합니다");
		}
		else{
			$("#sameCheck").css("color", "red");
			$("#sameCheck").text("비밀번호가 일치하지 않습니다!");
		}
		
		
	});
	
	<%-- 가입하기 버튼 눌렀을때 ID, PW 올바르게 입력했는지 확인 --%>
	function signUp(){
		let id = $("#userId").val();
		let pw = $("#userPw").val();
		let pwCheck = $("#pwCheck").val();
		let noInputId = $("#userId").val().length;
		let noInputPw = $("#userPw").val().length;
		let noInputPwCheck = $("#pwCheck").val().length;
		
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
		
		//'비밀번호 확인' 입력창에 아무것도 입력하지 않은 경우
		if(noInputPwCheck == 0){
		    alert( '비밀번호 확인이 입력되지 않았습니다.');
		    return;
		}
		
		//입력 받은 '아이디'에 공백 혹은 특수문자가 있는 경우
		if(id.search(/\W|\s/g) > -1){
		    alert( '특수문자 또는 공백이 입력되었습니다.');
		    return;
		}
		
		//입력 받은 '비밀번호'에 공백 혹은 특수문자가 있는 경우
		if(pw.search(/\W|\s/g) > -1){
			alert( '특수문자 또는 공백이 입력되었습니다.');
		    return;
		}
		
		//입력 받은 '비밀번호 확인'에 공백 혹은 특수문자가 있는 경우
		if(pwCheck.search(/\W|\s/g) > -1){
			alert( '특수문자 또는 공백이 입력되었습니다.');
		    return;
		}
		
		//입력 받은 '비밀번호' 와 '비밀번호 확인'이 일치하지 않는 경우
		if(pw !== pwCheck){
			alert( '비밀번호가 일치하지 않습니다');
		    return;
		}
		
		
		$.ajax({
			  url : "/signUpRegister.do",
			  type : 'POST',
			  data: {
				  "id": id,
				  "pw": pw
			  },
			  dataType : "text",
			  success : function(data) { //수정해야함
				  if(data == "true"){
					  alert( '회원가입이 완료되었습니다!');
					  location.replace("login.do");
				  }
				  if(data == "false"){
					  alert( '회원가입 실패!');
					  location.replace("signUp.do");
				  }
			  },
			  error : function(){
					alert("에러");
				}
		});
		
	}
</script>
</html>
