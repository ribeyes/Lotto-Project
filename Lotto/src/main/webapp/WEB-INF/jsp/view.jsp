<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로또</title>
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
</head>
<body>
	<fieldset style="width:300px ">
		<legend>게임수 선택(최대 5게임)</legend>
		<form>
			<label>게임 수 :
			  <select id="gameNum" onchange="">
			    <option value="none">=== 선택 ===</option>
			    <option value=1> 1 </option>
			    <option value=2> 2 </option>
			    <option value=3> 3 </option>
			    <option value=4> 4 </option>
			    <option value=5> 5 </option>
			  </select>
			</label>
			<button type="button" id="gameSelect"> 확인 </button>
		</form>
	</fieldset>
	
	<fieldset id="num" style="width:400px; display:none">
		<legend>번호 선택(최대 6개)</legend>
		<form id="buttonNum">
		</form>
	</fieldset>
	
	<fieldset id="gameStart" style="width:400px; display:none">
		<legend>게임</legend>
			<ol id="startNum" type="A">
			</ol>
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
		            $('#buttonNum').append("<button type='button' value=" + i + " 'style='width: 30px; margin: 5px' onclick='clickNum(this)'>" 
		            + i +"</button>"); 
		        }
				$('#buttonNum').append("<br><br>" + "<button type='button'>" + "확인" + "</button>");
				
				/* 게임수만큼 게임별로 6개 번호와 함께 표시 */
				for(let i = 0; i < gameNum; i++) {
		            $('#startNum').append("<li id=l" + i + "style='margin-bottom: 30px'><label>"+ "(반)자동or 수동 : " + "</label></li>"); 
		        }
			}
	});
	
	<%-- 1~45 선택하고 확인 버튼 눌렀을때 --%>
	function clickNum(num){
		console.log($(num).val());
		if($('#l0').length <= 6){
			$('#l0').after("<button type='button' style='width: 30px; margin: 5px'>"+ $(num).val() +"</button>");
		} 
	}
</script>
</body>
</html>