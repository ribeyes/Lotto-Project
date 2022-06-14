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
				$('#buttonNum').append("<button type='button' style='margin-right:5px' onclick=''>" + "자동" + "</button>");
				
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
	
	function numReset(){
		$("#selectedNum").empty();
	}
</script>
</body>
</html>