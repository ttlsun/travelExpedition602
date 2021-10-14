<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/admin/top.jsp" %> 
<script type="text/javascript">

$(document).ready(function() {
	
	navActive('qna');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 문의 답변 수정");
	$("#metaDescription").attr("content", "관리자 문의 답변 수정");
	
	//설명
	$('.summernote').summernote({
	 	height: 200,   //set editable area's height
	 	placeholder : "설명 입력해주세요.", //placeholder
	  	codemirror: { // codemirror options
	    theme: 'monokai'
	  }
	});
	
	//저장시 사용
	var save = function() {
	  var markup = $('.click2edit').summernote('code');
	  $('.click2edit').summernote('destroy');
	};
	
});

function inputSave() {
	if (!confirm('답변 수정 하시겠습니까?')){
		return false;
	}
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/qnaList.ad?pageNumber="+${pageNumber};
}

//상세페이지로(돌아가기) 이동 버튼
function goDetail() {
	var num = $('#num').val();
	location.href= "${contextPath}/qnaDetail.ad?num=" + num + "&pageNumber=" + +${pageNumber};
}
</script>    
 
<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 답변 문의 수정 </h2></header>
	<form:form commandName="qna" name="myForm" action="qnaRefUpdate.ad" method="post" enctype="multipart/form-data" class="form-horizontal">
		<input type="hidden" name="modid" value="${userId}">
		<input type="hidden" name="pageNumber" value="${pageNumber}">
		<input type="hidden" name="num" id="num" value="${qna.num}">
		
		<div class="form-group">
		<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
			<tr>
				<td><label for="title"><span class="redFont"> * </span>문의 답변 제목 </label> </td>
				<td>
					<input type="text" maxlength="100" class="form-control" name="title" id="title" class="form-control input-sm" placeholder="제목 입력." value="${qna.title}">
					<form:errors cssClass="errMessage" path="title"/>
				</td>
			</tr>
			<tr>
				<td>
					<label for="contents"><span class="redFont"> * </span>문의 답변 내용</label>
				</td>
				<td>
					<textarea class="form-control summernote" rows="20" cols="20"  name="contents" id="contents" class="form-control ">${qna.contents}</textarea>
				</td>
			</tr>
			<tr>
				<td><label for="multipleImgFile"> 문의 답변 이미지(여러장 올리기) </label> </td>
				<td>
					<c:if test="${!empty imgList}">
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
					                <c:forEach items="${imgList}" var="list" varStatus="status">
					                	<div class="item <c:if test="${status.first}"> active </c:if> ">
					                	<img src="${fileImg}/${list.imgname}" style="height: 100px;  display: block; margin: 0px auto;" alt="First slide" >
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
					<input type="file" multiple id="multipleImgFile" name="multipleUpdateFile" value="" accept=".jpg, .jpeg, .png, .gif" >
				</td>
			</tr>
			<tr>
				<td><label for="regkeyword1"><span class="redFont"> * </span>문의 키워드 </label></td>
				<td>
					<c:forEach items="${keywordLists}" var="keywordList" varStatus="status">
						<label for="regkeyword_${status.index}" style="color: #337ab7;">
							&nbsp;
							<input type="checkbox" name="regkeyword" id="regkeyword_${status.index}" value="${keywordList.tag}" <c:if test="${fn:contains(qna.regkeyword,keywordList.tag)}">checked="checked"</c:if>> ${keywordList.tag}
						</label>
					</c:forEach>
					<form:errors cssClass="errMessage" path="regkeyword"/>
				</td>
			</tr> 
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="submit" class="btn btn-primary" value="수정하기" onclick="return inputSave()">
			<input type="reset" class="btn btn-default" value="취소">
			<input type="button" class="btn btn-primary" value="목록" onclick="goList()">
			<input type="button" class="btn btn-default" value="돌아가기" onclick="goDetail()">
		</div>
	</form:form>
</div>
</article>
</section>
<%@ include file="../../../common/admin/bottom.jsp" %>