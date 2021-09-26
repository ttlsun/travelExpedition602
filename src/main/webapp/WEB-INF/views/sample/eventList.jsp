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
	navActive('event');
});

</script>

<section>
<article>
<div class="marginPadding10">
	<header><h2 align="center" class="text-primary"> 이벤트 </h2></header>
	
	<div class="form-horizontal rounded" style="padding-right:20%">
		<form action="" >
			<div class="form-group">
				<div class="col-xs-4 col-lg-4">
				<select name="whatColumn" class="form-control">
					<option value="all">전체 검색</option>
					<option value="title">제목</option>
				</select>
				</div>
				<div class="col-sm-4  col-lg-4">
					<input type="text" class="form-control" name="keyword" placeholder="검색">
				</div>
				<span style="display: inline-block;">
					<input type="submit" class="btn btn-default" value="검색">
				</span>
			</div>
		</form>
	</div>
	
	<table class="table table-bordered" style="margin-top: 3%;">
		<caption>레코드 총 갯수 : </caption>
		<thead>
			<tr class="active">
				<th width="6%">번호</th>
				<th>제목</th>
				<th width="20%">이벤트시작일~이벤트종료일</th>
				<th width="14%">등록일</th>
			</tr>
		</thead>
		
		<tbody>
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="4" align="center"> 해당 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<!-- list가 있을 경우 -->
		<c:if test="${!empty lists}">
		<tr>
			<td>번호</td>
			<td><a href="#">제목</a></td>
			<td>2021-09-23~2021-09-30</td>
			<td>2021-09-23</td>
		</tr>
		</c:if>
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