<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %> 
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('qna');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "문의 상세");
	$("#metaDescription").attr("content", "${qna.title} 상세");
	$("#metaKeywords").attr("content", "#${qna.title}");
});

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/qnaList.do?pageNumber="+${pageNumber};
}

//수정 버튼 클릭시
function goUpdate() {
	$('#myForm').attr("action","qnaUpdate.do").submit();
}

//삭제 버튼 클릭시
function goDelete() {
	$('#myForm').attr("action","qnaDelete.do").submit();
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
	
		<!-- 내가 쓴 글이면서 답변이 완료되지 않는것들만 수정,삭제가능 설정. -->
		<c:if test="${qna.id eq userId and qna.status ne '03'}">
			<input type="button" class="btn btn-primary" value="수정" onclick="goUpdate()">
			<input type="button" class="btn btn-primary" value="삭제" onclick="goDelete()">
		</c:if>
	</div>
	
	<header><h2 align="center" class="text-primary">${qna.title} </h2></header>
	
	<form name="myForm" id="myForm" action="" method="get" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${qna.num}">
	
	<table class="table table-bordered">
		<tr>
			<td width="20%" class="active">번호</td>
			<td>${qna.num}</td>
			<td class="active">등록자 아이디</td>
			<td>${qna.id}</td>
		</tr>
		<tr>
			<td class="active">제목</td>
			<td>${qna.title}</td>
			<td class="active">답변 여부</td>
			<td>
				<c:choose>
					<c:when test="${qna.status eq '01'}">답변 대기</c:when>
					<c:when test="${qna.status eq '02'}">보류</c:when>
					<c:when test="${qna.status eq '03'}">답변 완료</c:when>
					<c:otherwise>문의 전화 요망</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:if test="${!empty imgList}">
		<tr>
			<td class="active">이미지</td>
			<td colspan="3">
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
			<td colspan="4" style="border-bottom: none;"> 설명 </td>
		</tr>
		<tr>
			<td align="center" colspan="4" style="border-top: none;">
				${qna.contents}
			</td>
		</tr>
		<tr>
			<td style="border-bottom: none;" class="active"> 등록키워드 </td>
			<td colspan="3" style="border-bottom: none;">${qna.regkeyword} </td>
		</tr>
	</table>
	
	</form>
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<!-- 내가 쓴 글이면서 답변이 완료되지 않는것들만 수정,삭제가능 설정. -->
		<c:if test="${qna.id eq userId and qna.status ne '03'}">
			<input type="button" class="btn btn-primary" value="수정" onclick="goUpdate()">
			<input type="button" class="btn btn-primary" value="삭제" onclick="goDelete()">
		</c:if>
		
		<input type="button" class="btn btn-default" value="목록보기" onclick="goList()">
	</div>
	<!-- // 버튼 -->
</div>  
</article>
</section>
<script>
	$('.carousel').carousel();
</script>
<%@ include file="../../../common/bottom.jsp" %>