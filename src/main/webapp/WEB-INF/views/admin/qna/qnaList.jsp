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
	navActive('qna');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 문의와 답변 리스트");
	$("#metaDescription").attr("content", "관리자 문의와 답변 리스트");
	
});

//등록페이지이동 버튼
function goRegister() {
	location.href= "${contextPath}/qnaRegister.ad";
}
</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 문의 리스트 </h2></header>
	
	<div class="form-horizontal rounded">
		<form action="qnaList.ad">
			<div>
				<dl>
					<dt><label for="searchWhatColumn">검색</label></dt>
					<dd>
						<select name="whatColumn" id="searchWhatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="title">제목</option>
							<option value="regkeyword">등록키워드</option>
							<option value="id">등록자아이디</option>
						</select>
						
						<div align="left" style="padding-top: 5px;">
							<input type="text" class="form-control" name="keyword" placeholder="검색">
						</div>
						<div align="right" style="padding-top: 5px;">
							<input type="submit" class="btn btn-default" value="검색">
						</div>
					</dd>
				</dl>
			</div>
		</form>
	</div>
	
	<table class="table table-bordered" style="margin-top: 5%;">
		<caption>레코드 총 갯수 : ${totalCount} </caption>
		<thead>
			<tr class="active">
				<th width="6%">번호</th>
				<th>제목</th>
				<th width="15%">비밀글 여부</th>
				<th width="14%">등록키워드</th>
				<th width="10%">답변상태</th>
				<th width="10%">등록자</th>
				<th width="10%">등록일</th>
			</tr>
		</thead>
		
		<tbody>
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="7" align="center"> 해당 문의 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<c:forEach var="list" items="${lists}">
			<tr>
				<td>${list.rownum }</td>
				<td style="text-align: left;">
					<c:choose>
						<c:when test="${list.relevel gt 0}">
							<img src="${images}/level.gif" width="${20*list.relevel}" height="15px;" alt="level.gif" title="level이미지"/>
							<img src="${images}/re.gif" width="20"  alt="re.gif" title="답글이미지"/>
						</c:when>
						<c:otherwise>
							<img src="${images}/level.gif" height="15px;" alt="level.gif" title="level이미지"/>
						</c:otherwise>
					</c:choose>
					
					<a href="qnaDetail.ad?num=${list.num}&pageNumber=${pageInfo.pageNumber}">
						${list.title}
					</a>
				</td> 
				<td>
					<c:if test="${!empty list.pw}">
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-lock" viewBox="0 0 16 16">
						  <path d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2zM5 8h6a1 1 0 0 1 1 1v5a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V9a1 1 0 0 1 1-1z"/>
						</svg>
						비밀글
					</c:if>
				</td>
				<td>${list.regkeyword}</td>
				<td>
					<c:choose>
						<c:when test="${list.status eq '01'}">답변 대기</c:when>
						<c:when test="${list.status eq '02'}">보류</c:when>
						<c:when test="${list.status eq '03'}">답변 완료</c:when>
						<c:otherwise>문의 전화 요망</c:otherwise>
					</c:choose>
				</td>
				<td>${list.id}</td> 
				<td>
					<fmt:parseDate var="dateFmt" value="${list.regdate}" pattern="yyyy-MM-dd"/>
					<fmt:formatDate var="registerDate" value="${dateFmt}" pattern="yyyy-MM-dd"/>
					${registerDate}
				</td> 
			</tr>
			</c:forEach>
		</tbody>
		
	</table>
	
	<!-- 페이징 -->
	<div class="paginationCenter" align="center">
		${pageInfo.pagingHtml}
	</div>
	
</div>   
</article>
</section>

<%@ include file="../../../common/admin/bottom.jsp" %>