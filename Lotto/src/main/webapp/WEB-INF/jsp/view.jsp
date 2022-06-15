<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로또</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
	<fieldset style="width: 300px">
		<legend>게임수 선택(최대 5게임)</legend>
		<form>
			<label>게임 수 : <select id="gameNum" onchange="">
					<option value="none">=== 선택 ===</option>
					<option value=1>1</option>
					<option value=2>2</option>
					<option value=3>3</option>
					<option value=4>4</option>
					<option value=5>5</option>
				</select>
			</label>
			<button type="button" id="gameSelect">확인</button>
		</form>
	</fieldset>

	<fieldset id="num" style="width: 400px; display: none">
		<legend>번호 선택(최대 6개)</legend>
		<form id="buttonNum"></form>
	</fieldset>

	<fieldset id="gameStart" style="width: 400px; display: none">
		<legend id="gameTitle">게임</legend>
		<div id='playNum'></div>
		<button type='button' id='playGame' style='margin-right:5px' onclick='playGame()'>실행</button>
	</fieldset>

<script type="text/javascript">
	<%-- 게임수 선택하고 확인 버튼 눌렀을때 --%>
	$("#gameSelect").click(function(){
		let gameNum = $("#gameNum :selected").val();
		/* 게임수가 선택되고 1~45 버튼이 생성이 안 되었으면 최초 1번 실행 */
		  if($("#gameNum").val() != "none" && $('#buttonNum').children('button').length == 0){
			  
			  $("#num").show(); // 번호선택 부분이 보이게 함.
			  $("#gameStart").show(); // 게임 부분이 보이게 함.
			  
			  
			    /* 1~45 번호 버튼 생성 */
				for(let i = 1; i <= 45; i++) {
		            $('#buttonNum').append("<button type='button' value=" + i + " style='width: 30px; height: 30px; margin:5px' onclick='clickNum(this)'>" 
		            + i +"</button>"); 
		        }
				$('#buttonNum').append("<br><label>번호 : </label>");
				$('#buttonNum').append("<div id='selectedNum' style='display: inline'></div>");
				$('#buttonNum').append("<br><br>" + "<button type='button' id='inputGame' style='margin-right:5px' onclick='registerNum()'>" + "확인" + "</button>");
				$('#buttonNum').append("<button type='button' style='margin-right:5px' onclick='numReset()'>" + "초기화" + "</button>");
				$('#buttonNum').append("<button type='button' style='margin-right:5px' onclick='autoNum()'>" + "자동" + "</button>");
				
				$('#gameTitle').append("<lable> (" + gameNum + "게임)</label>");
				$('#playNum').append("<lable> 당첨번호 : </label><br><br>");
				/* 게임수만큼 게임별로 6개 번호와 함께 표시 */
				for(let i = 0; i < gameNum; i++) {
		            $('#playNum').append("<label id=g" + i + ">" + String.fromCharCode(65+i) +
		            		". (반)자동 or 수동 : " + "</label><br><br>"); 
		        }
			}
	});
	
	<%-- 1~45 선택하고 확인 버튼 눌렀을때 --%>
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
			console.log(numAry);
			
			/* 각 게임에 선택한 6개 번호 등록 */
			for(let i = 0; i < 5; i++){
				let playNum = $("#playNum").children('label:eq(' + i +')').attr('id');
				let btnCount = $("#"+ playNum).children('button').length;
				if(btnCount != 6 && playNum){
					for(let j = 0; j < 6; j++){
						$("#"+playNum).append("<button type='button' value=" + numAry[j] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
								+ numAry[j] + "</button>");
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
			
			/* 자동, 수동 번호들 중에 중복 제거 */
			for(let i = 0; i < selectedNumAry.length; i++) {
				let tempNum = parseInt(selectedNumAry[i]);
				let index = lottoAry.indexOf(tempNum);
				lottoAry.splice(index, 1);
			}
			
			
			let autoAry = lottoAry;
			let randomNumAry = [];
			let randomNum;
			let sameNum;
			/* 자동번호를 중복없이 생성 */
			for(let i = 0; i < numRemain; i++) {
				randomNum = autoAry[Math.floor(Math.random() * autoAry.length)];
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
		let randomAry = [];
		let randomNum;
		/* 당첨번호 생성 */
		for(let i = 0; i < 6; i++){
			randomNum = Math.floor(Math.random() * (45 - 1) + 1);
			randomAry.push(randomNum);
		}
		
		randomAry.sort(function (a, b) { // 오름차순 정렬 함수
			  return a - b;
		});
	}
</script>
</body>
</html>