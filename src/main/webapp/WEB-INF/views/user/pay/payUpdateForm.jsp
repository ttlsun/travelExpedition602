<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- payUpdateForm.jsp -->
<%@ include file="../../../common/top.jsp"%>

<style type="text/css">
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('pay');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "결제수단정보변경");
	$("#metaDescription").attr("content", "결제수단정보변경");
	$("#metaKeywords").attr("content", "#여행자들602호 결제수단정보변경");
	
	if($("#paycode option:selected").val() == "무통장입금" || $("#paycode option:selected").val() == "계좌이체"){
		$("#onlyCard").hide();
	} else if($("#paycode option:selected").val() == "카드결제"){
		$("#onlyCard").show();
		$("label[for='paydetail1']").text("카드사명");
		$("label[for='paydetail2']").text("카드번호");
	} else if($("#paycode option:selected").val() == "휴대폰결제"){
		$("#onlyCard").hide();
		$("#notPhone").hide();
		$("label[for='paydetail1']").text("통신사명");
	}
});

function goBack(){
	history.go(-1);
}

function input(){
	if($("#paycode option:selected").val() == "무통장입금")
		//무통장입금 : 상세1과 상세2가 적혀있어야 함, 상세1은 한글/영어로 최대 30글자, 상세2는 숫자만, cvc 0 설정
		if($("#paydetail1").val() == ""){
			alert("은행명을 입력하세요");
			$("#paydetail1").focus();
			return false;
		} else if(!/^[가-힣a-zA-Z]{1,30}/g.test($("#paydetail1").val())){
			alert("은행명 형식을 확인하세요");
			$("#paydetail1").val("");
			$("#paydetail1").focus();
			return false;
		} else if($("#paydetail2").val() == ""){
			alert("계좌번호를 입력하세요");
			$("#paydetail2").focus();
			return false;
		} else if(!/^[0-9]{1,20}/g.test($("#paydetail2").val())){
			alert("계좌번호는 20자 이내 숫자로만 작성하세요");
			$("#paydetail2").val("");
			$("#paydetail2").focus();
			return false;
		} else{
			$("#cvc").val("0");
		}
	}else if($("#paycode option:selected").val() == "계좌이체"){
		//계좌이체 : 상세1과 상세2가 적혀있어야 함, 상세1은 한글/영어로 최대 30글자, 상세2는 숫자만, cvc 0 설정
			if($("#paydetail1").val() == ""){
				alert("은행명을 입력하세요");
				$("#paydetail1").focus();
				return false;
			} else if(!/^[가-힣a-zA-Z]{1,30}/g.test($("#paydetail1").val())){
				alert("은행명 형식을 확인하세요");
				$("#paydetail1").val("");
				$("#paydetail1").focus();
				return false;
			} else if($("#paydetail2").val() == ""){
				alert("계좌번호를 입력하세요");
				$("#paydetail2").focus();
				return false;
			} else if(!/^[0-9]{1,20}/g.test($("#paydetail2").val())){
				alert("계좌번호는 20자 이내 숫자로만 작성하세요");
				$("#paydetail2").val("");
				$("#paydetail2").focus();
				return false;
			} else{
				$("#cvc").val("0");
			}
	} else if($("#paycode option:selected").val() == "카드결제"){
		//카드결제 : 상세1과 상세2과 cvc가 적혀있어야 함, 상세1은 한글/영어로 최대 30글자, 상세2는 숫자만, 상세3은 숫자만
			if($("#paydetail1").val() == ""){
				alert("카드사명을 입력하세요");
				$("#paydetail1").focus();
				return false;
			} else if(!/^[가-힣a-zA-Z]{1,30}/g.test($("#paydetail1").val())){
				alert("카드사명 형식을 확인하세요");
				$("#paydetail1").val("");
				$("#paydetail1").focus();
				return false;
			} else if($("#paydetail2").val() == ""){
				alert("카드번호를 입력하세요");
				$("#paydetail2").focus();
				return false;
			} else if(!/^[0-9]{1,20}/g.test($("#paydetail2").val())){
				alert("카드번호는 20자 이내 숫자로만 작성하세요");
				$("#paydetail2").val("");
				$("#paydetail2").focus();
				return false;
			} else if($("#cvc").val() == ""){
				alert("cvc 번호를 입력하세요");
				$("#cvc").focus();
				return false;
			} else if(!/^[0-9]+/g.test($("#cvc").val())){
				alert("cvc 번호는 숫자로만 작성하세요");
				$("#cvc").val("");
				$("#cvc").focus();
				return false;
			}
	} else{
		//휴대폰결제 : 상세1이 적혀있어야 함, 상세1은 한글/영어로 최대 30글자, 상세2와 상세3 0 설정
			if($("#paydetail1").val() == ""){
				alert("통신사명을 입력하세요");
				$("#paydetail1").focus();
				return false;
			} else if(!/^[가-힣a-zA-Z]{1,30}/g.test($("#paydetail1").val())){
				alert("통신사명 형식을 확인하세요");
				$("#paydetail1").val("");
				$("#paydetail1").focus();
				return false;
			} else{
				$("#paydetail2").val("0");
				$("#cvc").val("0");
			}
	}
	
	alert($("#num").val());
	
	if(!confirm("수정하시겠습니까?")){
		return false;
	}
}
</script>

<section class="container">
	<article>
		<div>
			<input type="button" class="btn btn-default" value="돌아가기" onClick="goBack()">
			<header>
				<h2 align="center" class="text-primary">결제수단 정보변경</h2>
			</header>
			<form name="myForm" action="payUpdate.do?num=${num}&pageNumber=${pageNumber}" method="post" class="form-horizontal">
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
							<input type="reset" class="btn btn-default" value="다시작성">
							<input type="submit" class="btn btn-primary" value="수정하기" onclick="return input()"></td>
					</tr>
				</table>
			</form>
		</div>
	</article>
</section>

<%@ include file="../../../common/bottom.jsp"%>