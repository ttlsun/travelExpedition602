<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('notice');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "공지사항");
	$("#metaDescription").attr("content", "공지사항 리스트");
	$("#metaKeywords").attr("content", "#공지사항");
});

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 공지사항 </h2></header>
	
	<div class="form-horizontal rounded">
		<form action="sampleNoticeList">
			<input type="hidden"  name="pageNumber" value="${pageInfo.pageNumber}">
			
			<!-- 테스트데이터 : 보는용도로 사용(넣지마세요..) -->
			<input type="text" class="form-control" value="${pageInfo.params}">
			<!-- //테스트데이터 : 보는용도로 사용(넣지마세요..) -->
			
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
		<caption>레코드 총 갯수 : </caption>
		<thead>
			<tr class="active">
				<th width="6%">번호</th>
				<th>제목</th>
				<th width="14%">등록일</th>
			</tr>
		</thead>
		
		<tbody>
		<tr>
			<td>번호</td>
			<td><a href="#">제목</a></td>
			<td>2021-09-23</td>
		</tr>
		</tbody>
		
	</table>
	
	<!-- 페이징 -->
	<div class="paginationCenter" align="center">
		${pageInfo.pagingHtml}
	</div>
	
</div>   
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>