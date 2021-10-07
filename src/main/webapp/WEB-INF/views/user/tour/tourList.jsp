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
	selThemeInit();
});

//테마 샐랙트 박스 셋팅
function selThemeInit() {
	
	$("#searchTheme").append(new Option("전체 테마", ""));
	
	$.each(selThemeArr, function (i, item) {
	    $('#searchTheme').append($('<option>', {
	        value: selThemeArr[i],
	        text : selThemeArr[i]
	    }));
	});
	
}

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
function goInsert() {
	location.href= "${contextPath}/sampleCommunityRegister";
}

//수정페이지이동 버튼
function goUpdate() {
	alert("수정 버튼");
}

//삭제버튼
function goDelete() {
	alert("삭제 버튼");
}

function goDetail() {
	alert("상세 버튼");
}

	
</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">관광지 리스트 화면</h2></header>
	
	<div class="form-group rounded">
		<form action="sampleCCTList" method="post">
			<input type="hidden"  name="pageNumber" value="${pageInfo.pageNumber}">
			
			<div>
				<dl>
					<dt><label for="searchAddr">지역</label></dt>
					<dd>
						<select id="searchAddr" name="address1" class="form-control45" onChange="chageSelOpt()"></select>
						<span style="padding-left: 3.4%;"></span>
						<select id="searchAddr2" name="address2" class="form-control50" ></select>
					</dd>
				</dl>
				<dl>
					<dt><label for="searchTheme">테마</label></dt>
					<dd><select id="searchTheme" name="themecode" class="form-control"></select></dd>
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
		<caption>레코드 총 갯수 : </caption>
		<thead>
			<tr class="active">
				<th>관광지</th>
				<th>skdald</th>
			</tr>
		</thead>
		<tbody>
		
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="3" align="center"> 해당 관광지 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<c:forEach items="${lists}" var="list">
			<tr>
				<td>${list.num }</td>
				<td>${list.name }</td>
				<td>${list.themecode }</td>
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