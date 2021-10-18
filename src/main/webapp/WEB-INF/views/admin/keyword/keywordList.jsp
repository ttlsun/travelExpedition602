<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/admin/top.jsp" %> 
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>
<script type="text/javascript">
var selAcodeArr = new Array('캠핑/글램핑','관광지','후기','문의');
$(document).ready(function() {
	navActive('keyword');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "키워드 태그관리 ");
	$("#metaDescription").attr("content", "키워드 태그관리 리스트");
	
	//키워드 구분코드 초기화 셋팅
	selInit();
});

//키워드 구분코드 초기화 셋팅
function selInit() {
	
	$("#searchAcode").append(new Option("선택", ""));
	
	$.each(selAcodeArr, function (i, item) {
	    $('#searchAcode').append($('<option>', {
	        value: i+1,
	        text : selAcodeArr[i]
	    }));
	});
	
}

//등록페이지이동 버튼
function goRegister() {
	location.href= "${contextPath}/keywordRegister.ad";
}

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 키워드 태그관리 리스트 </h2></header>
	
	<div class="form-horizontal rounded">
		<form action="keywordList.ad">
			<div>
				<dl>
					<dt><label for="searchAcode">키워드 구분코드</label></dt>
					<dd><select id="searchAcode" name="acode" class="form-control"></select></dd>
				</dl>
				<dl>
					<dt><label for="searchWhatColumn">키워드 검색</label></dt>
					<dd>
						<select name="whatColumn" id="searchWhatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="tag">태그명</option>
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
	
	<div align="right" style="padding-top: 2%;">
		<input type="button" class="btn btn-primary" value="태그 등록" onclick="goRegister()">
	</div>
	
	<table class="table table-bordered" style="margin-top: 3%;">
		<caption>레코드 총 갯수 : ${totalCount} </caption>
		<thead>
			<tr class="active">
				<th width="6%">번호</th>
				<th width="30%">구분코드</th>
				<th>키워드 태그 명칭</th>
				<th width="14%">등록일</th>
			</tr>
		</thead>
		
		<tbody>
			<!-- list가 없을 경우 -->
			<c:if test="${empty lists}">
			<tr>
				<td colspan="4" align="center"> 해당 키워드 태그 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="list" items="${lists}">
				<tr>
					<td>${list.rownum}</td>
					<td>${list.acode}</td>
					<td>
						<a href="keywordDetail.ad?num=${list.num}&pageNumber=${pageInfo.pageNumber}">${list.tag}</a>
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