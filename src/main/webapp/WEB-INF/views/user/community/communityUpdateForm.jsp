<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   

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
	
	//reviewtype 타입이 03(커뮤니티 후기일경우, 별등급 투표없이 가능.)
	var reviewtype = "${community.reviewtype}";
	if(reviewtype != "03"){
		$('#starDisplay').show();
	}
	
});


//등록버튼 클릭시
function inputSave() {
	if (!confirm('수정 하시겠습니까?')){
		return false;
	}
	
	$('#myForm').attr("action","communityUpdate.do").submit();
	
}

//리스트 버튼 클릭시
function goList() {
	var type = $('#type').val();
	if(type == 3){
		location.href= "${contextPath}/reservationCommunityList.do?pageNumber="+${pageNumber};
	}else if(type == 2){
		location.href= "${contextPath}/reviewCommunityList.do?pageNumber="+${pageNumber};
	}else{
		location.href= "${contextPath}/communityList.do?pageNumber="+${pageNumber};
	}
}


//상세페이지로(돌아가기) 이동 버튼
function goDetail() {
	var type = $('#type').val();
	var num = $('#num').val();
	var pageNumber = $('#pageNumber').val();
	location.href= "${contextPath}/communityDetail.do?num=" + num + "&pageNumber=" + pageNumber+"&type=" + type;
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left;" class="btn btn-default" value="돌아가기" onclick="goDetail()">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
	</div>
	<header><h2 align="center" class="text-primary">후기 수정 화면</h2></header>
	
	<form:form commandName="community" name="myForm" action="communityUpdate.do" method="post" enctype="multipart/form-data" class="form-horizontal">
	<input type="hidden" name="modid" value="${userId}">
	<input type="hidden" name="reviewnum" value="${community.reviewnum}">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${community.num}">
	<input type="hidden" name="type" id="type" value="${type}">
	<input type="hidden" name="reviewtype" id="reviewtype" value="${community.reviewtype}">
	
	<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td class="active"><label for="reviewType">후기 구분 </label> </td>
			<td>
				<c:choose>
					<c:when test="${community.reviewtype eq '01'}">캠핑/글램핑 후기</c:when>
					<c:when test="${community.reviewtype eq '02'}">관광지 후기</c:when>
					<c:otherwise>커뮤니티 후기</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td class="active">
				<label for="title"><span class="redFont"> * </span> 제목 </label>
			</td>
			<td>
				<input type="text" class="form-control" id="title" name="title" value="${community.title}" placeholder="입력해주세요.">
				<form:errors cssClass="errMessage" path="title"/>
			</td>
		</tr>
		<tr>
			<td class="active"><label for="summary"><span class="redFont"> * </span> 한줄 요약</label> </td>
			<td>
				<input type="text" class="form-control" id="summary" name="summary" value="${community.summary}" placeholder="입력해주세요.">
				<form:errors cssClass="errMessage" path="summary"/>
			</td>
		</tr>
		<tr id="starDisplay" style="display: none;">
			<td class="active"><label for="star_1"><span class="redFont"> * </span> 별등급</label></td>
			<td>
				<c:forEach var="i" begin="1" end="5" varStatus="status">
				<label for="star_${i}">
					<input type="radio" class="" id="star_${i}" name="starranking" value="${i}" <c:if test="${community.starranking eq i }">checked="checked"</c:if>>
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
					  <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
					</svg>
					${status.count}
				</label>
				</c:forEach>
				<form:errors cssClass="errMessage" path="starranking"/>
			</td>
		</tr>
		<tr>
			<td class="active"><label for="imgFile"><span class="redFont"> * </span> 대표 타이틀 이미지 </label> </td>
			<td>
				<div class="rounded">
					<img src="${fileImg}/${basicImgUrl} " style="height:10%; width: 30%;">
				</div>
				<input type="file" id="imgFile" name="updateFile" value="" accept=".jpg, .jpeg, .png, .gif">
				<input type="hidden" name="imgurl" value="${community.imgurl}">
				<input type="hidden" name="basicImgUrl" id="basicImgUrl" value="${basicImgUrl}">
			</td>
		</tr>
		
		<tr>
			<td class="active"><label for="multipleImgFile"><span class="redFont"> * </span> 후기 이미지(여러장 올리기) </label> </td>
			<td>
				<c:if test="${!empty lists}">
				<div class="rounded">
					<div class="container rounded" style="width: 200px;"> 
	
				        <div id="carousel-example-generic" class="carousel slide">
				        
				            <!-- Indicators(이미지 하단의 동그란것->class="carousel-indicators") -->
				            <ol class="carousel-indicators">
				              <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
				              <li data-target="#carousel-example-generic" data-slide-to="1"></li>
				              <li data-target="#carousel-example-generic" data-slide-to="2"></li>
				            </ol>
				            
				             <!-- Carousel items -->
				             <div class="carousel-inner">
				                <c:forEach items="${lists}" var="list" varStatus="status">
				                	<div class="item <c:if test="${status.first}"> active </c:if> ">
				                		<img src="${fileImg}/${list.imgname}" style="height: 100px;  display: block; margin: 0px auto;" alt="${list.imgname} 이미지" title="${list.imgname} 이미지" >
					                </div>
				                </c:forEach>
				             </div>
				            <!-- Controls -->
				              <a class="left carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="prev">
				                <span class="icon-prev"></span>
				              </a>
				              <a class="right carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="next">
				                <span class="icon-next"></span>
				              </a>
				          </div>
				  	</div>
			  	</div>
				</c:if>
				<input type="file" multiple id="multipleImgFile" name="multipleUpdateFile" value="" accept=".jpg, .jpeg, .png, .gif">
			</td>
		</tr>
		<tr>
			<td colspan="2" style="border-bottom: none; text-align: left;"><span class="redFont"> * </span> 내용</td>
		</tr>
		<tr>
			<td colspan="2" style="border-top: none;">
				<textarea rows="5" cols="3"  class="form-control summernote" name="contents">${community.contents}</textarea>
				<form:errors cssClass="errMessage" path="contents"/>
			</td>
		</tr>
		<tr>
			<td class="active"><label for="regKeyword">등록 키워드</label></td>
			<td>
				<input type="text" class="form-control" name="regkeyword" id="regkeyword" value="${community.regkeyword}" placeholder="#키워드,#입력해주세요.">
				<form:errors cssClass="errMessage" path="regkeyword"/>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
				<input type="button" class="btn btn-default" value="돌아가기" onclick="goDetail()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="submit" class="btn btn-primary" value="수정하기" onclick="return inputSave()">
			</td>
		</tr>
	</table>
	</form:form>
</div>  
</article>
</section>
<%@ include file="../../../common/bottom.jsp" %>   