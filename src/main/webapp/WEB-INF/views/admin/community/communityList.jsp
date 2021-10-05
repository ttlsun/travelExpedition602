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
	navActive('community');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 후기테이블");
	$("#metaDescription").attr("content", "관리자 후기테이블 리스트");

});

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 후기 리스트 </h2></header>
	
	<div class="form-horizontal rounded">
		<form action="communityList.ad">
			<input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}">
			<div>
				<dl>
					<dt><label for="searchWhatColumn">검색</label></dt>
					<dd>
						<select name="reviewtype" class="form-control">
							<option value="">후기 구분 검색</option>
							<option value="01">캠핑/글램핑 후기</option>
							<option value="02">관광지 후기</option>
							<option value="03">커뮤니티 후기</option>
						</select>
					</dd>
					<dd style="padding-top: 3%;">
						<select name="whatColumn" id="searchWhatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="title">제목</option>
							<option value="summary">한줄요약</option>
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
		<caption>레코드 총 갯수 : ${totalCount}</caption>
		<thead>
			<tr class="active">
				<th width="6%">번호</th>
				<th>후기글번호</th>
				<th>후기구분</th>
				<th>제목</th>
				<th>한줄요약</th>
				<th>노출여부</th>
				<th width="14%">등록일</th>
			</tr>
		</thead>
		
		<tbody>
			<!-- list가 없을 경우 -->
			<c:if test="${empty lists}">
			<tr>
				<td colspan="3" align="center"> 해당 후기 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="list" items="${lists}">
			<tr>
				<td>${list.rownum}</td>
				<td>${list.num}</td>
				<td>${list.reviewtype}</td> 
				<td><a href="communityDetail.ad?num=${list.num}&pageNumber=${pageInfo.pageNumber}">${list.title}</a></td> 
				<td>${list.summary}</td> 
				<td>${list.status}</td> 
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