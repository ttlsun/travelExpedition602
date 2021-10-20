<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/top.jsp" %>   

<style type="text/css">
	th{
		text-align: center;
		vertical-align: center;
	}
	tr{
		vertical-align: center;
	}
</style>

<script type="text/javascript" >

$(document).ready(function() {
	//메뉴 on 유지.
	navActive('bCamping');
	
	$("#metaTitle").attr("content", "캠핑 객실 등록");
	$("#metaDescription").attr("content", "캠핑 객실 등록");
	$("#metaKeywords").attr("content", "#캠핑리스트, #글램핑리스트, #캠핑 객실 등록");
	
  	//summernote 선언
	$('.summernote').summernote({
	 	height: 200,   //set editable area's height
	 	placeholder : "설명 입력해주세요.", //placeholder
	  	codemirror: { // codemirror options
	   		theme: 'monokai'
	  	}
	});
	
	//summernote 저장시 사용
	var save = function() {
	  	var markup = $('.click2edit').summernote('code');
	  	$('.click2edit').summernote('destroy');
	};
	
});

//등록버튼 클릭시
function inputSave() {
	if (!confirm('등록 하시겠습니까?')){
		return false;
	}
	
	return true;	
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/bCampingList.do?pageNumber=${pageNumber}";
	
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="goList()">
	</div>
	
	<header><h2 align="center" class="text-primary">캠핑장 객실 등록</h2></header>
	
	<form:form commandName="room" name="myform" action="bRoomRegister.do" method="post" enctype="multipart/form-data" class="form-horizontal">
	<input type="hidden" name="pageNumber" value="${pageNumber }">
	<input type="hidden" name="regid" value="${userId}">
	<input type="hidden" name="cnum" value="${cnum}">
	<input type="hidden" name="cname" value="${cname }">
	<input type="hidden" name="camptype" value="${camptype }">
	
	<table border="1" class="table table-bordered">
		<caption> <span class="redFont"> * </span> 표시는 필수 입력사항입니다. </caption>
		<tr class="active">
			<td colspan="4">
				<label for="cname"><span style="color:navy; font-size: 16px">${cname }</span></label>
			</td>
		</tr>
		<tr>
			<th width="12%"><label for="name"><span class="redFont"> * </span> 객실 명칭 </label></th>
			<td width="38%">
				<input type="text" class="form-control" id="name" name="name" value="${room.name }" placeholder="객실명을 입력하세요.">
				<form:errors cssClass="errMessage" path="name"/>
			</td>
			<th width="12%"><label for="roomtype"><span class="redFont"> * </span> 객실 타입 </label></th>
			<td width="38%">
				<c:if test="${fn:contains(camptype,'01')}">
					<input type="radio" id="roomtype" name="roomtype" value="01"
						<c:if test="${room.roomtype eq '01'}"> checked</c:if>>&nbsp;일반캠핑장&nbsp;
				</c:if>
				<c:if test="${fn:contains(camptype,'02')}">
					<input type="radio" id="roomtype" name="roomtype" value="02"
						<c:if test="${room.roomtype eq '02'}"> checked</c:if>>&nbsp;자동차캠핑장&nbsp;
				</c:if>
				<c:if test="${fn:contains(camptype,'03')}">
					<input type="radio" id="roomtype" name="roomtype" value="03"
						<c:if test="${room.roomtype eq '03'}"> checked</c:if>>&nbsp;글램핑&nbsp;
				</c:if>
				<c:if test="${fn:contains(camptype,'04')}">
					<input type="radio" id="roomtype" name="roomtype" value="04"
						<c:if test="${room.roomtype eq '04'}"> checked</c:if>>&nbsp;카라반&nbsp;
				</c:if>
				<form:errors cssClass="errMessage" path="roomtype"/>
			</td>
		</tr>
		<tr>
			<th><label for="propguests"><span class="redFont"> * </span> 적정 인원 </label></th>
			<td>
				<input type="number" class="form-control" id="propguests" name="propguests" value="${room.propguests }">
				<form:errors cssClass="errMessage" path="propguests"/>
			</td>
			<th><label for="maxguests"><span class="redFont"> * </span> 최대 인원 </label></th>
			<td>
				<input type="number" class="form-control" id="maxguests" name="maxguests" value="${room.maxguests }">
				<form:errors cssClass="errMessage" path="maxguests"/>
			</td>
		</tr>
		<tr>
			<th><label for="weekdayprice"><span class="redFont"> * </span> 주중 가격 </label></th>
			<td>
				<input type="text" class="form-control" id="weekdayprice" name="weekdayprice" value="${room.weekdayprice }" placeholder="숫자로만 입력하세요. ex) 99000">
				<form:errors cssClass="errMessage" path="weekdayprice"/>
			</td>
			<th><label for="weekendprice"><span class="redFont"> * </span> 주말 가격 </label></th>
			<td>
				<input type="text" class="form-control" id="weekendprice" name="weekendprice" value="${room.weekendprice }" placeholder="숫자로만 입력하세요. ex) 99000">
				<form:errors cssClass="errMessage" path="weekendprice"/>
			</td>
		</tr>
		<tr>
			<th><label for="summary"> 객실 한줄 소개글 </label></th>
			<td colspan="3">
				<input type="text" class="form-control" id="summary" name="summary" value="${room.summary }" placeholder="객실 목록 외부에 노출됩니다.">
			</td>
		</tr>
		<tr>
			<th><label for="imgFile"><span class="redFont"> * </span> 객실 대표 이미지 </label> </th>
			<td colspan="3">
				<input type="file" id="imgFile" name="updateFile" accept=".jpg, .jpeg, .png, .gif">
				<input type="hidden" name="imgurl" value="${room.imgurl}">
				<form:errors cssClass="errMessage" path="imgurl"/>
			</td>
		</tr>
		<tr>
			<th><label for="multipleUpdateFile"> 객실 상세 이미지<br><small>(여러 장 가능)</small> </label> </th>
			<td colspan="3">
				<input type="file" multiple id="multipleUpdateFile" name="multipleUpdateFile" accept=".jpg, .jpeg, .png, .gif" >
				<input type="hidden" name="imgname" value="${room.imgname}">
			</td>
		</tr>
		<tr>
			<th><label for="options"> 객실 시설 정보<br><small>(객실 개별 시설)</small> </label></th>
			<td colspan="3">
				<input type="text" class="form-control" id="options" name="options" value="${room.options }" placeholder="ex) 개별화장실, 개별바베큐, 싱크대, 냉장고, 싱글침대, 4인용 테이블, 의자 4개 등">
			</td>
		</tr>
		<tr>
			<th><label for="amenity"> 객실 비품 정보<br><small>(객실 내부 집기류)</small> </label></th>
			<td colspan="3">
				<input type="text" class="form-control" id="amenity" name="amenity" value="${room.amenity }" placeholder="ex) 주방 요리도구, 식기, 드라이기, 샤워용품 등">
			</td>
		</tr>
		<tr>
			<th><label for="contents"><span class="redFont"> * </span> 객실 상세 소개글 </label></th>
			<td colspan="3">
				<textarea rows="10" cols="3"  class="form-control summernote" name="contents">${room.contents }</textarea>
				<form:errors cssClass="errMessage" path="contents"/>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="button" class="btn btn-default" value="돌아가기" onclick="goList()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="submit" class="btn btn-primary" value="등록" onclick="return inputSave()">
			</td>
		</tr>
		
	</table>
	</form:form>
	
</div>
</article>
</section>



<%@ include file="../../../common/bottom.jsp" %>