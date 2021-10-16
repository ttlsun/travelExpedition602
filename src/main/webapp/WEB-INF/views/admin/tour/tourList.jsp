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
	navActive('camping');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 관광지테이블");
	$("#metaDescription").attr("content", "관리자 관광지테이블 리스트");
	
	//셀렉트 박스 셋팅.
	selInit();
	
});

//첫번째 샐랙트 박스 셋팅
function selInit() {
	
	$("#searchAddr , #searchAddr2").append(new Option("선택", ""));
	
	//시도 검색 select박스
	addrAjax("시도", "", function(data) {
		$.each(data.body, function (i, item) {
		    $('#searchAddr').append($('<option>', {
		        value: item,
		        text : item
		    }));
		});
	});
}

//첫번째 선택시, 두번째 샐랙트 박스 셋팅
function chageSelOpt() {
	
	var selFirstIndex = $("#searchAddr option:selected").index();
	
	//초기화
	$("#searchAddr2").empty(); 
	$("#searchAddr2").append(new Option("선택", ""));
	
	//구군 검색 select박스
	if (selFirstIndex > 0) {
		addrAjax("구군", $("#searchAddr option:selected").val(), function(data) {
			$.each(data.body, function (i, item) {
			    $('#searchAddr2').append($('<option>', {
			        value: item,
			        text : item
			    }));
			});
		});
	}	
}

//주소 ajax(addrAjax)
function addrAjax(type, code, callback) {
	$.ajax({
		url: "getAddr",
		type: "POST",
		data: {
			addrType : type,
			addrCode : code
		},
		dataType: "json",
		success: function(data) {
			console.log(data);
			if (data.resultCode != 'OK') {
				callback(null);
				return;
			}
			
			callback(data);
		},
		error: function(msg, error) {
			console.log("처리오류");
			callback(null);
		}
	});
}

function listByStatus(){
	document.myform.submit();
}

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 관광지 리스트 </h2></header>
	
	<form name="myform" action="tourList.ad" method="post">
		<div class="form-group rounded">
		<input type="hidden" id="pageNumber" name="pageNumber" value="${pageInfo.pageNumber}">
			<div>
				<dl>
					<dt><label for="searchAddr">지역</label></dt>
					<dd>
						<select id="searchAddr" name="address1" class="form-control40" onChange="chageSelOpt()"></select><strong> (시) </strong>
						<span style="padding-left: 3.4%;"></span>
						<select id="searchAddr2" name="address2" class="form-control40" ></select><strong> (군/구) </strong>
					</dd>
				</dl>
				<dl>
					<dd>
						<input type="text" class="form-control45" name="searchName" placeholder="이름으로 검색">
						<span style="padding-left: 3.4%;"></span>
						<input type="submit" class="btn btn-primary" value="검색하기" onClick="">
						<input type="reset" class="btn btn-default" value="초기화">
					</dd>
				</dl>
			</div>
		</div>
	
		<table class="table table-bordered" style="margin-top: 3%;">
		<caption>레코드 총 갯수 : ${totalCount}</caption>
		<thead>
			<tr class="active">
				<td colspan="8" style="text-align: left">
					<select name="status" id="status" onchange="listByStatus()">
						<option value=""<c:if test="">selected</c:if>>전체</option>
						<option value="01"<c:if test="${status eq '01' }">selected</c:if>>노출</option>
						<option value="02"<c:if test="${status eq '02' }">selected</c:if>>비노출</option>
					</select>
				</td>
			</tr>
			<tr class="active">
				<th width="5%">번호</th>
				<th width="7%">관광지<br>번호</th>
				<th>지역</th>
				<th>관광지명칭</th>
				<th>관광지테마</th>
				<th>노출여부</th>
				<th>등록사업자ID</th>
				<th width="14%">등록일<br>(최근수정일)</th>
			</tr>
		</thead>
		
		<tbody>
			<!-- list가 없을 경우 -->
			<c:if test="${empty lists}">
			<tr>
				<td colspan="8" align="center"> 해당 관광지 레코드가 없습니다.</td>
			</tr>
			</c:if>
			
			<c:forEach var="tour" items="${lists}">
			<tr>
				<td>${tour.rownum}</td>
				<td>${tour.num}</td>
				<td>${tour.address1}</td> 
				<td><a href="tourDetail.ad?num=${tour.num}&pageNumber=${pageInfo.pageNumber}">${tour.name}</a></td> 
				<td>
					<c:if test="${fn:contains(tour.themecode,'01') }">베스트</c:if>
					<c:if test="${fn:contains(tour.themecode,'02') }">제주여행</c:if>
					<c:if test="${fn:contains(tour.themecode,'03') }">내륙여행</c:if>
					<c:if test="${fn:contains(tour.themecode,'04') }">섬여행</c:if>
				</td>
				<td>${tour.status}</td> 
				<td>${tour.regid}</td>
				<td>
					<fmt:parseDate var="dateFmt1" value="${tour.regdate}" pattern="yyyy-MM-dd"/>
					<fmt:formatDate var="registerDate" value="${dateFmt1}" pattern="yyyy-MM-dd"/>
					<fmt:parseDate var="dateFmt2" value="${tour.moddate}" pattern="yyyy-MM-dd"/>
					<fmt:formatDate var="modDate" value="${dateFmt2}" pattern="yyyy-MM-dd"/>
					${registerDate}<br>(${modDate})
				</td> 
			</tr>
			</c:forEach>
		</tbody>
		</table>
	</form>
	
	<!-- 페이징 -->
	<div class="paginationCenter" align="center">
		${pageInfo.pagingHtml}
	</div>
	
</div>   
</article>
</section>




<%@ include file="../../../common/admin/bottom.jsp" %>