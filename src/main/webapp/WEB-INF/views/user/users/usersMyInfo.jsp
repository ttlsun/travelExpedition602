<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- usersMyInfo.jsp -->
<%@ include file="../../../common/top.jsp" %>   

<script type="text/javascript" >
$(document).ready(function() {
	navActive('users');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "내정보");
	$("#metaDescription").attr("content", "내정보");
	$("#metaKeywords").attr("content", "#여행자들602호 내정보");
});

function goBack(){
	history.go(-1);
}

function goUpdate(){
	location.href="usersUpdateMyInfo.do";
}

function goUpdatePw(){
	location.href="usersUpdateMyPw.do";
}

function byeBtn() {
	if(!confirm("회원 탈퇴 시, 동일한 아이디와 이메일로 가입할 수 없습니다.\n정말 회원탈퇴 하시겠습니까?")){
		return false;
	}
}
</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left;" class="btn btn-default" value="돌아가기" onClick="goBack()">
	</div>
	
	<header><h2 align="center" class="text-primary"> 회원정보 </h2></header>
	<form action="usersBye.do" method="get" id="myFrom" class="form-horizontal" role="form">
		<div class="form-group">
		<table class="table table-bordered">
			<tr>
				<td><label>회원구분</label></td>
				<td>${loginInfo.ucode}</td>
			</tr>
			<c:if test="${loginInfo.ucode eq 'customer'}">
				<tr>
					<td><label>성별</label></td>
					<td>${loginInfo.gender}</td>
				</tr>
			</c:if>
			<tr>
				<td><label>
					<c:choose>
						<c:when test="${loginInfo.ucode eq 'customer'}">
							이름
						</c:when>
						<c:otherwise>
							상호
						</c:otherwise>
					</c:choose>
				</label></td>
				<td>${loginInfo.name}</td>
			</tr>
			<tr>
				<td width="20%"><label>아이디</label></td>
				<td>${loginInfo.id}</td>
			</tr>
			<c:if test="${loginInfo.ucode eq 'business'}">
				<tr>
					<td><label>사업장 주소</label>
					<td>${"("+=loginInfo.postcode+=") "+=loginInfo.address1+=" "+=loginInfo.address2+=" "+=loginInfo.address3+=" "+=loginInfo.address4}</td>
				</tr>
			</c:if>
			<tr>
				<td><label>이메일</label></td>
				<td>${loginInfo.email}</td>
			</tr>
			<tr>
				<td><label>연락처</label></td>
				<td>${loginInfo.contact}</td>
			</tr>
			<tr>
				<td><label>
					<c:choose>
						<c:when test="${loginInfo.ucode eq 'customer'}">
							생일
						</c:when>
						<c:otherwise>
							개업일
						</c:otherwise>
					</c:choose>
				</label></td>
				<td>
					<fmt:parseDate var="dateFmt" value="${loginInfo.birth}" pattern="yyyy-MM-dd"/>
					<fmt:formatDate var="birth" value="${dateFmt}" pattern="yyyy-MM-dd"/>
					${birth}
				</td>
			</tr>
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="button" class="btn btn-primary" value="정보변경" onClick="goUpdate()">
			<input type="button" class="btn btn-primary" value="비밀번호변경" onClick="goUpdatePw()">
			<input type="submit" class="btn btn-primary" value="회원탈퇴" onclick="return byeBtn()">
		</div>
	</form>
	</div>
</article>
</section>

<%@ include file="../../../common/bottom.jsp" %>    
