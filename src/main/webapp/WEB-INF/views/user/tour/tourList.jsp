<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('camping');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관광지");
	$("#metaDescription").attr("content", "관광지리스트");
	$("#metaKeywords").attr("content", "#여행자들602호 관광지리스트,#관광지");
	
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

//등록페이지이동 버튼
function goRegister(){
	location.href="${contextPath}/tourRegister.do";
}

//수정페이지이동 버튼
function goUpdate(num) {
	location.href="${contextPath}/tourUpdate.do?num="+num+"&pageNumber=1";
}

//삭제버튼
function goDelete() {
	alert("삭제 버튼");
}

function goDetail(num) {
	
	location.href="${contextPath}/tourDetail.do?num="+num+"&pageNumber="+${pageInfo.pageNumber};
}

	
</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">관광지 리스트 화면</h2></header>
	
	<div class="form-group rounded">
		<form action="sampleCCTList" method="post">
			<input type="hidden" id="pageNumber" name="pageNumber" value="${pageInfo.pageNumber}">
			
			<div>
				<dl>
					<dt><label for="searchTheme">테마</label></dt>
					<dd>
						<select id="searchTheme" name="themecode" class="form-control45">
							<option value="">선택하세요</option>
							<option value="02">베스트</option>
							<option value="03">제주여행</option>
							<option value="04">내륙여행</option>
							<option value="05">섬여행</option>
						</select>
					</dd>
				</dl>
				<dl>
					<dt><label for="searchAddr">지역</label></dt>
					<dd>
						<select id="searchAddr" name="address1" class="form-control40" onChange="chageSelOpt()"></select><strong> (시) </strong>
						<span style="padding-left: 3.4%;"></span>
						<select id="searchAddr2" name="address2" class="form-control40" ></select><strong> (군/구) </strong>
					</dd>
				</dl>
				<dl>
					<dt><label for="searchWhatColumn">검색</label></dt>
					<dd>
						<select name="whatColumn" id="searchWhatColumn" class="form-control">
							<option value="">전체</option>
							<option value="name">관광지이름</option>
						</select>
						
						<div align="left" style="padding-top: 5px;">
							<input type="text" class="form-control50" name="keyword" placeholder="검색">
							<input type="submit" class="btn btn-default" value="검색" onclick="return search()">
						</div>
					</dd>
				</dl>
			</div>
			
		</form>
	</div>
	
    <div align="right" style="padding-top: 2%;">
		<input type="button" class="btn btn-primary" value="추가하기" onclick="goInsert()">
	</div>
  
	<table class="table table-bordered" style="padding-top: 5%;">
		<caption>
			총 ${totalCount} 개의 관광지가 검색되었습니다.
			<button onClick="goRegister()"> 관광지 등록하기</button>
		</caption>
		<thead>
			<tr class="active">
				<th width="70%" colspan="3">관광지</th>
			</tr>
		</thead>
		<tbody>
		
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="3" align="center"> 해당 관광지 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<c:if test="${empty lists}">
				<tr>
					<td colspan="3" align="center">조건에 맞는 캠핑장 목록이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:forEach var="bean" items="${lists}">
				<tr>
					<td rowspan="3" align="center" class="col-xs-3 col-sm-3 col-md-3">
						<img src="${fileImg}/${bean.imgurl}" alt="" title="" width="100%">
					</td>
					<td colspan="2"align="left">
						<h3><a href="${contextPath }/tourDetail.do?num=${bean.num}&pageNumber=${pageInfo.pageNumber}">
							[${bean.address1}&nbsp;${bean.address2}]${bean.name }</a></h3>
						<p>${bean.summary }</p>
						<p>#태그키워드 #태그 #키워드</p>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" class="text-center">
						시설정보
					</td>
				</tr>
				<tr>
					<td class="text-left">
						 조회수
					</td>
					<td class="text-right">
						추천수, 찜수, 리뷰수
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
<%@ include file="../../../common/bottom.jsp" %>