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
	<form>
		<table>
			<tr>
				<td><label>아이디 : </label></td><td><input type="text" id="userId" placeholder="아이디를 입력하세요."></td>
			</tr>
			<tr>
				<td><label>비밀번호 : </label></td><td><input type="text" id="userPw" placeholder="패스워드를 입력하세요."></td>
			</tr>
			<tr>
				<td><label>비밀번호 확인 : </label></td><td><input type="text" id="pwCheck" placeholder="패스워드를 입력하세요."></td>
			</tr>
		</table>
		<input type="button" value="회원가입" onclick="signUp()">
	</form>
</body>
<script type="text/javascript">

<%-- ID, PW 올바르게 입력했는지 확인 --%>
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
		
		alert( '회원가입이 완료되었습니다!');
		location.href="login.do";
	}
</script>
</html>