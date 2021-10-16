<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- usersList.jsp -->
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
	
	//selectVal에 따라 keyword의 placeholder 변경
	//이거 안됨!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	$("#whatColumn").on("chnage", function(){
		var selectVal = $("#whatColumn option:selected").val();
		<!-- num, ucode, id, name, gender, email, birth,
		postcode, address, contact, regdate, moddate, modid, status -->
		if(selectVal == ""){
			$("#keyword").attr("placeholder", "검색할 내용을 입력하세요");
		} else if(selectVal == "num"){
			$("#keyword").attr("placeholder", "검색할 회원번호를 입력하세요(예: 1)");
		} else if(selectVal == "ucode"){
			$("#keyword").attr("placeholder", "검색할 회원구분을 입력하세요(customer 또는 business)");
		} else if(selectVal == "id"){
			$("#keyword").attr("placeholder", "검색할 아이디를 입력하세요(예: customer01)");
		} else if(selectVal == "name"){
			$("#keyword").attr("placeholder", "검색할 이름을 입력하세요(예: 일반회원1)");
		} else if(selectVal == "gender"){
			$("#keyword").attr("placeholder", "검색할 성별을 입력하세요(남성 또는 여성)");
		} else if(selectVal == "email"){
			$("#keyword").attr("placeholder", "검색할 이메일을 입력하세요(예: customer1@naver.com)");
		} else if(selectVal == "cbirth"){
			$("#keyword").attr("placeholder", "검색할 생일을 입력하세요(예: 2000-10-10)");
		} else if(selectVal == "bbirth"){
			$("#keyword").attr("placeholder", "검색할 개업일을 입력하세요(예: 2000-10-10)");
		} else if(selectVal == "postcode"){
			$("#keyword").attr("placeholder", "검색할 우편번호를 입력하세요(예: 04104)");
		} else if(selectVal == "address"){
			$("#keyword").attr("placeholder", "검색할 주소를 입력하세요(예: 서울)");
		} else if(selectVal == "contact"){
			$("#keyword").attr("placeholder", "검색할 연락처를 입력하세요(예: 010-4000-4000)");
		} else if(selectVal == "regdate"){
			$("#keyword").attr("placeholder", "검색할 등록일을 입력하세요(예: 2021-10-21)");
		} else if(selectVal == "moddate"){
			$("#keyword").attr("placeholder", "검색할 수정일을 입력하세요(예: 2021-10-21)");
		} else if(selectVal == "modid"){
			$("#keyword").attr("placeholder", "검색할 수정아이디를 입력하세요(예: customer01)");
		} else if(selectVal == "status"){
			$("#keyword").attr("placeholder", "검색할 회원상태를 입력하세요(가입완료 또는 탈퇴보류 또는 탈퇴완료)");
		}
	})
});

//이거 안됨!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
function search(){
	var selectVal = $("#whatColumn option:selected").val();
	if(selectVal == "num"){
		if($("#keyword").val() == "" || !/^[0-9]+/g.test($("#keyword").val())){
			alert("숫자만 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	} else if(selectVal == "ucode"){
		if($("#keyword").val() == ""){
			if($("#keyword").val() != "customer" && $("#keyword").val() != "business"){
				alert("customer 또는 business만 입력하세요");
				$("#keyword").val("");
				$("#keyword").focus();
				return false;
			}
		}
	} else if(selectVal == "id"){
		if($("#keyword").val() == "" || !/^[_0-9a-z-]{1,20}/g.test($("#keyword").val())){
			alert("아이디 형식에 맞게 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	} else if(selectVal == "name"){
		if($("#keyword").val() == "" || !/^[0-9a-zA-Zㄱ-ㅎ가-힣\\[{<(\\]}>)]{1,40}/g.test($("#keyword").val())){
			alert("이름 형식에 맞게 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	} else if(selectVal == "gender"){
		if($("#keyword").val() == ""){
			if($("#keyword").val() != "남성" && $("#keyword").val() != "남" && $("#keyword").val() != "여성" && $("#keyword").val() != "여"){
				alert("남성, 남, 여성, 여 중 하나를 입력하세요");
				$("#keyword").val("");
				$("#keyword").focus();
				return false;
			}
		}
	} else if(selectVal == "email"){
		if($("#keyword").val() == "" || !/^[_0-9a-zA-Z-]+@[0-9a-zA-Z]+(.[_0-9a-zA-Z-]+)*)/g.test($("#keyword").val())){
			alert("이메일 형식에 맞게 입력하세요");
			$("#keyword").val("");
			$("#keyword").focus();
			return false;
		}
	} else if(selectVal == "cbirth" || selectVal == "bbirth" || selectVal == "regdate" || selectVal == "moddate"){
		if($("#keyword").val() == ""){ //yyyy-MM-dd
			if(!/^[0-9]{4}-[0-9]{2}-[0-9]{2}/g.test($("#keyword").val())){
				alert("날짜 형식에 맞게 입력하세요");
				$("#keyword").val("");
				$("#keyword").focus();
				return false;
			}
		}
	}
}

//수정페이지이동 버튼
function goUpdate(num, pageNumber) {
	if(!confirm("수정하시겠습니까?")){
		return;
	}
	location.href="usersUpdate.ad?num="+num+"&pageNumber="+pageNumber;	
}

//삭제버튼
function goDelete(num) {
	if(!confirm("삭제하시겠습니까?")){
		return;
	}
	location.href="usersDelete.ad?num="+num;
}
	
</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">내 결제수단</h2></header>

	<!-- 개인회원 : 계좌이체, 카드결제, 휴대폰결제 -->	
	<div class="form-horizontal rounded">
		<form action="usersList.ad">
			<input type="hidden" name="pageNumber" value="${pageInfo.pageNumber}">
			<div>
				<dl>
					<dt><label for="keyword">검색</label></dt>
					<dd>
						<!-- num, ucode, id, name, gender, email, birth,
						postcode, address, contact, regdate, moddate, modid, status -->
						<select id="whatColumn" name="whatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="num">회원 번호</option>
							<option value="ucode">회원 구분</option>
							<option value="id">아이디</option>
							<option value="name">회원명</option>
							<option value="gender">성별(개인회원)</option>
							<option value="email">이메일</option>
							<option value="cbirth">생일(개인회원)</option>
							<option value="bbirth">개업일(사업자)</option>
							<option value="postcode">우편번호(사업자)</option>
							<option value="address">주소(사업자)</option>
							<option value="contact">연락처</option>
							<option value="regdate">가입일자</option>
							<option value="moddate">수정일자</option>
							<option value="modid">수정한 계정</option>
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
				<th width="10%">상태</th>
				<th width="10%">아이디</th>
				<th>회원명</th>
				<!-- <th width="10%">이메일</th>
				<th width="5%">주소</th>
				<th width="5%">연락처</th>
				<th width="5%">생일/개업일</th> -->
				<th width="10%">가입일</th>
				<th width="10%">수정일</th>
				<th width="5%">수정</th>
				<th width="5%">삭제</th>
			</tr>
		</thead>
		
		<tbody>
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="9" align="center"> 해당 레코드가 없습니다.</td>
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
			<td>${lists[i].ucode}</td>
			<!-- 회원상태 -->
			<td>${lists[i].status}</td>
			<!-- 아이디 -->
			<td>${lists[i].id}</td>
			<!-- 회원명 -->
			<td><a href="userDetails.ad?num=${lists[i].num}">${lists[i].name}</a></td>
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
			<!-- 연락처 -->
			<!-- <td>${lists[i].contact}</td> -->
			<!-- 생일/개업일 -->
			<!--<fmt:parseDate var="fmtDate" value="${lists[i].birth}" pattern="yyyy-MM-dd"/>
			<fmt:formatDate var="birth" value="${fmtDate}" pattern="yyyy-MM-dd"/>
			<td>${birth}</td>-->
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