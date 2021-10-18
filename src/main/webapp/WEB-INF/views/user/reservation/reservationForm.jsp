<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
	
	.ui-dialog-titlebar-close {
    	background-image: url(https://code.jquery.com/ui/1.13.0/themes/base/images/ui-icons_777777_256x240.png);
    }
</style>

<script type="text/javascript">
$(document).ready(function() {	
	
	navActive('camping');
	$('.tdTextClassAdd').css('padding-top', '10%').css('border-top','none').css('border-right','none').css('border-left','none');
	$('.tdborderClassAdd').css('border-top','none').css('border-right','none').css('border-left','none');

	//메타태그 설정.
	$("#metaTitle").attr("content", "예약");
	$("#metaDescription").attr("content", "예약 등록");
	$("#metaKeywords").attr("content", "#여행자들602호 예약,#예약, #예약등록");
	
	// dialog 셋팅 
  	$('#payDialog').dialog({
		autoOpen:false, //자동으로 열리지 않게
		resizable: false,
		height: 500,
		width: 900,
		position: { my: "center", at: "center", of: window } ,
		modal:true ,
		resizable : false,
		close: function( event, ui ) {
	        $('html, body').css({'overflow': 'auto', 'height': '100%'}); 
	    }
	});  
	
	//예약실패하여 결제수단이 다시 들어올경우, 표기.
	var chagePayCode = "${reservation.paycode}";
	if (chagePayCode == "휴대폰결제") {
		$('#labelPaydetail1').html("통신사명");
		$('#labelPaycode').html("휴대폰번호");
		$('#cvcTr').hide(); //cvc 안보이게 처리.
	}else if(chagePayCode == "카드결제") {
		$('#labelPaydetail1').html("카드사명");
		$('#labelPaycode').html("카드번호");
		$('#cvcTr').show(); //cvc 보이게 처리
	}else if(chagePayCode == "계좌이체" || chagePayCode == "무통장입금") {
		$('#labelPaydetail1').html("은행명");
		$('#labelPaycode').html("계좌번호");
		$('#cvcTr').hide(); //cvc 보이게 처리
	}else{
		//현장결제시 결재수단 못적게 하기.
		$('.trPayCheck , #cvcTr').hide();
	}
	
  	//등록 결제수단 검색 클릭시,
  	$('#payCheck').click(function() {
		$("#payDialog").dialog("open");
		getPay();
	});
  	
  	//결제수단 체크시,
  	$('input[name="paycode"]').on('click', function(event) {
  		var selectVal=  $(this).val();
  		//alert(selectVal);
  		$('#paycodeVal').val(selectVal);
  		
  		$('#cvc, #paydetail1 ,#paydetail2 , #paycode').val(""); //값 초기화
  		$('.trPayCheck').show();
  		
  		if ($(this).val() == "휴대폰결제") {
  			$('#labelPaydetail1').html("통신사명");
  			$('#labelPaycode').html("휴대폰번호");
  			$('#cvcTr').hide(); //cvc 안보이게 처리.
  		}else if($(this).val() == "카드결제") {
  			$('#labelPaydetail1').html("카드사명");
  			$('#labelPaycode').html("카드번호");
  			$('#cvcTr').show(); //cvc 보이게 처리
  		}else if($(this).val() == "계좌이체" || $(this).val() == "무통장입금") {
  			$('#labelPaydetail1').html("은행명");
  			$('#labelPaycode').html("계좌번호");
  			$('#cvcTr').hide(); //cvc 보이게 처리
  		}else{
  			//현장결제시 결재수단 못적게 하기.
  			$('.trPayCheck , #cvcTr').hide();
  		}
  	});
  	
});


function getPay() {
	var campingId = "${roombean.regid}"
	var regId = "${userId}";
	var paycodeVal = $('#paycodeVal').val();
	$.ajax({
		url: "jsonPayList.do",
		type: "POST",
		data: {
			campingId : campingId,
			id : regId,
			paycode : paycodeVal
		},
		dataType: "json",
		success: function(data) {
			//console.log(data);
			
			//리스트 초기화
			$('#paylist').empty();
			
			if (data.resultCode == "OK") {
				var addList = "";
				if(data.lists.length == 0){
					addList += "<tr>";
					addList += "<td colspan='4' align='center'> 해당 리스트가 없습니다.";
					addList += "</td>";
					addList += "</tr>";
				}else{
					for(var i = 0; i < data.lists.length; i++){
						addList += "<tr style='cursor:pointer;' onclick=\"payListclick('"+data.lists[i].paydetail1+"','"+ data.lists[i].paydetail2+"','"+data.lists[i].cvc+"')\">";
						addList += "<td align='center'> " + data.lists[i].paycode + " </td>";
						addList += "<td align='center'> " + data.lists[i].paydetail1 + " </td>";
						addList += "<td align='center'> " + data.lists[i].paydetail2 + " </td>";
						addList += "<td align='center' class='payDialogTd3' style='display: none;'> " + data.lists[i].cvc + " </td>";
						addList += "</tr>";
					}
				}
			}
			
			$('#paylist').append(addList);
			
			//결제마다 다르게 보여주기.
			//alert($('#paycodeVal').val());
			if ($('#paycodeVal').val() == "카드결제") {
				$('#payDialog1').html("카드명");
				$('#payDialog2').html("카드번호");
				$('#payDialog3, .payDialogTd3').show();
			}else if ($('#paycodeVal').val() == "휴대폰결제") {
	  			$('#payDialog1').html("통신사명");
				$('#payDialog2').html("휴대폰번호");
				$('#payDialog3, .payDialogTd3').hide();
	  		}else{
	  			$('#payDialog1').html("은행명");
				$('#payDialog2').html("계좌번호");
				$('#payDialog3, .payDialogTd3').hide();
	  		}
			
		},
		error: function(msg, error) {
			console.log("처리오류");
		}
	});
	
}
	
//내가 선택한 결재 수단
function payListclick(paydetail1,paydetail2,cvc) {
	console.log(paydetail1+","+paydetail2+","+cvc);
	$('#paydetail1').val(paydetail1);
	$('#paydetail2').val(paydetail2);
	$('#cvc').val(cvc);

	$("#payDialog").dialog("close");
}
	
//모든 이용약관 체크
function allAgreeChk() {

	if ($('#agreeAll').is(':checked')) {
		$('#agreeUse, #agreePrivacy, #agreeRefund,#agreeService').prop('checked', true).attr('checked', true);
	} else {
		$('#agreeUse, #agreePrivacy, #agreeRefund,#agreeService').prop('checked', false).attr('checked', false);
	}
}

//등록 버튼클릭시,
function goPayment() {	
	var answer = confirm("예약 하시겠습니까?");
	if(answer){
		
		//모든 체크박스가 체크될시 예약 되게 처리함.
		if (!$('#agreeUse').is(':checked') || !$('#agreePrivacy').is(':checked')
			|| !$('#agreeRefund').is(':checked') || !$('#agreeService').is(':checked')) {
				alert("이용약관에 동의해주세요.");
				return false;
		}
	}else{
		return false;
	}
}

function goList() {
	location.href= "${contextPath}/campingList.do";
}
</script>   
 
<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="history.back()">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
	</div>
	
	<header><h2 align="center" class="text-primary"> 객실 예약 </h2></header>
	<br>
	<div align="center">
		<h4 align="center">예약 객실 정보</h4>
		<br>
		<table class="table table-bordered" style="width: 75%">
			<tr>
				<th class="active">캠핑장명</th>
				<td colspan="3">${map.cname }</td>
			</tr>
			<tr>
				<th class="active">객실명</th>
				<td colspan="3">
					<c:choose>
						<c:when test="${roombean.roomtype eq 01 }">[일반캠핑장]</c:when>
						<c:when test="${roombean.roomtype eq 02 }">[자동차캠핑장]</c:when>
						<c:when test="${roombean.roomtype eq 03 }">[글램핑]</c:when>
						<c:when test="${roombean.roomtype eq 04 }">[카라반]</c:when>
					</c:choose>
					&nbsp; ${roombean.name}
				</td>
			</tr>
			<tr>
				<th width="15%" class="active">숙박일정</th>
				<td width="30%">${map.checkindate }~${map.checkoutdate }&nbsp;[총 ${calDateDays}박]</td>
				<th width="15%" class="active">이용인원</th>
				<td width="30%">${map.guests }</td>
			</tr>
			<tr>
				<th class="active">주중이용요금</th>
				<td>[${weekdayCount}박]&nbsp;
					<fmt:formatNumber value="${roombean.weekdayprice * weekdayCount}" pattern="###,###"/>&nbsp;원
				</td>
				<th class="active">주말이용요금</th>
				<td>[${weekendCount}박]&nbsp;
					<fmt:formatNumber value="${roombean.weekendprice * weekendCount}" pattern="###,###"/>&nbsp;원
				</td>
			</tr>
		</table>
	</div>
	
	<form:form commandName="reservation" name="myForm" action="${contextPath}/reservation.do" method="post" class="form-horizontal" role="form">
		<input type="hidden" name="rnum" value="${rnum}">
		<input type="hidden" name="cnum" value="${roombean.cnum }">
		<input type="hidden" name="cname" value="${map.cname}">
		<input type="hidden" name="pageNumber" value="${pageNumber }">
		<input type="hidden" name="checkindate" value="${map.checkindate }">
		<input type="hidden" name="checkoutdate" value="${map.checkoutdate }">
		<input type="hidden" name="totalprice" value="${totalprice}">
		<input type="hidden" name="guests" value="${map.guests }">
		<input type="hidden" name="userId" value="${userId}">
		<input type="hidden" name="weekdayprice" value="${roombean.weekdayprice}">
		<input type="hidden" name="weekendprice" value="${roombean.weekendprice}">
		<input type="hidden" name="weekdayCount" value="${weekdayCount}">
		<input type="hidden" name="weekendCount" value="${weekendCount}">
		<input type="hidden" name="calDateDays" value="${calDateDays}">
		
		<input type="hidden" name="paycodeVal" id="paycodeVal" value="">
		
		<!-- 예약 회원,결제 정보 리스트 -->	
		<div class="form-group" align="center">
		<h4 align="center">예약자 정보 입력</h4>
		<table class="table table-bordered" style="width: 75%">
			<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
			<tr>
				<td class="active"><label>회원 ID</label></td>
				<td style="text-align:left; padding-left: 20px">${userId}</td>
			</tr>
			<tr>
				<td class="active"><label><span class="redFont"> * </span>예약자 성명</label></td>
				<td>
					<input type="text" class="form-control" id="name" name="name" value="${reservation.name }">
					<form:errors cssClass="errMessage" path="name"/>
				</td>
			</tr>
			
			<tr>
				<td class="active"><label for="phone"><span class="redFont"> * </span>예약자 연락처</label></td>
				<td>
					<input type="text" class="form-control" id="phone" name="phone" value="${reservation.phone }" placeholder="ex) 010-1234-5678 형태로 입력해주세요.">
					<form:errors cssClass="errMessage" path="phone"/>
				</td>
			</tr>
			<tr>
				<td class="active"><label for="email">예약자 이메일</label></td>
				<td>
					<input type="text" class="form-control" id="email" name="email" value="${reservation.email }" placeholder="ex) abc123@gmail.com 형태로 입력해주세요.">
				</td>
			</tr>
			<tr>
				<td class="active"><label for="requested">예약 요청사항</label></td>
				<td>
					<textarea rows="5" cols="30" class="form-control" id="requested" name="requested" placeholder="예약 시 요청사항을 작성해주세요.">${reservation.requested }</textarea>
				</td>
			</tr>
			<tr>
				<td class="active"><label for="totalprice">결제 금액</label></td>
				<td>
					<span style="color: red;">
						<fmt:formatNumber value="${totalprice}" pattern="###,###"/>원
					</span>
				</td>
			</tr>
			<tr>
				<td class="active">
					<label for="paycode"><span class="redFont"> * </span>결제 수단</label>
				</td>
				<td style="border-right: none;">
					<label for="paycode1"><input type="radio" id="paycode1" name="paycode" value="계좌이체" <c:if test="${reservation.paycode eq '계좌이체'}">checked="checked"</c:if>> 계좌이체</label>
					<label for="paycode2"><input type="radio" id="paycode2" name="paycode" value="무통장입금" <c:if test="${reservation.paycode eq '무통장입금'}">checked="checked"</c:if>> 무통장입금</label>
					<label for="paycode3"><input type="radio" id="paycode3" name="paycode" value="카드결제" <c:if test="${reservation.paycode eq '카드결제'}">checked="checked"</c:if>> 카드결제</label>
					<label for="paycode4"><input type="radio" id="paycode4" name="paycode" value="휴대폰결제" <c:if test="${reservation.paycode eq '휴대폰결제'}">checked="checked"</c:if>> 휴대폰결제</label>
					<label for="paycode5"><input type="radio" id="paycode5" name="paycode" value="현장결제" <c:if test="${reservation.paycode eq '현장결제'}">checked="checked"</c:if>> 현장결제</label>
					<form:errors cssClass="errMessage" path="paycode"/>
				</td>
			</tr>
			<tr class="trPayCheck">
				<td class="active"><label for="payCheck">결제수단검색</label></td>
				<td>
					<input type="button" class="btn btn-default" value="등록결제수단검색" id="payCheck">
				</td>
			</tr>
			<tr class="trPayCheck">
				<td class="active">
					<label for="paydetail1" id="labelPaydetail1">은행명</label>
				</td>
				<td style="border-right: none;">
					<input type="text" class="form-control" name="paydetail1" id="paydetail1" value="${reservation.paydetail1}">
				</td>
			</tr>
			<tr class="trPayCheck">
				<td class="active">
					<label for="paydetail2" id="labelPaycode">계좌번호</label>
				</td>
				<td style="border-right: none;">
					<input type="text" class="form-control" name="paydetail2" id="paydetail2" value="${reservation.paydetail2}">
				</td>
			</tr>
			<tr id="cvcTr" style="display: none;">
				<td class="active">
					<label for="cvc">cvc</label>
				</td>
				<td style="border-right: none;">
					<input type="text" class="form-control" name="cvc" id="cvc" maxlength="4" value="${reservation.cvc}">
				</td>
			</tr>
		</table>
		</div>
		
		<!-- 약관 -->
		<div style="width: 80%; margin: auto;">
			<div>
				<label class="text-primary" ><span><input type="checkbox" id="agreeAll" name="agreeAll" value="" onclick="allAgreeChk()"><span class="redFont"> * </span> 전체 이용 약관에 동의합니다.<span class="redFont"> (필수) </span></span> </label>
			</div>
			<div class="panel-group" id="accordion">
		        <div class="panel panel-default">
		          <div class="panel-heading">
		            <h4 class="panel-title">
		            	<label class="agreeRefund"><input type="checkbox" id="agreeRefund" name="agreeRefund" value="">
			            	<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
			                	 취소 및 환불 수수료에 동의합니다.
			              	</a>
		              	</label>
		            </h4>
		          </div>
		          <div id="collapseOne" class="panel-collapse collapse">
		            <div class="panel-body">
		            	<ul style="list-style: none;">
							<li>예약취소는 문의나 캠핑/글램핑 관련 연락처를 통해 가능합니다.</li>
							<li>취소수수료는 예약시점과는 무관하게 '입실일로부터 남은 날짜' 기준으로 부과됩니다. 신중한 예약바랍니다.</li>
							<li>예약 이용일 변경 불가합니다. (취소수수료 확인 후) 기존 예약건 취소 및 재예약하셔야 합니다.</li>
							<li>중복예약 취소, 업체 요청에 의한 취소, 법령에 의한 취소 등은 반드시 고객센터 또는 해당 숙소를 통하여 도움을 받으십시오.</li>
							<li>미성년자는 예약이 불가하며, 보호자 동반 없이 이용 불가합니다.</li>
							<br>
							<li>※ 기상 상황 및 코로나 등 전염병 관련 예약 취소 안내</li>
							<li>우천으로 인한 환불 및 날짜 변경 불가합니다.</li>
							<li>천재지변 또는 기상악화 시, 현장(캠핑장/글램핑)상황과 정책에 따라 당일 오전 현장 판단하에 연기 또는 취소 결정됩니다.</li>
							<li>코로나 등 전염병 관련 예약 취소는 병원/행정기관 등 유관기관에서 발급한 '예약자 본인 확인 가능한 증빙 서류 제출 시' 업체와 협의 후 가능합니다.</li>
							<li>사전 협의 없이 예약자가 직접 예약 취소 시 환불 규정에 따라 환불되며, 결제업체(결제수단)의 정책에 따라 취소수수료 환불이 불가할 수 있습니다.</li>
							<li>취소 시 결제금액에서 취소수수료를 제외한 금액이 환불되며, 취소수수료는 총 결제금액 기준으로 책정됩니다.</li>
							<li>취소 신청 후 간편결제 사업자 또는 은행/신용카드사에 따라 환불 절차에 일정 시간이 소요됩니다.</li>
							<li>영업일 기준(토/일/공휴일 제외)으로 실시간 계좌이체 2~3일, 신용카드 3~5일 소요됩니다.</li>
							<li>환불 관련 자세한 문의는 고객센터로 문의하시기 바랍니다.</li>
							<li>여행자들602호(주)는 중개플랫폼사로, 현장에서 발생된 숙박업체와의 분쟁으로 인한 취소 및 환불에 관여하지 않습니다.</li>
							<li>취소수수료는 아래와 같습니다.</li>
						</ul>
		            </div>
		          </div>
		        </div>
		        <div class="panel panel-default">
		          <div class="panel-heading">
		            <h4 class="panel-title">
		              	<label class="agreeRefund"><input type="checkbox" id="agreeUse" name="agreeUse" value="">
			            	<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
			                	이용 시 주의사항에 동의합니다.
			              	</a>
	              		</label>
		            </h4>
		          </div>
		          <div id="collapseTwo" class="panel-collapse collapse">
		            <div class="panel-body">
		             	<ul style="list-style: none;">
			             	<li>[알립니다] </li>
							<li>1.주변시설 이용 시 시설물의 훼손, 분실에 대한 책임은 이용인에게 있으며 시설 파손 시 수리비용을 청구할 수 있습니다. </li>
							<li>2.무분별한 오락 및 음주, 고성방가 등으로 불쾌감을 주는 행동으로 퇴실될 수 있으니 삼가주시기 바랍니다. </li>
							<li>3.잠깐 방문하시는 분도 예외 없이 추가 인원으로 적용됩니다. 쾌적한 캠핑장 조성을 위해 협조해주시기 바랍니다.</li>
							<br>
							<li>[예약 공통 주의사항]
							<li>예약관리는 특성상 약간의 시간차에 의하여 오차가 발생할수 있습니다.</li>
							<li>오차에 의한 중복예약 발생시 먼저 예약된 예약건이 우선시 되며 이 경우, 취소수수료 없이 전액 환불처리됩니다.</li>
							<li>숙소의 요청에 따라 일부 요금은 현장에서 결제가 진행될 수 있습니다.</li>
							<li>각 숙박시설 정보는 예약을 위한 참고 자료입니다. 숙박시설 내 자체 변동이나 기타 사유로 인해 실제와 차이가 있을 수 있으며, 이에 대해 책임을 여행자들602호에서는 지지 않습니다.</li>
							<li>고객님의 요청사항은 숙박시설에 전달되나, 최종 반영 여부는 예약하신 숙박시설의 결정사항이므로 여행자들602호(주)에서 보장할 수 없는 사항임을 유의하여 주시기 바랍니다.</li>
							<li>객실요금은 기준인원에 대한 요금이며 인원 추가시 추가요금이 발생하며 숙소 사정에 따라 현장결제 할 수도 있습니다. 최대인원 이외의 인원은 입실은 불가합니다.</li>
							<li>예약시 신청하신 인원이외에 추가인원은 입실이 거부될 수 있습니다. 예약인원 초과로 인한 입실 거부시 환불 불가 정책이 적용되오니, 유의하시기 바랍니다.</li>
							<li>예약 이후 모든 변경은 해당 예약 취소후 다시 예약하셔야 합니다. 예약변경을 위한 취소시에도 취소수수료가 부과되오니 신중하게 예약하시기 바랍니다.</li>
							<li>여행자들602호(주)에서는 이용수칙과 관련하여 모든 숙소에 대하여 통일된 규정을 제공하지 않습니다.</li>
		          		</ul>
		          	</div>
		          </div>
		        </div>
		        <div class="panel panel-default">
		          <div class="panel-heading">
		            <h4 class="panel-title">
		            <label class="agreePrivacy"><input type="checkbox" id="agreePrivacy" name="agreePrivacy" value="">
		            	<a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
		              		개인 정보 제 3자 제공에 동의합니다.
		              	</a>
		            </label>
		            </h4>
		          </div>
		          <div id="collapseThree" class="panel-collapse collapse">
		            <div class="panel-body">
						<ul style="list-style: none;">
			             	<li>제공받는 자 : 여행자들602호</li>
							<li>제공 목적 : 예약 · 구매한 상품 · 서비스의 제공 및 계약의 이행(이용자 및 이용정보 확인, 정산 등), 민원처리 등 소비자 분쟁해결</li>
							<li>제공 항목 : 예약번호, 예약자 정보(예약자명, 휴대폰 번호) 또는 방문자 정보(방문자명, 휴대폰 번호)</li>
							<li>이용 및 보유기간 : 개인정보 이용목적 달성 시까지</li>
							<li>단, 관계법령에 의하여 보존할 필요성이 있는 경우 그 시점까지 보존 후 지체 없이 파기</li>
							<li>위 개인정보 제3자 제공 동의를 거부할 수 있으며, 거부할 경우 서비스 이용이 제한됩니다.</li>
						</ul>
					</div>
		          </div>
		        </div>
		        <div class="panel panel-default">
		          <div class="panel-heading">
		            <h4 class="panel-title">
		            <label class="agreeService"><input type="checkbox" id="agreeService" name="agree" value="">
		            	<a data-toggle="collapse" data-parent="#accordion" href="#collapseFour">
		              		예약자는 성인이며, 서비스 이용약관에 동의합니다.
		              	</a>
		            </label>
		            </h4>
		          </div>
		          <div id="collapseFour" class="panel-collapse collapse">
		            <div class="panel-body">
						<ul style="list-style: none;">
			             	<li>고객님께서는 전자상거래법 제8조 2항에 따른 위의 고지사항(이용 시 주의사항, 취소수수료 정책 등) 및 서비스 이용약관을 확인하고 이에 동의합니다.</li>
							<li>이용 약관은 사이트 하단의 "이용약관"에서 확인가능합니다.</li>
							<li>만 19세가 되는 해의 1월 1일을 맞지하지 않으신 고객님께서는 예약이 불가능합니다. 또한 동법 30조 8항에 의거 미성년자 혼숙은 법령으로 엄격히 금지되어있습니다.</li>
						</ul>
					</div>
		          </div>
		        </div>
			</div>
		</div>
		<!-- //약관 -->
		
		<div class="marPadding" align="center">
			<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			<input type="button" class="btn btn-default" value="돌아가기" onclick="history.back()">
			<input type="reset" class="btn btn-default" value="다시작성" >
			<input type="submit" class="btn btn-primary" value="예약하기" onclick="return goPayment()">
		</div>
	</form:form>
	</div>
</article>
</section>

<!-- 결제(pay) 관련 dialog -->
<div id="payDialog" title="내 등록 결제 수단 검색" >
	<div class="marPadding">
		<table border="1" class="table table-bordered">
		<caption>내 등록 결제 수단 선택</caption>
			<thead>
				<tr class="active">
					<th>결제수단</th>
					<th id="payDialog1">은행명</th>
					<th id="payDialog2">계좌번호</th>
					<th id="payDialog3" style="display: none;">cvc</th>
				</tr>
			</thead>
			<tbody id="paylist"></tbody>
		</table>
	</div>
</div>

<%@ include file="../../../common/bottom.jsp" %>   