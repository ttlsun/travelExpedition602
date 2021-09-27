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
	//메뉴바 on 유지.
	navActive('event');
});

//등록페이지이동 버튼
function goInsert() {
	location.href= "${contextPath}/sampleInsert";
}

//상세이동 버튼
function goDetail() {
	location.href= "${contextPath}/sampleDetail";
}

//수정페이지이동 버튼
function goUpdate() {
	alert("수정 버튼");
}

//삭제버튼
function goDelete() {
	alert("삭제 버튼");
}
	
</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 이벤트 리스트 화면</h2></header>
	
	<div class="form-horizontal rounded">
		<form action="">
			<div class="">
				<dl>
					<dt><label for="keyword">검색</label></dt>
					<dd>
						<select name="whatColumn" class="form-control">
							<option value="all">전체 검색</option>
							<option value="">이름</option>
						</select>
						
						<div align="left" style="padding-top: 5px;">
							<input type="text" class="form-control" id="keyword" name="keyword" placeholder="검색">
						</div>
						<div align="right" style="padding-top: 5px;">
							<input type="submit" class="btn btn-default" value="검색">
						</div>
					</dd>
				</dl>
			</div>
		</form>
	</div>
	
    <div align="right" style="padding-top: 2%;">
		<input type="button" class="btn btn-primary" value="추가하기" onclick="goInsert()">
	</div>
  
	<table border="1" class="table table-bordered">
		<caption>레코드 총 갯수 : </caption>
		<thead>
			<tr class="active">
				<th width="6%">번호</th>
				<th>제목</th>
				<th width="20%">이벤트시작일~이벤트종료일</th>
				<th width="8%">수정</th>
				<th width="8%">삭제</th>
			</tr>
		</thead>
		
		<tbody>
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="5" align="center"> 해당 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<!-- list가 있을 경우 -->
		<c:if test="${!empty lists}">
		<tr>
			<td>번호</td>
			<td><a href="#">제목</a></td>
			<td>2021-09-23~2021-09-30</td>
			<td><input type="button" class="btn btn-default" value="수정" onclick="goUpdate()"></td>
			<td><input type="button" class="btn btn-default" value="삭제" onclick="goDelete()"></td>
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

<%@ include file="../../../common/admin/bottom.jsp" %>