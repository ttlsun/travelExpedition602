<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('member');
	
	$("#metaTitle").attr("content", "찜 내역");
	$("#metaDescription").attr("content", "찜등록");
	$("#metaKeywords").attr("content", "#캠핑찜, #글램핑찜, #찜");
	
});

</script>

<section class="container">
<article>
<div>
	<h2 align="center" class="text-primary">내가 찜한 내역</h2>
	
	<form action="" method="post" class="form-horizontal">
	<table border="1" class="table table-bordered">
		<caption>주문자 정보 : </caption>
		<thead>
			<tr class="active">
				<th>찜한 숙소 번호</th>
				<th>숙소명</th>
				<th>단가</th>
				<th>금액</th>
			</tr>
		</thead>
		<tbody>
		<tr>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		
		<tr>
			<td colspan="3" style="border-right: none;">
				<a href="#" class="btn btn-default">결제하기</a>
				<a href="#" class="btn btn-default">추가예약</a>
			</td>
			<td colspan="2" style="text-align:right; border-left: none;">
				총 금액 : 
				<span class="redFont"> 원 </span>
			</td>
		</tr>
		</tbody>
	</table>
	</form>
</div>   
</article>
</section> 

<%@ include file="../../common/bottom.jsp" %>
