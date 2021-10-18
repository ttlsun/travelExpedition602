<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- payRegisterForm.jsp -->
<%@ include file="../../../common/top.jsp" %>

<style type="text/css">
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('pay');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "결제수단등록");
	$("#metaDescription").attr("content", "결제수단등록");
	$("#metaKeywords").attr("content", "#여행자들602호 결제수단등록");
	
	$("#paycode").on("change", function(){
		//개인회원 : 계좌이체, 카드결제, 휴대폰결제
		//사업자 : 무통장입금
		//결제수단 상세 정보(계좌이체-은행명, 무통장입금-은행명, 카드결제-카드사명, 휴대폰결제-통신사명-id로 join예정)
		//결제수단 상세 정보(계좌이체-계좌번호, 무통장입금-계좌번호, 카드결제-카드번호)
		var selectVal = $("#paycode option:selected").val();
		
		if(selectVal == "계좌이체"){
			//은행명, 계좌번호, cvc 없음
			$("#onlyCard").hide();
			$("#notPhone").show();
			
			$("label[for='paydetail1']").text("은행명");
			$("label[for='paydetail2']").text("계좌번호");
		} else if(selectVal == "카드결제"){
			//카드사명, 카드번호, cvc 있음
			$("#onlyCard").show();
			$("#notPhone").show();
			
			$("label[for='paydetail1']").text("카드사명");
			$("label[for='paydetail2']").text("카드번호");
		} else if(selectVal == "휴대폰결제"){
			//통신사명, 상세2 없음, cvc 없음
			$("#onlyCard").hide();
			$("#notPhone").hide();
			
			$("label[for='paydetail1']").text("통신사명");
			
			$.ajax({
				url : "${contextPath}/payDubCheck.do",
				type : "post",
				data : escape(selectVal),
				dataType : "json",
				contentType: "application/json; charset=UTF-8",
				success : function(data){
					if(data.resultCode != "0"){
						alert("휴대폰결제 등록은 하나만 가능합니다");
						$("#paycode").find("[value='휴대폰결제']").wrap("<span>");
						
						$("#onlyCard").hide();
						$("#notPhone").show();
						
						$("label[for='paydetail1']").text("은행명");
						$("label[for='paydetail2']").text("계좌번호");
					}
				},
				error : function(request, status, error){
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
					alert("휴대폰결제 중복확인 에러 발생");
				}
			});
		}
	});
});

function goBack(){
	history.go(-1);
}

function input(){
	if($("#paycode option:selected").val() == "계좌이체" || $("#paycode option:selected").val() == "무통장입금"){
	//계좌이체 : 상세1과 상세2가 적혀있어야 함, 상세1은 한글/영어로 최대 30글자, 상세2는 숫자만, cvc 0 설정
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
		} else if(!/^[0-9]{10,20}$/.test($("#paydetail2").val())){
			alert("계좌번호는 10~20자리 숫자로만 작성하세요");
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
		} else if(!/^[0-9]{10,20}$/.test($("#paydetail2").val())){
			alert("카드번호는 10~20자리 숫자로만 작성하세요");
			$("#paydetail2").val("");
			$("#paydetail2").focus();
			return false;
		} else if($("#cvc").val() == ""){
			alert("cvc 번호를 입력하세요");
			$("#cvc").focus();
			return false;
		} else if(!/^[0-9]{3,4}$/.test($("#cvc").val())){
			alert("cvc 번호는 3~4자리 숫자로만 작성하세요");
			$("#cvc").val("");
			$("#cvc").focus();
			return false;
		}
	} else if($("#paycode option:selected").val() == "휴대폰결제"){
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
	
	if(!confirm("등록하시겠습니까?")){
		return false;
	}
}
</script>

<section class="container">
	<article>
		<div>
			<input type="button" class="btn btn-default" value="돌아가기" onClick="goBack()">
			<header>
				<h2 align="center" class="text-primary">결제수단등록</h2>
			</header>
			<form name="myForm" action="payRegister.do" method="post" class="form-horizontal">
				<table class="table table-bordered">
					<caption>
						<span class="redFont"> * </span> 필수 입력 사항
					</caption>
					<tr>
						<!-- (결제수단)구분
						개인회원 : 계좌이체, 카드결제, 휴대폰결제
						사업자 : 무통장입금 -->
						<td width="20%">
							<label for="paycode">
								<span class="redFont"> * </span> 구분
							</label>
						</td>
						<td>
							<select name="paycode" class="form-control" id="paycode">
							<c:choose>
								<c:when test="${loginInfo.ucode eq 'customer'}">
								<option value="계좌이체" <c:if test="${paycode eq '계좌이체'}">selected</c:if>>계좌이체</option>
								<option value="카드결제" <c:if test="${paycode eq '카드결제'}">selected</c:if>>카드결제</option>
								<option id="justOnly" value="휴대폰결제" <c:if test="${paycode eq '휴대폰결제'}">selected</c:if>>휴대폰결제</option>
								</c:when>
								<c:otherwise>
								<option value="무통장입금" <c:if test="${paycode eq '무통장입금'}">selected</c:if>>무통장입금</option>
								</c:otherwise>
							</c:choose>
							</select>
						</td>
					</tr>
					
					<tr>
						<!-- 결제수단 상세 정보(계좌이체-은행명, 무통장입금-은행명, 카드결제-카드사명, 휴대폰결제-통신사명-id로 join예정) -->
						<td width="20%">
							<span class="redFont"> * </span> 
							<label for="paydetail1">은행명</label>
						</td>
						<td>
							<input type="text" class="form-control" id="paydetail1" name="paydetail1" size="30%" maxlength="35" placeholder="한글,영어 가능" value="${paydetail1}">
						</td>
					</tr>
					<tr id="notPhone">
						<!-- 결제수단 상세 정보(계좌이체-계좌번호, 무통장입금-계좌번호, 카드결제-카드번호) -->
						<td width="20%">
							<span class="redFont"> * </span>
							<label for="paydetail2">계좌번호</label>
						</td>
						<td>
							<input type="text" class="form-control" id="paydetail2" name="paydetail2" maxlength="25" size="30%" placeholder="숫자만 가능" value="${paydetail2}">
						</td>
					</tr>
					<tr id="onlyCard" style="display:none;">
						<!-- 카드-cvc -->
						<td width="20%">
							<label for="cvc">
								<span class="redFont"> * </span> cvc 번호
							</label>
						</td>
						<td>
							<input type="text" class="form-control" id="cvc" name="cvc" maxlength="10" size="30%" placeholder="숫자만 가능" value="${cvc}">
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
							<input type="reset" class="btn btn-default" value="다시작성">
							<input type="submit" class="btn btn-primary" value="등록하기" onclick="return input()">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</article>
</section>

<%@ include file="../../../common/bottom.jsp" %>