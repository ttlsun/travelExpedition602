<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- userDetail.jsp -->
<%@ include file="../../../common/admin/top.jsp" %>   

<style type="text/css">
	table{
		text-align: center;
	}
	th{
		text-align: center;
	}
</style>
<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('users');
	
	$("#metaTitle").attr("content", "관리자회원상세");
	$("#metaDescription").attr("content", "관리자회원상세");
	$("#metaKeywords").attr("content", "#여행자들602호 관리자회원상세");
});

function goBack(){
	history.go(-1);
}

function goList(pN) {
	location.href='usersList.ad?pageNumber='+pN;
}

function goUpdate(num, pN){
	location.href='usersUpdate.ad?num='+num+'&pageNumber='+pN;
}

function goDelete(){
	if($("#status").val() != "회원탈퇴"){
		alert("회원탈퇴 상태일 때만 삭제 가능합니다");
		return false;
	}
	
	if(!confirm("회원정보를 삭제하시겠습니까?")){
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
	<header><h2 align="center" class="text-primary">회원 상세 화면</h2></header>
	
	<form name="myForm" action="usersDelete.ad" method="post" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${usersBean.num}">
	<input type="hidden" name="status" id="status" value="${usersBean.status}">
	<table class="table table-bordered">
		<tr>
			<!-- num, status -->
			<th width="20%">회원번호</th>
			<td>${usersBean.num}</td>
			<th width="20%">회원상태</th>
			<td>${usersBean.status}</td>
		</tr>
		<tr>
			<!-- ucode, id -->
			<th width="20%">회원구분</th>
			<td>${usersBean.ucode}</td>
			<th width="20%">아이디</th>
			<td>${usersBean.id}</td>
		</tr>
		<tr>
			<!-- name(gender), birth -->
			<fmt:parseDate var="fmtDate" value="${usersBean.birth}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="birth" value="${fmtDate}" pattern="yyyy-MM-dd"/>
			<c:choose>
			<c:when test="${usersBean.ucode eq 'business'}">
			<th width="20%">상호명</th>
			<td>${usersBean.name}</td>
			<th width="20%">개업일</th>
			<td>${birth}</td>
			</c:when>
			<c:otherwise>
			<th width="20%">이름(성별)</th>
			<td>${usersBean.name+='('+=usersBean.gender+=')'}</td>
			<th width="20%">생일</th>
			<td>${birth}</td>
			</c:otherwise>
			</c:choose>
		</tr>
		<tr>
			<!-- (postcode) address1~4 -->
			<c:if test="${usersBean.ucode eq 'business'}">
			<th width="20%">주소(우편번호)</th>
			<td colspan="3">${usersBean.address1+=' '+=usersBean.address2+=' '+=usersBean.address3+=' '+=usersBean.address4+=' ('+=usersBean.postcode+=')'}</td>
			</c:if>
		</tr>
		<tr>
			<!-- email, contact -->
			<th width="20%">이메일</th>
			<td>${usersBean.email}</td>
			<th width="20%">연락처</th>
			<td>${usersBean.contact}</td>
		</tr>
		<tr>
			<!-- regdate, moddate(modid) -->
			<fmt:parseDate var="fmtDate" value="${usersBean.regdate}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="regdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
			<th width="20%">등록일</th>
			<td>${regdate}</td>
			<fmt:parseDate var="fmtDate" value="${usersBean.moddate}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="moddate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
			<th width="20%">수정일(수정아이디)</th>
			<c:if test="${usersBean.modid != null}">
			<td>${moddate+='('+=usersBean.modid+=')'}</td>
			</c:if>
		</tr>
	</table>
	
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-default" value="목록보기" onClick="goList(${pageNumber})">
		<input type="button" class="btn btn-primary" value="수정하기" onClick="goUpdate(${usersBean.num}, ${pageNumber})">
		<input type="submit" class="btn btn-primary" value="삭제하기" onClick="return goDelete()">
	</div>
	</form>
</div>  
</article>
</section>

<%@ include file="../../../common/admin/bottom.jsp" %>