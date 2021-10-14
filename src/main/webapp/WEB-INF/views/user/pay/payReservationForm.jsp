<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- payReservationForm.jsp -->
<%@ include file="../../../common/top.jsp"%>

<style type="text/css">
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('pay');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "예약결제");
	$("#metaDescription").attr("content", "예약결제");
	$("#metaKeywords").attr("content", "#여행자들602호 예약결제");
});

function goBack(){
	history.go(-1);
}

function input(){
	if(!confirm("예약하시겠습니까?")){
		return false;
	}
}
</script>

<section class="container">
	<article>
		<div>
			<header>
				<h2 align="center" class="text-primary">결제수단 정보변경</h2>
			</header>
			<form name="myForm" action="payReservation2.do" method="post" class="form-horizontal">
				<table class="table table-bordered">
					<caption>
						<span class="redFont"> * </span> 필수 입력 사항
					</caption>
					<tr style="display: none;">
						<td width="20%">
							<label for="paycode"> <span
								class="redFont"> * </span> 구분
							</label>
						</td>
						<td>
							<select name="paycode" class="form-control" id="paycode">
								<option value="계좌이체"	<c:if test="${pay.paycode eq '계좌이체'}">selected</c:if>>계좌이체</option>
								<option value="카드결제"	<c:if test="${pay.paycode eq '카드결제'}">selected</c:if>>카드결제</option>
								<option value="휴대폰결제" <c:if test="${pay.paycode eq '휴대폰결제'}">selected</c:if>>휴대폰결제</option>
								<option value="무통장입금" <c:if test="${pay.paycode eq '무통장입금'}">selected</c:if>>무통장입금</option>
							</select>
						</td>
					</tr>

					<tr>
						<!-- 결제수단 상세 정보(계좌이체-은행명, 무통장입금-은행명, 카드결제-카드사명, 휴대폰결제-통신사명-id로 join예정) -->
						<td width="20%">
							<label for="paydetail1"> <span class="redFont"> * </span> 은행명	</label>
						</td>
						<td>
							<input type="text" class="form-control" id="paydetail1"	name="paydetail1" size="30%" maxlength="30" placeholder="한글,영어 가능" value="${pay.paydetail1}">
						</td>
					</tr>
					<tr id="notPhone">
						<!-- 결제수단 상세 정보(계좌이체-계좌번호, 무통장입금-계좌번호, 카드결제-카드번호) -->
						<td width="20%">
							<label for="paydetail2"> <span class="redFont"> * </span> 계좌번호</label>
						</td>
						<td>
							<input type="text" class="form-control" id="paydetail2"	name="paydetail2" size="30%" placeholder="숫자만 가능" value="${pay.paydetail2}">
						</td>
					</tr>
					<tr id="onlyCard" style="display: none;">
						<!-- 카드-cvc -->
						<td width="20%">
							<label for="cvc"> <span	class="redFont"> * </span> cvc 번호</label>
						</td>
						<td>
							<input type="text" class="form-control" id="cvc" name="cvc" size="30%" placeholder="숫자만 가능" value="${pay.cvc}">
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
							<input type="button" class="btn btn-primary" value="돌아가기" onClick="goBack()">
							<input type="reset" class="btn btn-default" value="다시작성">
							<input type="submit" class="btn btn-primary" value="수정하기" onclick="return input()"></td>
					</tr>
				</table>
			</form>
		</div>
	</article>
</section>

<%@ include file="../../../common/bottom.jsp"%>