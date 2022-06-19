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
	<fieldset id="fieldset1" style="width: 400px">
		<legend>게임수 선택(최대 5게임)</legend>
		<form>
			<label>게임 수 : <select id="gameNum" onchange="gameNumChange()">
					<option value="none" >=== 선택 ===</option>
					<option>1</option>
					<option>2</option>
					<option>3</option>
					<option>4</option>
					<option>5</option>
				</select>
			</label>
			<button type="button" id="gameSelect">확인</button>
			<button type="button" id="cancelSelect" onclick="cancelNum()">취소</button>
		</form>
	</fieldset>

	<fieldset id="fieldset2" style="width: 400px; display: none">
		<legend>번호 선택(최대 6개)</legend>
		<form id="buttonNumForm">
			<ul id='date' style='list-style:none'></ul>
			<div id='buttonNum'></div>
			<br><label>번호 : </label>
			<div id='selectedNum' style='display: inline'></div>
			<br><br><button type='button' id='inputGame' style='margin-right:5px' onclick='registerNum()'>확인</button>
			<button type='button' style='margin-right:5px' onclick='numReset()'>초기화</button>
			<button type='button' style='margin-right:5px' onclick='autoNum()'>자동</button>
			<button type='button' style='margin-right:5px' onclick='autoAll()'>전부자동</button>
		</form>
	</fieldset>

	<fieldset id="fieldset3" style="width: 400px; display: none">
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

	<%-- 게임수 변경시 --%>
	function gameNumChange(){
		let changeNum = $('#date').children('li').length;
		let btnExist = $("#li0").children('button').length;
		let winExist = $("#winNum").children('button').length;
		let none = $("#gameNum :selected").val();
		
		 
		if(changeNum > 0 && none != "none"){
			const result = confirm("변경하면 초기화됩니다.");
			if(result){
				$('#date').children("li").remove();
			
				if(btnExist > 0){
					$("#selectedNum").empty();
					
					for(let i = 0; i < 5; i++) {
						btnExist = $("#li"+i).children('button').length;
						if(btnExist > 0){
							$("#li"+i).empty();
						}
						else{
							break; 
						}
					}
				}
				if(winExist > 0) {
					$("#winNum").children('button').remove();
					$("#winNum").children('label').remove();
				}
			
			}
			else{
				(function () {
				let previous;
				 $("#gameNum").focus(function () {
				        // Store the current value on focus, before it changes
				        previous = this.value;
				    }).change(function() {
				        // Do soomething with the previous value after the change
				        console.log(previous);
				        
				        previous = this.value;
				    });
				})();
			}
		}
		
		
	}
	
	<%-- 취소 버튼 기능 --%>
	function cancelNum(){
		let btnExist = $("#li0").children('button').length;
		let winExist = $("#winNum").children('button').length;
		let gameNum = $("#gameNum :selected").val();
		let result = confirm("취소하겠습니까?");
		if(result){
			$('#date').children('li').remove();
			if(btnExist > 0){
				$("#selectedNum").empty();
				
				for(let i = 0; i < 5; i++) {
					btnExist = $("#li"+i).children('button').length;
					if(btnExist > 0){
						$("#li"+i).empty();
					}
					else{
						break; 
					}
				}
			}
			if(winExist > 0) {
				$("#winNum").children('button').remove();
				$("#winNum").children('label').remove();
			}
		}
		
	}

	<%-- 전부자동 버튼 기능 --%>
	function autoAll(){
		/* 당첨번호가 표시되어 있는 상태면 실행 불가 */
		let winNum = $("#winNum").children("button").length;
		if(winNum > 0) return;
			
		let gameNum = $("#gameNum :selected").val();
		let btnExist;
		for(let i = 0; i < gameNum; i++) {
			btnExist = $("#selectedNum").children('button').length;
			/* 선택된 번호가 있는지 점검 */
			if(btnExist > 0){
				alert("아직 완료하지 않은 게임이 있습니다.");
				return;
			}
			else{
				let lottoNum = [];
				let randomNum;
				let sameNum;				
				btnExist = $("#li"+i).children('button').length;
				if(btnExist == 0){
					for(let j = 0; j < 6; j++) {
						randomNum = Math.floor(Math.random() * 45 + 1);
						sameNum = lottoNum.includes(randomNum);
						if(sameNum) j--;
						else lottoNum.push(randomNum);
					}
					lottoNum.sort(function (a, b) { // 오름차순 정렬 함수
						  return a - b;
					}); 
					
					$("#li"+i).append("<label style='margin-right:20px'>자동</label>");
					for(let j = 0; j < 6; j++) {
						$("#li"+i).append("<button type='button' id='registerli"+ i + lottoNum[j] + "' value=" + lottoNum[j] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
								+ lottoNum[j] + "</button>");
					}
					
				}
			}
		}
	}
	
	
	
	<%-- 발행일 날짜(현재 날짜, 요일 및 시간) --%>
	function nowDate(d){
		/* 현재 날짜 */
	    let now = new Date(d);
	    return now.getFullYear() + "-" + ('0'+(now.getMonth()+1)).slice(-2) + "-" + now.getDate() + " (" + '일월화수목금토'.charAt(now.getUTCDay())+') ' 
	    + now.getHours() + ":" + ('0'+now.getMinutes()).slice(-2) + ":" + ('0'+now.getSeconds()).slice(-2);
	}
	
	<%-- 현재 날짜 이후로 가장 가까운 토요일의 날짜(추첨일) --%>
	function getSaturdayDate(d) {
	    let paramDate = new Date(d); // new Date('2021-06-19'): 일요일
	 
	    let day = paramDate.getDay();
	    let diff = paramDate.getDate() - day + (day == 0 ? 6 : 6);
	    return new Date(paramDate.setDate(diff)).toISOString().substring(0, 10);
	    
	    // return : 2021-06-25 (토요일)
	}
	
	<%-- 게임수 선택하고 확인 버튼 눌렀을때 --%>
	$("#gameSelect").click(function(){
		let gameNum = $("#gameNum :selected").val();
		//console.log(gameNum);
		let date = new Date();
		let now = nowDate(date);
		let today = new Date().toISOString().substring(0, 10);
		let lottoDay = getSaturdayDate(today);
		let oneYearLater = nowDate(new Date().setFullYear(new Date().getFullYear() + 1));
		let dateExist = $('#date').children('li').length;
		/* 게임수가 선택되고 1~45 버튼이 생성이 안 되었으면 최초 1번 실행 */
		  if($('#buttonNum').children('button').length == 0){
			    $("#fieldset2").show(); // 번호선택 부분이 보이게 함.
			    $("#fieldset3").show(); // 게임 부분이 보이게 함.
			  
			    
			    if(dateExist == 0){
			    	$('#date').append("<li><label>발 행 일 &nbsp: " + now + "</label></<li>");
				    $('#date').append("<li><label>추 첨 일 &nbsp: " + lottoDay + "</label></<li>");
				    $('#date').append("<li><label>지급기한 : " + oneYearLater + "</label></<li>");
			    }
			    
			    /* 1~45 번호 버튼 생성 */
				for(let i = 1; i <= 45; i++) {
		            $('#buttonNum').append("<button type='button' value=" + i + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' onclick='clickNum(this)'>" 
		            + i +"</button>"); 
		        }
				
				$('#gameTitle').append("<label id='labelGameNum' for='labelGame'> (" + gameNum + "게임)</label>");
				/* 게임수만큼 게임별로 6개 번호와 함께 표시 */
				for(let i = 0; i < 5; i++) {
		            $('#playNum').append("<li id='li" + i + "'>  </li><br>"); 
		        }
			}
		  else{
			  if(dateExist == 0){
			    	$('#date').append("<li><label>발 행 일 &nbsp: " + now + "</label></<li>");
				    $('#date').append("<li><label>추 첨 일 &nbsp: " + lottoDay + "</label></<li>");
				    $('#date').append("<li><label>지급기한 : " + oneYearLater + "</label></<li>");
			    }
			  $("#labelGameNum").text(" (" + gameNum + "게임)");
		  }
	});
	
	<%-- 1~45 버튼 눌렀을때 --%>
	function clickNum(num){
		/* 당첨번호가 표시되어 있는 상태면 실행 불가 */
		let winNum = $("#winNum").children("button").length;
		if(winNum > 0) return;
		
		/* 선택한 번호가 중복되는 것이 있는지 체크 */
		let selectedNumAry = [];
		let numCount = $("#selectedNum").children('button').length;
		for(let i = 0; i < numCount; i++) {
			let selectedNum = $("#selectedNum").children('button:eq(' + i +')').val();
			selectedNumAry.push(selectedNum);
		} 
		
		let sameNum = selectedNumAry.includes($(num).val());
		if(sameNum){
			alert("같은 번호를 선택했습니다!");//같은 번호 선택하면 알림창
			return;
		} 
			
		
		
		let gameNum = $("#gameNum :selected").val();
		let btnExist = $("#li" + (gameNum-1)).children("button").length; 
		/* 선택할 수 있는 번호 개수는 최대 6개까지 */
		if(numCount < 6 && btnExist == 0){
			$("#selectedNum").append("<button type='button' name='passive' value=" + $(num).val() + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
			+ $(num).val() + "</button>");
		}
		
	}
	
	<%-- 번호 6개 선택하고 확인 버튼 눌렀을때 --%>
	function registerNum(){
		let numCount = $("#selectedNum").children('button').length;
		let gameNum = $("#gameNum :selected").val();
		if(numCount == 6){
			 
			let firstBtnName = $("#selectedNum").children('button:eq(0)').attr("name");
			let lastBtnName = $("#selectedNum").children('button:eq(5)').attr("name");
			let btnExist;
			let listIdx;
			/* 현재 게임이 자동 or 반자동 or 수동인지 표시*/
			for(let i = 0; i < 5; i++){
				btnExist = $("#li"+i).children('button').length;
				if(btnExist == 0) {
					listIdx = i;
					break;
				} 
			}
			
			if(firstBtnName == "passive" && lastBtnName == "passive"){//수동
				$("#li"+listIdx).append("<label style='margin-right:20px'>수동</label>" );
			}
			else if(firstBtnName == "passive" && lastBtnName == "auto"){//반자동
				$("#li"+listIdx).append("<label style='margin-right:5px'>반자동</label>" );
			}
			else{//자동
				$("#li"+listIdx).append("<label style='margin-right:20px'>자동</label>" );
			}
			
			
			let numAry = [];
			/* 번호 오름차순으로 */
			for(let i = 0; i < 6; i++){
				let num = $("#selectedNum").children('button:eq(' + i +')').val();
				numAry.push(num);
			}
			numAry.sort(function (a, b) { // 오름차순 정렬 함수
				  return a - b;
			});
			
			/* 선택한 6개 번호를 비어있는 게임에 등록 */
			for(let i = 0; i < gameNum; i++){
				let playNum = $("#playNum").children('li:eq(' + i +')').attr('id');
				let btnCount = $("#"+ playNum).children('button').length;
				if(btnCount != 6){
					for(let j = 0; j < 6; j++){
						$("#"+playNum).append("<button type='button' id='register"+ playNum + numAry[j] + "' value=" + numAry[j] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
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
		/* 당첨번호가 표시되어 있는 상태면 실행 불가 */
		let winNum = $("#winNum").children("button").length;
		if(winNum > 0) return;
		
		let numCount = $("#selectedNum").children('button').length;
		let numRemain = 6 - numCount; 
		let gameNum = $("#gameNum :selected").val();
		let btnExist = $("#li"+(gameNum-1)).children("button").length;
		
		
		/* 선택한 번호 6개가 안 되는 상태에서 '자동' 눌러야 실행*/
		if(numCount < 6 && btnExist == 0){
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
			
			//let numAry = selectedNumAry.concat(randomNumAry);
			let numAry = randomNumAry;
			
			/* 화면에 번호 표시 */
			//$("#selectedNum").children("button").remove();
			for(let i = 0; i < numAry.length; i++){
				$("#selectedNum").append("<button type='button' name='auto' value=" + numAry[i] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
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
		
		if(numCount == 0){
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
		
		/* 2등 번호 생성 */
		let rank2Num;
		while(true){
			rank2Num = Math.floor(Math.random() * 45 + 1);
			sameNum = randomAry.includes(rank2Num);
			if(!sameNum) break;
		}
		
		/* 화면에 번호 표시 */
		for(let i = 0; i < 6; i++){
			$("#winNum").append("<button type='button' id='color" + randomAry[i] +"' value=" + randomAry[i] + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%' >" 
					+ randomAry[i] + "</button>");
			
		}
		$("#winNum").append("<label>   + </label><button type='button' id='color" + rank2Num +"' value=" + rank2Num + " style='width: 30px; height: 30px; margin:5px; border-radius: 30%'>" 
				+ rank2Num + "</button>");
				
		/* 일치하는 번호 확인 */
		let gameCount = $("#playNum").children("li").length;
		let sameGameNum;
		let sameRank2;
		let cssRank2;
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
				else{
					sameRank2 = btnNum;
					cssRank2 = "register"+ playNum + btnNum;
				}
			}
			
			let gameAry = [];
			for(let j = 0; j < 6; j++){
				gameAry = $('#li'+i).children('button:eq(' + j +')').val();
			}
			
			/* 2~6개의 일치하는 개수로 1~5 등수 출력 */
			switch(winCount){
			case 6:
				$("#li"+i).append("<label id=r1 style='margin-left:10px'>: 1등</label>");
 				break;
			case 5:
				sameGameNum = gameAry.includes(rank2Num);
				if(sameGameNum) {
					$("#li"+i).append("<label id=r2 style='margin-left:10px'>: 2등</label>");
					$("#" + cssRank2).css("border", "3px solid #E10C0C");
				}
				else $("#li"+i).append("<label id=r3 style='margin-left:10px'>: 3등</label>");
 				break;
			case 4:
				$("#li"+i).append("<label id=r4 style='margin-left:10px'>: 4등</label>");
 				break;
			case 3:
				$("#li"+i).append("<label id=r5 style='margin-left:10px'>: 5등</label>");
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