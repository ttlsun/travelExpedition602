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
	navActive('event');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 이벤트");
	$("#metaDescription").attr("content", "관리자 이벤트 리스트");
});


//등록페이지이동 버튼
function goRegister() {
	location.href= "${contextPath}/eventRegister.ad";
}

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 종료된 이벤트 </h2></header>
	
	<div class="form-horizontal rounded">
		<form action="endEventList.ad">
			<input type="hidden"  name="pageNumber" value="${pageInfo.pageNumber}">
			<div>
				<dl>
					<dt><label for="searchWhatColumn">검색</label></dt>
					<dd>
						<select name="whatColumn" id="searchWhatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="title">제목</option>
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
	
	<table class="table table-bordered" style="margin-top: 3%;">
		<caption>레코드 총 갯수 : ${totalCount} </caption>
		<thead>
			<tr class="active">
				<th width="6%">번호</th>
				<th>제목</th>
				<th>이벤트 시작일~종료일</th>
				<th width="14%">등록일</th>
			</tr>
		</thead>
		
		<tbody>
			<!-- list가 없을 경우 -->
			<c:if test="${empty lists}">
			<tr>
				<td colspan="4" align="center"> 해당 이벤트 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="list" items="${lists}">
				<tr>
					<td>${list.rownum}</td>
					<td>
						<a href="eventDetail.ad?num=${list.num}&pageNumber=${pageInfo.pageNumber}&type=02">
							${list.title}
						</a>
					</td>
					<td>
						<fmt:parseDate var="fmtDate" value="${list.startdate}" pattern="yyyy-MM-dd"/>
						<fmt:formatDate var="startdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
						<fmt:parseDate var="fmtDate" value="${list.enddate}" pattern="yyyy-MM-dd"/>
						<fmt:formatDate var="enddate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
						${startdate} ~ ${enddate}
					</td>
					<td>
						<fmt:parseDate var="fmtDate" value="${list.regdate}" pattern="yyyy-MM-dd"/>
						<fmt:formatDate var="regdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
						${regdate}
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