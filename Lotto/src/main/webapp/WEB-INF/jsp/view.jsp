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
	<fieldset style="width:300px">
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
			<button type="submit" id="gameSelect"> 확인 </button>
		</form>
	</fieldset>
	
	<fieldset style="width:300px">
		<legend>번호 선택(최대 6개)</legend>
		<form>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
			<button type="button" > 1 </button>
		</form>
	</fieldset>
	
<script type="text/javascript">

</script>
</body>
</html>