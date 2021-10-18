<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/admin/top.jsp" %> 
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('notice');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 공지사항 상세");
	$("#metaDescription").attr("content", "관리자 공지사항 상세");
});

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/noticeList.ad?pageNumber="+${pageNumber};
}

//수정 버튼 클릭시
function goUpdate() {
	$('#myForm').attr("action","noticeUpdate.ad").submit();
}

//삭제 버튼 클릭시
function goDelete() {
	
	if (!confirm('삭제 하시겠습니까?')){
		return false;
	}
	
	$('#myForm').attr("method","post").attr("action","noticeDetail.ad").submit();
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
		<input type="button" class="btn btn-primary" value="삭제" onclick="goDelete()">
		<input type="button" class="btn btn-primary" value="수정" onclick="goUpdate()">
	</div>

	<header><h2 align="center" class="text-primary">공지사항 상세 화면</h2></header>
	
	<form name="myForm" id="myForm" action="" method="get" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${notice.num}">
	
	<table class="table table-bordered">
		<tr>
			<td width="10%" class="active">번호</td>
			<td>${notice.num}</td>
			<td class="active">등록 ID</td>
			<td>${notice.id}</td>
			<td class="active">조회수</td>
			<td>${notice.readcount}</td>
		</tr>
		<c:if test="${!empty imgList}">
		<tr>
			<td class="active">이미지</td>
			<td colspan="5">
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
				                	<img src="${fileImg}/${list.imgname}" style="display: block; margin: 0px auto;" alt="First slide" >
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
			</td>
		</tr>
		</c:if>
		<tr>
			<td colspan="6" style="border-bottom: none;"> 설명 </td>
		</tr>
		<tr>
			<td align="center" colspan="6" style="border-top: none;">
			${notice.contents}
			</td>
		</tr>
	</table>
	
	</form>
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
		<input type="button" class="btn btn-default" value="돌아가기" onclick="goList()">
		<input type="button" class="btn btn-primary" value="삭제" onclick="goDelete()">
		<input type="button" class="btn btn-primary" value="수정" onclick="goUpdate()">
	</div>
	<!-- // 버튼 -->
</div>  
</article>
</section>
<script>
	$('.carousel').carousel();
</script>
<%@ include file="../../../common/admin/bottom.jsp" %>