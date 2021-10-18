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
	navActive('event');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 이벤트 상세");
	$("#metaDescription").attr("content", "관리자 이벤트 상세");
});

//리스트 버튼 클릭시
function goList() {
	var type = $('#type').val();
	if(type == "01"){
		location.href= "${contextPath}/eventList.ad?pageNumber="+${pageNumber};
	}else{
		location.href= "${contextPath}/endEventList.ad?pageNumber="+${pageNumber};
	}
}

//수정 버튼 클릭시
function goUpdate() {
	$('#myForm').attr("action","eventUpdate.ad").submit();
}

//삭제 버튼 클릭시
function goDelete() {
	
	if (!confirm('삭제 하시겠습니까?')){
		return false;
	}
	
	$('#myForm').attr("method","post").attr("action","eventDetail.ad").submit();
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
		<c:if test="${type eq '01' }">
			<input type="button" class="btn btn-primary" value="수정" onclick="goUpdate()">
		</c:if>
		<input type="button" class="btn btn-primary" value="삭제" onclick="goDelete()">
	</div>

	<header><h2 align="center" class="text-primary">${event.title} 상세 화면</h2></header>
	
	<form name="myForm" id="myForm" action="" method="get" class="form-horizontal">
	<input type="hidden" name="num" id="num" value="${event.num}">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="type" id="type" value="${type}">
	
	<table class="table table-bordered">
		<tr>
			<td width="20%" class="active">번호</td>
			<td>${event.num}</td>
			<td class="active">조회수</td>
			<td>${event.readcount}</td>
		</tr>
		<tr>
			<td class="active">이벤트 시작일~종료일</td>
			<td>${event.startdate} ~ ${event.enddate}</td>
			<td class="active">등록 ID</td>
			<td>${event.id}</td>
		</tr>
		<tr>
			<td class="active">이미지</td>
			<td colspan="3">
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
				</c:if>
			</td>
		</tr>
		<tr>
			<td colspan="4" style="border-bottom: none;"> 설명 </td>
		</tr>
		<tr>
			<td align="center" colspan="4" style="border-top: none;">
			${event.contents}
			</td>
		</tr>
	</table>
	
	</form>
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
		<input type="button" class="btn btn-default" value="돌아가기" onclick="goList()">
		<!-- 진행중인 이벤트 일경우에만 수정가능 설정. -->
		<c:if test="${type eq '01' }">
			<input type="button" class="btn btn-primary" value="수정" onclick="goUpdate()">
		</c:if>
		<input type="button" class="btn btn-primary" value="삭제" onclick="goDelete()">
	</div>
	<!-- // 버튼 -->
</div>  
</article>
</section>
<script>
	$('.carousel').carousel();
</script>
<%@ include file="../../../common/admin/bottom.jsp" %>