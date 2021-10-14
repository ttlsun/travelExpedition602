<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- payReserveForm.jsp -->
<%@ include file="../../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	//메뉴바 on 유지.
	navActive('pay');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "결제진행");
	$("#metaDescription").attr("content", "결제진행");
	$("#metaKeywords").attr("content", "#여행자들602호 결제진행");
});

//내 결제수단 목록으로 이동
function goPayList() {
	location.href="payList.do";
}

function checkOne(element){
	const checkboxes = document.getElementsByName("rowCheck");
	checkboxes.forEach((cb) => {
		cb.checked = false;
	})
	element.checked = true;
}

function goBack(){
	history.go(-1);
}

function goSecondStep(totalprice){
	if($("input[name='rowCheck']:checked").length == 0){
		alert("결제수단을 선택하세요");
		return false;
	}
	
	if(!confirm("총 "+totalprice+"원이 결제됩니다.\n예약하시겠습니까?")){
		return false;
	}
}
</script>

<form name="myform" action="payReservationSecond.do" method="post" class="form-horizontal" role="form">
<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">${map.paycode} 결제진행</h2></header>

    <div align="right" style="padding-top: 2%;">
		<input type="button" class="btn btn-primary" value="내 결제수단 관리" onclick="goPayList()">
	</div>
  
	<table class="table table-bordered">
		<caption>레코드 총 갯수 : ${totalCount}</caption>
		<thead>
			<tr class="active">
				<th width="5%">선택</th>
				<th width="5%">번호</th>
				<th width="20%">구분</th>
				<th>상세내용</th>
				<th width="10%">등록일</th>
			</tr>
		</thead>
		
		<tbody>
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="5" align="center"> 해당 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<!-- list가 있을 경우 -->
		<c:if test="${!empty lists}">
		<c:forEach var="i" begin="0" end="${fn:length(lists)-1}">
		<tr>
			<!-- 체크박스 -->
			<td>
				<input name="rowCheck" type="checkbox" value="${lists[i].num}" onClick="checkOne(this)"/>
			</td>
			<!-- 번호 -->
			<td>${i + 1}</td>
			<!-- 구분(계좌이체, 카드결제, 휴대폰결제) -->
			<td>${lists[i].paycode}</td>
			<!-- 상세내용 -->
			<c:choose>
			<c:when test="${lists[i].cvc != 0}">
			<td>${'['+=lists[i].paydetail1+='] '+=lists[i].paydetail2+=' ('+=lists[i].cvc+=')'}</td>
			</c:when>
			<c:otherwise>
			<td>${'['+=lists[i].paydetail1+='] '+=lists[i].paydetail2}</td>
			</c:otherwise>
			</c:choose>
			<fmt:parseDate var="fmtDate" value="${lists[i].regdate}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="regdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
			<td>${regdate}</td>
		</tr>
		</c:forEach>
		</c:if>
		</tbody>
	</table>
	
	<div align="right" style="padding-top: 2%;">
		<input type="button" class="btn btn-primary" value="돌아가기" onClick="goBack()">
		<input type="submit" class="btn btn-primary" value="결제하기" onclick="return goSecondStep(${map.totalprice})">
	</div>
</div>  
</article>
</section>
</form> 

<%@ include file="../../../common/bottom.jsp" %>