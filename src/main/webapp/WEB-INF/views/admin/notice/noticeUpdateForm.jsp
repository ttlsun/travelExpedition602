<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/admin/top.jsp" %> 
<style type="text/css">
	.textAlignLeft{text-align: left;} 
</style>


<script type="text/javascript">

$(document).ready(function() {
	
	navActive('notice');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 공지사항 수정");
	$("#metaDescription").attr("content", "관리자 공지사항 수정");
	
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

function goList() {
	location.href= "${contextPath}/noticeList.ad?pageNumber="+${pageNumber};
}

//상세페이지로(돌아가기) 이동 버튼
function goDetail() {
	var num = $('#num').val();
	location.href= "${contextPath}/noticeDetail.ad?num=" + num + "&pageNumber=" + ${pageNumber};
}


function inputSave() {
	
	if (!confirm('수정 하시겠습니까?')){
		return false;
	}
	
}


</script>    
 
<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="goDetail()">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
	</div>

	<header><h2 align="center" class="text-primary"> 공지사항 수정 </h2></header>
	<form:form commandName="notice" name="myForm" action="noticeUpdate.ad" method="post" enctype="multipart/form-data" class="form-horizontal">
	<input type="hidden" name="modid" value="${userId}">
	<input type="hidden" name="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${notice.num}">
	
	<div class="form-group">
		<table class="table table-bordered textAlignLeft">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
			<tr>
				<td width="30%;" style="text-align: left;" class="active"><label for="title"><span class="redFont"> * </span>공지사항 제목 </label> </td>
				<td>
					<input type="text" class="form-control" name="title" id="title" class="form-control input-sm" placeholder="제목 입력." value="${notice.title}">
					<form:errors cssClass="errMessage" path="title"/>
				</td>
			</tr>
			<tr>
				<td style="text-align: left;" class="active"><label for="multipleImgFile"> 공지사항 이미지(여러장 올리기) </label> </td>
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
				<td colspan="2" style="text-align: left;" class="active">
					<label for="contents"><span class="redFont"> * </span>공지사항 내용</label>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<textarea class="form-control summernote" rows="20" cols="20"  name="contents" id="contents" class="form-control ">${notice.contents}</textarea>
				</td>
			</tr>
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			<input type="button" class="btn btn-default" value="돌아가기" onclick="goDetail()">
			<input type="reset" class="btn btn-default" value="다시작성">
			<input type="submit" class="btn btn-primary" value="수정하기" onclick="return inputSave()">
		</div>
	</form:form>
</div>
</article>
</section>


<%@ include file="../../../common/admin/bottom.jsp" %>