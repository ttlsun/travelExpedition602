<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/admin/top.jsp" %> 
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('keyword');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 키워드 태그관리 상세");
	$("#metaDescription").attr("content", "관리자 키워드 태그관리 상세");
});

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/keywordList.ad?pageNumber="+${pageNumber};
}

//수정 버튼 클릭시
function goUpdate() {
	$('#myForm').attr("action","keywordUpdate.ad").submit();
}

//삭제 버튼 클릭시
function goDelete() {
	
	if (!confirm('삭제 하시겠습니까?')){
		return false;
	}
	
	$('#myForm').attr("method","post").attr("action","keywordDetail.ad").submit();
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
		<input type="button" class="btn btn-primary" value="수정" onclick="goUpdate()">
		<input type="button" class="btn btn-primary" value="삭제" onclick="goDelete()">
	</div>

	<header><h2 align="center" class="text-primary"> 키워드 태그관리 상세 화면</h2></header>
	
	<form name="myForm" id="myForm" action="" method="get" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${keyword.num}">
	
	<table class="table table-bordered">
		<tr>
			<td width="20%" class="active">번호</td>
			<td>${keyword.num}</td>
		</tr>
		<tr>
			<td class="active">키워드 구분코드</td>
			<td>
				<c:choose>
					<c:when test="${keyword.acode eq '1'}">캠핑&글램핑</c:when>
					<c:when test="${keyword.acode eq '2'}">관광지</c:when>
					<c:when test="${keyword.acode eq '3'}">후기</c:when>
					<c:when test="${keyword.acode eq '4'}">문의</c:when>
					<c:otherwise>그 외 코드</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<td class="active">키워드 태그 명칭</td>
			<td>${keyword.tag}</td>
		</tr>
		<tr>
			<td class="active">등록자 아이디</td>
			<td>${keyword.regid}</td>
		</tr>
		<tr>
			<td class="active">등록일</td>
			<td>
				<fmt:parseDate var="fmtDate" value="${keyword.regdate}" pattern="yyyy-MM-dd"/>
				<fmt:formatDate var="regdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
				${regdate}
			</td>
		</tr>
		<!-- 수정일시가 있을경우, 수정일과 수정아이디 보여지게 처리 -->
		<c:if test="${!empty keyword.modid}">
			<tr>
				<td class="active">수정자 아이디</td>
				<td>${keyword.modid}</td>
			</tr>
			<tr>
				<td class="active">수정일</td>
				<td> 
					<fmt:parseDate var="fmtDate" value="${keyword.moddate}" pattern="yyyy-MM-dd"/>
					<fmt:formatDate var="moddate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
					${moddate}
				</td>
			</tr>
		</c:if>
	</table>
	
	</form>
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
		<input type="button" class="btn btn-default" value="돌아가기" onclick="goList()">
		<input type="button" class="btn btn-primary" value="삭제" onclick="goDelete()">
		<input type="button" class="btn btn-primary" value="수정" onclick="goUpdate()">
	</div>
	<!-- // 버튼 -->
</div>  
</article>
</section>
<%@ include file="../../../common/admin/bottom.jsp" %>