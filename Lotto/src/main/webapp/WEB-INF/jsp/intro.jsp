<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 페이지</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
	button[value='1'], button[value='2'], button[value='3'], button[value='4'], button[value='5']
	, [value='6'], [value='7'], [value='8'], [value='9'], [value='10']{
		color : white;
		background-color : #F2BA06; //노란색
	}
	button[value='11'], [value='12'], [value='13'], [value='14'], [value='15']
	, [value='16'], [value='17'], [value='18'], [value='19'], [value='20']{
		color : white;
		background-color : #0C9DF8; //파란색
	}
	button[value='21'], [value='22'], [value='23'], [value='24'], [value='25']
	, [value='26'], [value='27'], [value='28'], [value='29'], [value='30']{
		color : white;
		background-color : #954DF2; //보라색
	}
	button[value='31'], [value='32'], [value='33'], [value='34'], [value='35']
	, [value='36'], [value='37'], [value='38'], [value='39'], [value='40']{
		color : white;
		background-color : #848484; //회색
	}
	button[value='41'], [value='42'], [value='43'], [value='44'], [value='45']{
		color : white;
		background-color : #12A80A; //초록색
	}
</style>
</head>
<body>
<fieldset style="width: 400px; font-size: 30px">
		<legend>6/45</legend>
	<div style="text-align: center; font-size: 40px">
		<label >IR 복권</label>
	</div>
	<div style="text-align: center">
		<button type="button"  onclick="login()">로그인</button>
		<button type="button"  onclick="signUp()">회원가입</button>
	</div>
	<div id="orderNum" style="text-align: center; margin-top: 20px"></div>
	<div style="text-align: center">
	<fieldset style="margin-top: 10px">
		<div id="lottoNum"></div>
	</fieldset>
	</div>
</fieldset>
</body>
<script>
	/* 지난 회 차 불러오기 */
	$.ajax({
		  url : "/orderNum.do",
		  type : 'POST',
		  dataType : "text",
		  success : function(data) {
			  let num = parseInt(data);
			  $('#orderNum').append("<label>제 " + (num-1) + "회 당첨결과</label>");
		  },
		  error : function(){
				alert("ajax 실패");
		  }
	});
	
	/* 지난 회 차 당첨번호 불러오기 */
	$.ajax({
		  url : "/lastNum.do",
		  type : 'POST',
		  dataType : "text",
		  success : function(data) {
			  let num = data.split(',');
			  for(let i = 0; i < 7; i++) {
				  if(i == 6){
					  $('#lottoNum').append("<label> + </label><button type='button' value=" + num[i] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%'>" 
					          + num[i] +"</button>");
					  return;
				  }
		          $('#lottoNum').append("<button type='button' value=" + num[i] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%'>" 
		          + num[i] +"</button>"); 
		      }
		  },
		  error : function(){
				alert("ajax 실패");
		  }
	});
	
	let num = "1,2,3,4,5";
	console.log(num.split(','));
	function login(){
		location.replace("login.do");
	}

	function signUp(){
		location.replace("signUp.do");
	}
</script>
</html>
