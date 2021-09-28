<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<script type="text/javascript" >
$(document).ready(function() {
	
	//메뉴 on 유지.
	navActive('community');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "후기 상세");
	$("#metaDescription").attr("content", "한줄요약내용");
	$("#metaKeywords").attr("content", "#키워드,#좋아요");
	
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
	location.href= "${contextPath}/sampleCommunityList";
}

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">후기 등록 화면</h2></header>
	
	<form:form commandName="communityBean" name="myForm" action="" method="post" enctype="multipart/form-data" class="form-horizontal">
	<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td width="20%">
				<label for="title"><span class="redFont"> * </span> 제목 </label>
			</td>
			<td>
				<input type="text" class="form-control" id="title" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="summary"><span class="redFont"> * </span> 한줄 요약</label> </td>
			<td>
				<input type="text" class="form-control" id="summary" name="" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="reviewType"><span class="redFont"> * </span> 후기 </label> </td>
			<td>
				<select class="form-control" name="reviewtype" id="reviewType" >
					<option value="01">캠핑/글램핑</option>
					<option value="02">관광지</option>
				</select>
				<input type="hidden" name="" value="">
			</td>
		</tr>
		<tr>
			<td width="20%"><label for="star_1"><span class="redFont"> * </span> 별등급</label></td>
			<td>
				<c:forEach var="i" begin="1" end="5" varStatus="status">
				<label for="star_${i}">
					<input type="radio" class="" id="star_${i}" name="starRanking" value="${i}">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
					  <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
					</svg>
					${status.count}
				</label>
				</c:forEach>
			</td>
		</tr>
		<tr>
			<td><label for="imgFile"><span class="redFont"> * </span> 대표 타이틀 이미지 </label> </td>
			<td>
				<input type="file" name="imgFile" value="" accept=".jpg, .jpeg, .png, .gif">
				<input type="hidden" class="" id="imgUrl" name="imgUrl" value="">
			</td>
		</tr>
		<tr>
			<td><label for="multipleImgFile"><span class="redFont"> * </span> 후기 이미지(여러장 올리기) </label> </td>
			<td>
				<input type="file" multiple name="multipleImgFile" value="" accept=".jpg, .jpeg, .png, .gif">
				<input type="hidden" class="" id="multipleImgFileUrl" name="multipleImgFileUrl" value="">
				<input type="hidden" class="" id="multipleImgFileNum" name="" value="">
			</td>
		</tr>
		<tr>
			<td><span class="redFont"> * </span> 내용</td>
			<td>
				<textarea rows="10" cols="3"  class="form-control summernote" name=""></textarea>
			</td>
		</tr>
		<tr>
			<td><label for="regKeyword">등록 키워드</label></td>
			<td>
				<input type="text" class="form-control" name="regKeyword" id="regKeyword" value="" placeholder="#키워드,#입력해주세요.">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" class="btn btn-primary" value="등록" onclick="return inputSave()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			</td>
		</tr>
	</table>
	</form:form>
</div>  
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>   