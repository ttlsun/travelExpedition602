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
	navActive('reservation');
	$('.tdTextClassAdd').css('padding-top', '10%').css('border-top','none').css('border-right','none').css('border-left','none');
	$('.tdborderClassAdd').css('border-top','none').css('border-right','none').css('border-left','none');

});

function regBtn() {	
	var answer = confirm("예약 신청 하시겠습니까?");
	if(answer){
		$('#myForm').submit();
	}
	
}
</script>   
 
<section>
<article>
<div class="marginPadding10">
	<header><h2 align="center" class="text-primary"> 예약 </h2></header>
	
	<form action="" id="myFrom" method="post" class="form-horizontal" role="form">

		<div class="marginPadding10">			
			<table class="table table-bordered">
			<caption> 내가 찜한 리스트 </caption>
				<thead>
					<tr class="tableColor">
						<th width="7%">찜한 숙소 번호</th>
						<th>숙소명</th>
						<th width="10%">적립 예정 포인트</th>
						<th width="10%">할인</th>
						<th width="10%">금액</th>
						<th width="10%">할인금액가</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</tbody>
			</table>
			</div>			
		<div class="form-group">
		<table class="table table-bordered">
			<tr>
				<td>
					<label>예약자 이름</label>
				</td>
				<td colspan="2">
				</td>
			</tr>
			<tr>
				<td>
					<label for="reservationType1">예약자 타입</label>
				</td>
				<td style="border-right: none;">
					<label for="reservationType1"><input type="radio" id="reservationType1" name="" value="1" checked="checked"> 카드</label>
					<label for="reservationType2"><input type="radio" id="reservationType2" name="" value="2"> 무통장</label>
				</td>
				<td style="border-left: none;">
					<span>카드는, 현장 결재입니다.</span>
				</td>
			</tr>
			<tr>
				<td>
					<label for="phone">예약자 핸드폰번호</label>
				</td>
				<td colspan="2">
					<input type="text" class="form-control" id="phone" name="" placeholder="입력">
				</td>
			</tr>
			<tr>
				<td>
					<label for="email">이메일 (선택)</label>
				</td>
				<td colspan="2">
					<input type="text" class="form-control" id="email" name="" value="">
				</td>
			</tr>
			<tr>
				<td>
					<label for="yocheong">예약 요청사항 (선택)</label>
				</td>
				<td colspan="2">
					<input type="text" class="form-control" id="yocheong" name="" value="">
				</td>
			</tr>
			<tr>
				<td>
					<label for="agreeY">예약 결재 동의</label>
				</td>
				<td colspan="2">
					<label for="agreeY"><input type="radio" id="agreeY" name="" value="Y"> 동의 </label>
					<label for="agreeN"><input type="radio" id="agreeN" name="" value="N"> 비동의</label>
				</td>
			</tr>
			<tr>
				<td>
					<label for="content">예약 총 금액</label>
				</td>
				<td colspan="2">
					<span id="totalPrice"> 총 결재 금액 </span>
					<span class="redFont">원 </span>
				</td>
			</tr>
		</table>
		</div>
		<div class="marPadding">
			<input type="submit" class="btn btn-primary" value="예약 신청" onclick="return regBtn()">
			<input type="reset" class="btn btn-primary" value="취소">
			<input type="button" class="btn btn-primary" value="목록">
		</div>
	</form>
	</div>
</article>
</section>

<%@ include file="../../common/bottom.jsp" %>   
