<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/top.jsp" %>   

<script type="text/javascript">

$(document).ready(function() {
	
	//메뉴 on 유지.
	navActive('bCamping');
	
	$("#metaTitle").attr("content", "캠핑 객실 상세");
	$("#metaDescription").attr("content", "캠핑 객실 상세");
	$("#metaKeywords").attr("content", "#캠핑리스트, #글램핑리스트, #캠핑 객실 상세");
	
});

//돌아가기
function goList(cnum,pageNumber) {
	location.href= "${contextPath}/bCampingDetail.do?cnum="+cnum+"&pageNumber="+pageNumber;
}

//객실정보수정(사업자) 버튼 클릭시
function goUpdate(num,pageNumber) {
	location.href= "${contextPath}/bRoomUpdate.do?num="+num+"&pageNumber="+pageNumber;
}

//객실목록에서제거(사업자) 버튼 클릭시
function goDelete(num,pageNumber) {
	if (!confirm('객실목록에서 제거 하시겠습니까?')){
		return;
	}
	
	location.href= "${contextPath}/bRoomDelete.do?num="+num+"&cnum=${roombean.cnum}&pageNumber="+pageNumber;
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="goList(${roombean.cnum},${pageNumber})">
		<input type="button" class="btn btn-primary" value="객실정보수정" onclick="goUpdate(${roombean.num},${pageNumber})">
		<input type="button" class="btn btn-primary" value="객실목록에서제거" onclick="goDelete(${roombean.num},${pageNumber})">
	</div>
	<div align="center">
		<h2 align="center" class="text-primary">${roombean.name }</h2>
		<h4 align="center" class="text-info">${cname }</h4>
	</div>
	
	<!-- 객실 여럿 이미지  -->
	<div class="container"> 
		<div id="carousel-example-generic" class="carousel slide">
      	<!-- Indicators(이미지 하단의 동그란것->class="carousel-indicators") -->
        	<ol class="carousel-indicators">
				<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
			
				<c:forEach var="i" begin="1" end="${fn:length(imgList)}" step="1"> 
					<li data-target="#carousel-example-generic" data-slide-to="${i}"></li>
				</c:forEach>
			</ol>
           <!-- Carousel items -->
           <div class="carousel-inner">
              <c:forEach items="${imgList}" var="list" varStatus="status">
              	<div class="item <c:if test="${status.first}"> active </c:if> ">
              	<img src="${fileImg}/${list.imgname}" style="height:400px; display: block; margin: 0px auto;" alt="${list.imgname} 이미지" title="${list.imgname} 이미지" >
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
	<!-- // 객실 여럿 이미지  -->
  	
  	<div class="marginPadding10" align="center">
  		<hr>
  		<article><h4 class="text-info text-center">이용 정보</h4></article>
  		<br>
  		<table class="table table-bordered text-center" style="width: 100%">
  			<tr>
  				<td width="25%">기준인원</td>
  				<td width="25%">${roombean.propguests }</td>
  				<td width="25%">최대인원</td>
  				<td width="25%">${roombean.maxguests }</td>
  			</tr>
  			<tr>
  				<td>주중가격</td>
  				<td>
					<fmt:formatNumber value="${roombean.weekdayprice }" pattern="###,###"/>원
				</td>
  				<td>주말가격</td>
  				<td>
					<fmt:formatNumber value="${roombean.weekendprice }" pattern="###,###"/>원
				</td>
  			</tr>
  			<tr>
  				<td>내부 시설</td>
  				<td colspan="3">${roombean.options }</td>
  			</tr>
  			<tr>
  				<td>내부 비품</td>
  				<td colspan="3">${roombean.amenity }</td>
  			</tr>
  		</table>
  	</div>
  	
  	<div align="center">
  		<hr>
  		<article><h4 class="text-info text-center">객실 소개</h4></article>
  		<div class="marginPadding10">
  			${roombean.summary }
  		</div>
  		<div class="marginPadding10">
  			${roombean.contents }
  		</div>
  	</div>
</div>

</article>
</section>

<script>
	$('.carousel').carousel();
</script>

<%@ include file="../../../common/bottom.jsp" %>