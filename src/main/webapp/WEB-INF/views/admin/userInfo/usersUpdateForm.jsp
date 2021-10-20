<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- usersUpdateForm.jsp -->
<%@ include file="../../../common/admin/top.jsp"%>

<!-- 주소 관련 js -->
<script src="${js}/mapview-1.0.0.js"></script>
<script type="text/javascript">
	var use2 = "possible";
	var isEmailCheck = true;
	var isEmailChange = false;
	
	$(document).ready(function() {
		//메뉴 on 유지.
		navActive('users');

		//메타태그 설정.
		$("#metaTitle").attr("content", "관리자회원정보변경");
		$("#metaDescription").attr("content", "관리자회원정보변경");
		$("#metaKeywords").attr("content", "#여행자들602호 관리자회원정보변경");

		if($('#ucode').val() == "customer"){
			$('#ucodeCustomer').show();
			$("label[for='birth']").text('생일');
		} else if($('#ucode').val() == "business"){
			$('#ucodeBusiness1').hide();
			$("label[for='birth']").text('개업일');
		}
	});
	
	function goBack(){
		history.go(-1);
	}
	
	function goList(pN){
		location.href="usersList.ad?pageNumber="+pN;
	}

	function input() {
		if($("#dbbirth").val() != "" && $("#birth").val() == ""){
			if($("#ucode").val() == "customer"){
				alert("생일을 입력하세요");
				return false;
			} else{
				alert("개업일을 입력하세요");
				return false;
			}
		}
		
		if($("#status").val() == "" || !/^[가-힣]{4}/g.test($("#status").val())){
			alert("회원상태를 입력하세요");
			$("#status").val("가입완료");
			$("#status").focus();
			return false;
		}
		
		if (!confirm('수정 하시겠습니까?')) {
			return false;
		}
	}
</script>

<section class="container">
	<article>
		<div>
			<div class="marginPadding10" align="right">
      			<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onClick="goBack()">
      		</div>
			<header>
				<h2 align="center" class="text-primary">회원정보변경</h2>
			</header>
			<form name="myForm" action="usersUpdate.ad" method="post" class="form-horizontal">
			<input type="hidden" id="pageNumber" name="pageNumber" value="${pageNumber}">
			<input type="hidden" id="num" name="num" value="${usersBean.num}">
			<input type="hidden" id="ucode" name="ucode" value="${usersBean.ucode}">
			<input type="hidden" id="dbbirth" name="dbbirth" value="${usersBean.birth}">
				<table class="table table-bordered">
					<caption>
						<span class="redFont"> * </span> 필수 입력 사항<br>
					</caption>
					<tr id="ucodeCustomer" style="display:none;">
						<td width="20%" style="border-bottom: none; text-align: center;">
							<label for="gender1">
								<span class="redFont"> * </span> 성별
							</label>
						</td>
						<td style="border-bottom: none; text-align: center;">
							<label for="gender1">
								<input type="radio" id="gender1" name="gender" value="남성" <c:if test="${usersBean.gender eq '남성'}">checked</c:if>> 남성
							</label>
							&nbsp;&nbsp;
							<label for="gender2">
								<input type="radio" id="gender2" name="gender" value="여성" <c:if test="${usersBean.gender eq '여성'}">checked</c:if>> 여성
							</label>
						</td>
					</tr>
					<tr>
						<td width="20%">
							<label for="birth">생일</label>
						</td>
						<td>
							<fmt:parseDate var="fmtDate" value="${usersBean.birth}" pattern="yyyy-MM-dd"/>
							<fmt:formatDate var="birth" value="${fmtDate}" pattern="yyyy-MM-dd"/>
							<input type="date" class="form-control" id="birth" name="birth" max="2021-11-01" value="${birth}">
						</td>
					</tr>
					<tr>
						<td width="20%">
							<label for="status">
								<span class="redFont"> * </span> 회원상태
							</label>
						</td>
						<td>
							<input type="text" class="form-control" id="status" name="status" value="${usersBean.status}" placeholder="가입완료 또는 회원탈퇴">
						</td>
					</tr>
					<tr>
						<td colspan="4" align="center">
							<input type="button" class="btn btn-default" value="목록보기" onClick="goList(${pageNumber})">
							<input type="reset" class="btn btn-default" value="다시작성">
							<input type="submit" class="btn btn-primary" value="수정하기" onclick="return input()">
						</td>
					</tr>
				</table>
			</form>
		</div>
	</article>
</section>

<%@ include file="../../../common/admin/bottom.jsp"%>