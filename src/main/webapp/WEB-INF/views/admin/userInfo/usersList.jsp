<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- usersList.jsp -->
<%@ include file="../../../common/admin/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	//메뉴바 on 유지.
	navActive('users');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "회원목록");
	$("#metaDescription").attr("content", "회원목록");
	$("#metaKeywords").attr("content", "#여행자들602호 회원목록");
});

function placeholderChange(){
	var selectVal = $("#whatColumn option:selected").val();
	/*if(selectVal == ""){
		$("#keyword").attr("placeholder", "검색할 내용을 입력하세요");
	} else */if(selectVal == "ucode"){
		$("#keyword").attr("placeholder", "검색할 회원구분을 입력하세요(customer 또는 business)");
	} else if(selectVal == "id"){
		$("#keyword").attr("placeholder", "검색할 아이디를 입력하세요(예: customer01)");
	} else if(selectVal == "name"){
		$("#keyword").attr("placeholder", "검색할 이름을 입력하세요(예: 일반회원1)");
	} else if(selectVal == "contact"){
		$("#keyword").attr("placeholder", "검색할 연락처를 입력하세요(예: 010-4000-4000)");
	} else if(selectVal == "status"){
		$("#keyword").attr("placeholder", "검색할 회원상태를 입력하세요(가입완료 또는 탈퇴보류 또는 탈퇴완료)");
	}
}

function search(){
	var selectVal = $("#whatColumn option:selected").val();
	if(selectVal == "ucode"){
		if($("#keyword").val() != "customer" && $("#keyword").val() != "business"){
			alert("customer 또는 business만 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	} else if(selectVal == "id"){
		if(!/^[_0-9a-z-]{1,20}/g.test($("#keyword").val())){
			alert("아이디 형식에 맞게 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	} else if(selectVal == "name"){
		if(/^[!?.,-_\/]/g.test($("#keyword").val()) || $("#keyword").val().length <1 || $("#keyword").val().length >40){
			alert("이름 형식에 맞게 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	} else if(selectVal == "contact"){
		if(!/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}/g.test($("#keyword").val())){
			alert("연락처 형식에 맞게 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	} else if(selectVal == "status"){
		if(!/^[가-힣]+/g.test($("#keyword").val())){
			alert("회원상태 형식에 맞게 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	}
}

//수정페이지이동 버튼
function goUpdate(num, pageNumber) {
	location.href="usersUpdate.ad?num="+num+"&pageNumber="+pageNumber;	
}

function goDelete(num, status) {
	alert("클릭함");
	
	if(!confirm("삭제 하시겠습니까?")){
		return;
	}
	location.href="usersDelete.ad?num="+num+"&status="+status;
}
</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">회원목록</h2></header>

	<div class="form-horizontal rounded">
		<form action="usersList.ad">
			<input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}">
			<div>
				<dl>
					<dt><label for="keyword">검색</label></dt>
					<dd>
						<select id="whatColumn" name="whatColumn" class="form-control" onChange="placeholderChange()">
							<option value="">전체 검색</option>
							<option value="ucode">회원 구분</option>
							<option value="id">아이디</option>
							<option value="name">회원명</option>
							<option value="contact">연락처</option>
							<option value="status">회원 상태</option>
						</select>	
						
						<div align="left" style="padding-top: 5px;">
							<input type="text" class="form-control" id="keyword" name="keyword" placeholder="검색할 내용을 입력하세요">
						</div>
						<div align="right" style="padding-top: 5px;">
							 <input type="submit" class="btn btn-default" value="검색" onClick="return search()">
						</div>
					</dd>
				</dl>
			</div>
		</form>
	</div>

	<table class="table table-bordered">
		<caption>레코드 총 갯수 : ${totalCount}</caption>
		<thead>
			<tr class="active">
				<th width="5%">번호</th>
				<th width="10%">구분</th>
				<th width="10%">아이디</th>
				<th>회원명</th>
				<!-- <th width="10%">이메일</th>
				<th width="5%">주소</th>
				<th width="5%">생일/개업일</th>
				<th width="10%">가입일</th>
				<th width="10%">수정일</th> -->
				<th width="15%">연락처</th>
				<th width="10%">상태</th>
				<th width="5%">수정</th>
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
			<!-- 구분(business, customer) -->
			<td>${lists[i].ucode}</td>
			<!-- 아이디 -->
			<td>${lists[i].id}</td>
			<!-- 회원명 -->
			<td><a href="usersDetail.ad?num=${lists[i].num}&pageNumber=${pageInfo.pageNumber}">${lists[i].name}</a></td>
			<!-- 이메일 -->
			<!--<td>${lists[i].email}</td>-->
			<!-- 주소 -->
			<!--<c:choose>
			<c:when test="${lists[i].ucode eq 'business'}">
			<td>${'('+=lists[i].postcode+=')'+=lists[i].address1+=' '+=lists[i].address2+=' '+=lists[i].address3+=' '+=lists[i].address4}</td>
			</c:when>
			<c:otherwise>
			<td></td>
			</c:otherwise>
			</c:choose>-->
			<!-- 생일/개업일 -->
			<!--<fmt:parseDate var="fmtDate" value="${lists[i].birth}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="birth" value="${fmtDate}" pattern="yyyy-MM-dd"/>
			<td>${birth}</td>
			<fmt:parseDate var="fmtDate" value="${lists[i].regdate}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="regdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
			<td>${regdate}</td>
			<fmt:parseDate var="fmtDate2" value="${lists[i].moddate}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="moddate" value="${fmtDate2}" pattern="yyyy-MM-dd"/>
			<td>${moddate}</td>-->
			<!-- 연락처 -->
			<td>${lists[i].contact}</td>
			<!-- 회원상태 -->
			<td>${lists[i].status}</td>
			<td><input type="button" class="btn btn-primary" value="수정" onclick="goUpdate(${lists[i].num}, ${pageInfo.pageNumber})"></td>
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

<%@ include file="../../../common/admin/bottom.jsp" %>