<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../../../common/admin/top.jsp" %>   

<style>
	th{
		text-align: center;
	}
	td{
		padding-left: 30px;
	}
</style>

<script type="text/javascript">

//객실비활성화 버튼 클릭시
function goDelete(num,pageNumber) {
	location.href= "${contextPath}/roomDelete.ad?num="+num+"&pageNumber="+pageNumber;
}

</script>

<section class="container">
<article>
<div>
		<div class="marginPadding10" align="right">
			<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="history.back()">
			<input type="button" class="btn btn-primary" value="객실 비활성화" onclick="goDelete(${roombean.num},${pageNumber})">
		</div>
		<div align="center">
			<h3 align="center" class="text-primary">${roombean.name }</h3>
			<h4 align="center" class="text-info">${cname }</h4>
		</div>
		
		<table class="table table-bordered">
		<tr>
			<td colspan="4">
				<img src="${fileImg}/${roombean.imgurl}" alt="${roombean.imgurl} 이미지" title="${roombean.imgurl} 이미지" width="60%">
			</td>
		</tr>
		<tr>
			<td colspan="4">
				<table>
					<c:forEach var="listRow" items="${imgList}" varStatus="vsRow" step="5">
					<tr>
						<c:forEach var="listCell" items="${imgList}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*5-1}">
						<td align="center" width="12%">
							<img src="${fileImg}/${listCell.imgname}" style="width:100%; margin: 0px auto;" alt="${listCell.imgname} 이미지" title="${listCell.imgname} 이미지" >
						</td>
						</c:forEach>
					</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
		<tr>
			<th width="15%">객실 번호</th>
			<td width="35%">${roombean.num }</td>
			<th width="15%">객실 명칭</th>
			<td width="35%">${roombean.name }</td>
		</tr>
		<tr>
			<th>한줄 소개글</th>
			<td>${roombean.summary }</td>
			<th>유형</th>
			<td>
				<c:if test="${roombean.roomtype eq '01' }">일반캠핑장</c:if>
				<c:if test="${roombean.roomtype eq '02' }">자동차캠핑장</c:if>
				<c:if test="${roombean.roomtype eq '03' }">글램핑</c:if>
				<c:if test="${roombean.roomtype eq '04' }">카라반</c:if>
			</td>
		</tr>
		<tr>
			<th>기준인원</th>
			<td>${roombean.propguests }</td>
			<th>최대인원</th>
			<td>${roombean.maxguests }</td>
		</tr>
		<tr>
			<th>주중가격</th>
			<td>
				<fmt:formatNumber value="${roombean.weekdayprice }" pattern="###,###"/>원
			</td>
			<th>주말가격</th>
			<td>
				<fmt:formatNumber value="${roombean.weekendprice }" pattern="###,###"/>원
			</td>
		</tr>
		<tr>
			<th>내부시설</th>
			<td colspan="3">${roombean.options }</td>
		</tr>
		<tr>
			<th>비품</th>
			<td colspan="3">${roombean.amenity }</td>
		</tr>
	</table>
	
	  	<div align="center">
	  		<hr>
	  		<article><h4 class="text-info text-center">객실 소개</h4></article>
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

<%@ include file="../../../common/admin/bottom.jsp" %>