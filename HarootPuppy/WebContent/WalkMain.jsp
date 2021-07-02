<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
String cp = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WalkMain.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/menuStyle.css">
<link rel="stylesheet" type="text/css" href="<%=cp%>/css/main.css">
<!-- jQuery JS -->
<script type="text/javascript"
	src="http://code.jquery.com/jquery.min.js"></script>
<script type="text/javascript" src="/HarootPuppy/js/jquery-ui.js"></script>
<!-- jQuery-UI CSS -->
<link rel="stylesheet" type="text/css"
	href="/HarootPuppy/css/jquery-ui.css">

<!--  부트스트랩 JS -->
<script type="text/javascript" src="/HarootPuppy/js/bootstrap.js"></script>
<!-- 부트스트랩 CSS -->
<link rel="stylesheet" href="/HarootPuppy/css/bootstrap.css">

<style type="text/css">
.cardImage {
	border: 5px solid #ffc107;
	-webkit-border-radius: 50px;
	max-width: 200px;
	height: 200px;
	margin: 0px auto;
}

.cardImage:hover {
	color: #212529;
	background-color: #e0a800;
	border-color: #d39e00;
}

.Image {
	width: 460px;
	height: 300px;
	float: center;
	padding-right: 0px;
	padding-left: 160px;
}

body {
	margin: 100px;
}

.table {
	margin: 0px auto !important;
}
</style>

<script type="text/javascript">
  
        var openWin;
    
        function openChild()
        {
            // window.name = "부모창 이름"; 
            window.name = "parentForm";
            // window.open("open할 window", "자식창 이름", "팝업창 옵션");
            openWin = window.open("WalkPlaceSelect.jsp",
                    "childForm", "width=570, height=350, resizable = no, scrollbars = no");    
        }
        
       /*  function setChildText(){
            openWin.document.getElementById("cInput").value = document.getElementById("pInput").value;
        }
  */
</script>


</head>
<body>

	<!-----------------------------
  Sample.jsp
  - 페이지 설명
------------------------------->
	<div>
		<div>
			<!-- 메뉴영역 -->
			<div id="harootHeader">
				<c:import url="Main.jsp"></c:import>
			</div>
		</div>

		<!-- content 영역 -->
		<div id="harootContent">
			<div>
				<table style="text-align: center;">
					<tr>
						<th>내 주변 산책 핫플레이스&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
							type="button" value="위치 재설정" onclick="openChild()"><br>
						</th>
						<th>산책할 반려견&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
							type="button" value="수정">
						</th>
					</tr>
					<tr>
						<td
							style="width: 300px; height: 280px; padding-left: 40px; padding-right: 40px;">
							<div id="map" style="width: 300px; height: 300px;"></div> <script
								type="text/javascript"
								src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c980959de9d6957591bdf2f69c03ce68"></script>
							<script>
								var container = document.getElementById('map');
								var options = {
									center : new kakao.maps.LatLng(
											37.383431730893726,
											126.96076431156959),
									level : 3
								};

								var map = new kakao.maps.Map(container, options);
								var map = new kakao.maps.Map(container, options);
							</script>
						</td>
						<td><img class="Image" src="/HarootPuppy/images/coco.png"
							style="width: 380px; height: 280px; padding-right: 40px; padding-left: 40px;">
						</td>
					</tr>
					<tr>
						<td>기준 주소지 : 경기도 고양시 일산서구 주엽로 98</td>
						<td>재롱이</td>
					</tr>
				</table>
			</div>

			<!-- <div style="width: 50%; float: center;">
		<div>
			<h5 style="float: left; padding-left: 160px; padding-right: 90px;">산책할 나의 반려견</h5>
			<input type="button" value="수정">
		<br>
			<img class = "Image" src="/HarootPuppy/images/coco.png" style="width: 300px;"> 
			<h5 style="padding-left: 690px;">재롱이</h5>
			여기 여백 padding-left: 690px; 준 부분 이렇게 주면 안될듯 함.,,,같이 고민 plz
		</div>
	</div> -->

			<br> <br>

			<div>
				<table border="1" style="text-align: center;">
					<tr>
						<th>반경</th>
						<td>
							<form action="" name="radiusForm" method="post">
								<select name="radiusSelect" class="selectField">
									<option value="0.5">500m</option>
									<option value="1">1Km</option>
									<option value="2">2Km</option>
									<option value="3">3Km</option>
								</select>
							</form>
						</td>
					</tr>
					<tr>
						<th>산책 출발 시간</th>
						<td>
							<form action="" name="timeForm" method="post">
								<select name="timeSelect" class="selectField">
									<option value="1h">1시간 이내</option>
									<option value="2h">2시간 이내</option>
									<option value="3h">3시간 이내</option>
									<option value="4h">4시간 이내</option>
									<option value="etc">상관없음</option>
								</select>
							</form>
						</td>
					</tr>
					<tr>
						<th>반려견 크기</th>
						<td><label for="big"> <input type="checkBox"
								name="checkGroup" id="big" value="big">&nbsp;대형견
						</label> <label for="midium"> <input type="checkBox"
								name="checkGroup" id="midium" value="midiun">&nbsp;중형견
						</label> <label for="small"> <input type="checkBox"
								name="checkGroup" id="small" value="small">&nbsp;소형견
						</label></td>
					</tr>
					<tr>
						<th>중성화 여부</th>
						<td><label for="necc"> <input type="radio"
								name="necc" id="necc" value="necc">&nbsp;필수
						</label> <label for="neccdontcare"> <input type="radio"
								name="necc" id="neccdontcare" value="neccdontcare">&nbsp;상관없음
						</label></td>
					</tr>
					<tr>
						<th>입질 여부</th>
						<td><label for="noBite"> <input type="radio"
								name="bite" id="noBite" value="no">&nbsp;입질 없는 반려견만
						</label> <label for="bitedontcare"> <input type="radio"
								name="bite" id="bitedontcare" value="bitedontcare">&nbsp;상관없음
						</label></td>
					</tr>
					<tr>
						<th>양육자 성별</th>
						<td><label for="sameSex"> <input type="radio"
								name="sex" id="sameSex" value="same">&nbsp;동일 성별만
						</label> <label for="sexdontcare"> <input type="radio" name="sex"
								id="sexdontcare" value="sexdontcare">&nbsp;상관없음
						</label></td>
					</tr>
				</table>
			</div>
			<br>
			<div>
				<input type="button" value="검색" style="float: right;"> <label
					for="onlyAble" style="float: right;"> <input
					type="checkBox" name="able" id="onlyAble" value="onlyAble">&nbsp;참여가능한
					방만 보기&nbsp;&nbsp;
				</label>
			</div>

		</div>
		<!-- 하단 회사 설명 영역 -->
		<div id="harootFooter">
			<c:import url="MainFooter.jsp"></c:import>
		</div>
	</div>
</body>
</html>