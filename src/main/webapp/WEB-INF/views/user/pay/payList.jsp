<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- payList.jsp -->
<%@ include file="../../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	//메뉴바 on 유지.
	navActive('pay');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "결제수단목록");
	$("#metaDescription").attr("content", "결제수단목록, 개인회원");
	$("#metaKeywords").attr("content", "#여행자들602호 결제수단목록, 개인회원");
});

function goBack(){
	history.go(-1);
}

//등록페이지이동 버튼
function goRegister() {
	location.href="payRegister.do";
}

//수정페이지이동 버튼
function goUpdate(num, pageNumber) {
	if(!confirm("수정하시겠습니까?")){
		return;
	}
	location.href="payUpdate.do?num="+num+"&pageNumber="+pageNumber;	
}

//삭제버튼
function goDelete(num) {
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	location.href="payDelete.do?num="+num;
}
	
</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left;" class="btn btn-default" value="돌아가기" onClick="goBack()">
	</div>
	
	<header><h2 align="center" class="text-primary">내 결제수단</h2></header>

	<!-- 개인회원 : 계좌이체, 카드결제, 휴대폰결제 -->	
	<div class="form-horizontal rounded">
		<form action="payList.do">
			<div>
				<dl>
					<dt><label for="keyword">검색</label></dt>
					<dd>
						<select name="whatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="paycode">구분</option>
							<option value="paydetail">상세내용</option>
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
		<input type="button" class="btn btn-primary" value="추가하기" onclick="goRegister()">
	</div>
  
	<table class="table table-bordered">
		<caption>레코드 총 갯수 : ${totalCount}</caption>
		<thead>
			<tr class="active">
				<th width="5%">번호</th>
				<th width="20%">구분</th>
				<th>상세내용</th>
				<th width="10%">등록일</th>
				<th width="10%">수정일</th>
				<th width="5%">수정</th>
				<th width="5%">삭제</th>
			</tr>
		</thead>
		
		<tbody>
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="7" align="center"> 해당 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<!-- list가 있을 경우 -->
		<c:if test="${!empty lists}">
		<c:forEach var="i" begin="0" end="${fn:length(lists)-1}">
		<tr>
			<!-- 번호 -->
			<c:choose>
			<c:when test="${pageInfo.pageNumber == 1}">
			<td>${i + 1}</td>
			</c:when>
			<c:otherwise>
			<td>${(i + 1) + ((pageInfo.pageNumber - 1) * 5)}</td>
			</c:otherwise>
			</c:choose>
			<!-- 구분(계좌이체, 카드결제, 휴대폰결제) -->
			<td>${lists[i].paycode}</td>
			<!-- 상세내용 -->
			<c:choose>
			<c:when test="${lists[i].cvc != 0}">
			<td>${'['+=lists[i].paydetail1+='] '+=lists[i].paydetail2+=' ('+=lists[i].cvc+=')'}</td>
			</c:when>
			<c:otherwise>
			<td>${'['+=lists[i].paydetail1+='] '+=lists[i].paydetail2}</td>
			</c:otherwise>
			</c:choose>
			<fmt:parseDate var="fmtDate" value="${lists[i].regdate}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="regdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
			<td>${regdate}</td>
			<fmt:parseDate var="fmtDate2" value="${lists[i].moddate}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="moddate" value="${fmtDate2}" pattern="yyyy-MM-dd"/>
			<td>${moddate}</td>
			<td><input type="button" class="btn btn-default" value="수정" onclick="goUpdate(${lists[i].num}, ${pageInfo.pageNumber})"></td>
			<td><input type="button" class="btn btn-default" value="삭제" onclick="goDelete(${lists[i].num})"></td>
		</tr>
		</c:forEach>
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

<%@ include file="../../../common/bottom.jsp" %>