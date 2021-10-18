<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>
<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('event');
	
	$("#metaTitle").attr("content", "${event.title}");
	$("#metaDescription").attr("content", "${event.title}");
	$("#metaKeywords").attr("content", "#${event.title}");
	
});

//리스트 버튼 클릭시
function goList() {
	var type = $('#type').val();
	if(type == "01"){
		location.href= "${contextPath}/eventList.do?pageNumber="+${pageNumber};
	}else{
		location.href= "${contextPath}/endEventList.do?pageNumber="+${pageNumber};
	}
	
}
</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
	</div>

	<header><h2 align="center" class="text-primary">${event.title} 상세 화면</h2></header>
	
	<form name="myForm" id="myForm" action="" method="get" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${event.num}">
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
			<td>
				<fmt:parseDate var="fmtDate" value="${event.startdate}" pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="startdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
				<fmt:parseDate var="fmtDate" value="${event.enddate}" pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="enddate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
				${startdate} ~ ${enddate}
			</td>
			<td class="active">등록 ID</td>
			<td>${event.id}</td>
		</tr>
		<c:if test="${!empty imgList}">
		<tr>
			<td colspan="4">
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
			${event.contents}
			</td>
		</tr>
	</table>
	
	</form>
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
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