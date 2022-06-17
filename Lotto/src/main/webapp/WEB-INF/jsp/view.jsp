<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로또</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<style>
	button[value='1'], [value='2'], [value='3'], [value='4'], [value='5']
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
	<fieldset id="fieldset1" style="width: 300px">
		<legend>게임수 선택(최대 5게임)</legend>
		<form>
			<label>게임 수 : <select id="gameNum" onchange="changeNum()">
					<option value="none">=== 선택 ===</option>
					<option>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
				</select>
			</label>
			<button type="button" id="gameSelect">확인</button>
		</form>
	</fieldset>

	<fieldset id="fieldset2" style="width: 400px; display: none">
		<legend>번호 선택(최대 6개)</legend>
		<form id="buttonNumForm">
			<div id='buttonNum'></div>
			<br><label>번호 : </label>
			<div id='selectedNum' style='display: inline'></div>
			<br><br><button type='button' id='inputGame' style='margin-right:5px' onclick='registerNum()'>확인</button>
			<button type='button' style='margin-right:5px' onclick='numReset()'>초기화</button>
			<button type='button' style='margin-right:5px' onclick='autoNum()'>자동</button>
		</form>
	</fieldset>

	<fieldset id="fieldset3" style="width: 420px; display: none">
		<legend id="gameTitle">게임</legend>
		<label id="winNum"> 당첨번호 : </label><br><br>
		<ol id='playNum' type="A"></ol>
		<button type='button' id='playGame' style='margin-right:5px' onclick='playGame()'>실행</button>
	</fieldset>

<script type="text/javascript">
/* $(function() {
	while(true){
		let user = prompt("이름을 입력해주세요.");
		if(user == null){
			alert("입력하지 않았습니다.");
		}
		else{
			alert("입력 완료.");
			break;
		}
	}
}); */

	<%-- 게임수 선택하고 확인 버튼 눌렀을때 --%>
	function changeNum(){
		let labelExist = $("#gameTitle").children('label').length;
		if(labelExist > 0){
			let gameNum = $("#gameNum :selected").val();
			console.log(gameNum);
			$("#labelGameNum").text(" (" + gameNum + "게임)");
		}
		
		let liExist = $("#playNum").children('li').length;
		let btnExist = $("#selectedNum").children('button').length;
		
	}

	<%-- 게임수 선택하고 확인 버튼 눌렀을때 --%>
	$("#gameSelect").click(function(){
		let gameNum = $("#gameNum :selected").val();
		/* 게임수가 선택되고 1~45 버튼이 생성이 안 되었으면 최초 1번 실행 */
		  if($('#buttonNum').children('button').length == 0){
			  
			  $("#fieldset2").show(); // 번호선택 부분이 보이게 함.
			  $("#fieldset3").show(); // 게임 부분이 보이게 함.
			  
			  
			    /* 1~45 번호 버튼 생성 */
				for(let i = 1; i <= 45; i++) {
		            $('#buttonNum').append("<button type='button' value=" + i + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' onclick='clickNum(this)'>" 
		            + i +"</button>"); 
		        }
				
				$('#gameTitle').append("<label id='labelGameNum'> (" + gameNum + "게임)</label>");
				/* 게임수만큼 게임별로 6개 번호와 함께 표시 */
				for(let i = 0; i < gameNum; i++) {
		            $('#playNum').append("<li id='li" + i + "'> (반)자동 or 수동 : </li><br>"); 
		        }
			}
	});
	
	<%-- 1~45 버튼 눌렀을때 --%>
	function clickNum(num){
		/* 선택한 번호가 중복되는 것이 있는지 체크 */
		let selectedNumAry = [];
		let numCount = $("#selectedNum").children('button').length;
		for(let i = 0; i < numCount; i++) {
			let selectedNum = $("#selectedNum").children('button:eq(' + i +')').val();
			selectedNumAry.push(selectedNum);
		} 
		
		let sameNum = selectedNumAry.includes($(num).val());
		if(sameNum) //같은 번호 선택하면 알림창
			alert("같은 번호를 선택했습니다!");
		
		/* 선택할 수 있는 번호 개수는 최대 6개까지 */
		if(numCount < 6 && !sameNum){
			$("#selectedNum").append("<button type='button' value=" + $(num).val() + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
			+ $(num).val() + "</button>");
		}
		
	}
	
	<%-- 번호 6개 선택하고 확인 버튼 눌렀을때 --%>
	function registerNum(){
		let numCount = $("#selectedNum").children('button').length;
		if(numCount == 6){
			let numAry = [];
			/* 번호 오름차순으로 */
			for(let i = 0; i < 6; i++){
				let num = $("#selectedNum").children('button:eq(' + i +')').val();
				numAry.push(num);
			}
			numAry.sort(function (a, b) { // 오름차순 정렬 함수
				  return a - b;
			}); 
			
			/* 각 게임에 선택한 6개 번호 등록 */
			for(let i = 0; i < 5; i++){
				let playNum = $("#playNum").children('li:eq(' + i +')').attr('id');
				let btnCount = $("#"+ playNum).children('button').length;
				if(btnCount != 6){
					for(let j = 0; j < 6; j++){
						$("#"+playNum).append("<button type='button' id='register"+ playNum + numAry[j] + "' value=" + numAry[j] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
								+ numAry[j] + "</button>");
						
						let num = $("#selectedNum").children('button:eq(' + i +')').val();
						
					}
					$("#selectedNum").empty();
					break;
				}
			}
		}
	}
	
	<%-- 초기화 버튼 눌렀을때 --%>
	function numReset(){
		$("#selectedNum").empty();
	}
	
	<%-- 자동 버튼 눌렀을때 --%>
	function autoNum(){
		let numCount = $("#selectedNum").children('button').length;
		let numRemain = 6 - numCount; 
		
		
		/* 선택한 번호 6개가 안 되는 상태에서 '자동' 눌러야 실행*/
		if(numCount != 6){
			let selectedNumAry = [];
			let selectedNum;
			
			/* 수동으로 선택한 번호들 저장한 배열 */
			for(let i = 0; i < numCount; i++) {
				selectedNum = $("#selectedNum").children('button:eq(' + i +')').val();
				selectedNumAry.push(selectedNum);
			}
			
			/* 1~45 번호들 저장한 배열 */
			let lottoAry = [];
			for(let i = 1; i <= 45; i++) {
				lottoAry.push(i);
			}
			
			/* 1~45 번호 중에서 선택되어 있는 수동 번호는 중복이므로 제거 */
			for(let i = 0; i < selectedNumAry.length; i++) {
				let tempNum = parseInt(selectedNumAry[i]);
				let index = lottoAry.indexOf(tempNum);
				lottoAry.splice(index, 1);
			}
			
			
			let autoAry = lottoAry;
			let randomNumAry = [];
			let randomNum;
			let sameNum;
			/* 1~45에서 수동 번호를 제거하고 나머지 번호들 중에서 자동번호를 중복없이 생성 */
			for(let i = 0; i < numRemain; i++) {
				randomNum = autoAry[Math.floor(Math.random() * autoAry.length)]; // 수동 번호 제거한 배열 안에서 랜덤값 뽑기
				sameNum = randomNumAry.includes(randomNum);
				if(!sameNum){
					randomNumAry.push(randomNum);
					let idx = autoAry.indexOf(randomNum);
					autoAry.splice(idx, 1);
				}
				else{
					i--;
				}
			}
			
			let numAry = randomNumAry.concat(selectedNumAry);
			numAry.sort(function (a, b) { // 오름차순 정렬 함수
				  return a - b;
			});
			
			/* 화면에 번호 표시 */
			$("#selectedNum").empty();
			for(let i = 0; i < 6; i++){
				$("#selectedNum").append("<button type='button' value=" + numAry[i] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
						+ numAry[i] + "</button>");
				}
			
		}
	}
	
	<%-- 실행 버튼 눌렀을때 --%>
	function playGame(){
		let numCount = $("#winNum").children('button').length;
		let randomAry = [];
		let randomNum;
		let sameNum;
		
		if(numCount != 6){
		/* 1~45 번호들 저장한 배열 */
		let lottoAry = [];
		for(let i = 1; i <= 45; i++) {
			lottoAry.push(i);
		}
		
		/* 당첨번호 생성 */
		for(let i = 0; i < 6; i++){
			randomNum = lottoAry[Math.floor(Math.random() * lottoAry.length)];
			sameNum = randomAry.includes(randomNum);
			if(!sameNum){
				randomAry.push(randomNum);
				let idx = lottoAry.indexOf(randomNum);
				lottoAry.splice(idx, 1);
			}
			else{
				i--;
			}
		}
		
		randomAry.sort(function (a, b) { // 오름차순 정렬 함수
			  return a - b;
		});
		
		/* 화면에 번호 표시 */
		for(let i = 0; i < 6; i++){
			$("#winNum").append("<button type='button' id='color" + randomAry[i] +"' value=" + randomAry[i] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
					+ randomAry[i] + "</button>");
			
		}
		
		/* 일치하는 번호 확인 */
		let gameCount = $("#playNum").children("li").length;
		let sameGameNum;	
		let winCount = 0;
		for(let i = 0; i < gameCount; i++){
			for(let j = 0; j < 6; j++){
				let btnNum = $('#li'+i).children('button:eq(' + j +')').val();
				let playNum = $("#playNum").children('li:eq(' + i +')').attr('id');
				sameGameNum = randomAry.includes(parseInt(btnNum));
				if(sameGameNum){
					$("#register"+ playNum + btnNum).css("border", "3px solid #E10C0C"); //번호 일치하면 빨간색 테두리로 표시
					winCount++;
				}
			}
			/* 2~6개의 일치하는 개수로 1~5 등수 출력 */
			switch(winCount){
			case 6:
				$("#li"+i).append("<br><label id=r1>: 1등</label>");
 				break;
			case 5:
				$("#li"+i).append("<br><label id=r2>: 2등</label>");
 				break;
			case 4:
				$("#li"+i).append("<br><label id=r3>: 3등</label>");
 				break;
			case 3:
				$("#li"+i).append("<br><label id=r4>: 4등</label>");
 				break;
			case 2:
				$("#li"+i).append("<br><label id=r5>: 5등</label>");
 				break;
 			default:
			}
			winCount = 0;
		}
		}
	}
</script>
</body>
</html>