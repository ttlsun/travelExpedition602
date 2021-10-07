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
	
	$("#metaTitle").attr("content", "캠핑 리스트");
	$("#metaDescription").attr("content", "캠핑리스트");
	$("#metaKeywords").attr("content", "#캠핑리스트");
	
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

function goRegister(){
	location.href="${contextPath}/campingRegister.do";
}

function listOrderBy(){
	var orderBy = $("#orderBy").val();
	document.myform.submit();
}

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">캠핑장</h2></header>
	
	<div class="form-group rounded">
		<form name="myform" action="${contextPath}/campingList.do" method="post">
			<dl>
				<dt align="center">
					<input type="button" value="상세검색" class="form-control45">
					<span style="padding-left: 3.4%;"></span>
					<input type="button" value="태그로 검색하기 +" class="form-control45">
				</dt>
			</dl>
			<div style="display: block;">
				<dl>
					<dt><label for="searchType">유형</label></dt>
					<dd>
						<label><input type="checkbox" id="searchType" name="camp_type" value="01">&nbsp;일반캠핑장&nbsp;</label>
						<label><input type="checkbox" id="searchType" name="camp_type" value="02">&nbsp;자동차캠핑장&nbsp;</label>
						<label><input type="checkbox" id="searchType" name="camp_type" value="03">&nbsp;글램핑&nbsp;</label>
						<label><input type="checkbox" id="searchType" name="camp_type" value="04">&nbsp;카라반&nbsp;</label>
					</dd>
				</dl>
				<dl>
					<dt><label for="searchTheme">테마</label></dt>
					<dd>
						<label><input type="checkbox" id="searchTheme" name="themecode" value="01">&nbsp;숲/산&nbsp;</label>
						<label><input type="checkbox" id="searchTheme" name="themecode" value="02">&nbsp;해변/바다&nbsp;</label>
						<label><input type="checkbox" id="searchTheme" name="themecode" value="03">&nbsp;강/호수/계곡&nbsp;</label>
						<label><input type="checkbox" id="searchTheme" name="themecode" value="04">&nbsp;도심&nbsp;</label>
						<label><input type="checkbox" id="searchTheme" name="themecode" value="05">&nbsp;섬&nbsp;</label>
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
					<dd>
						<input type="text" class="form-control45" name="searchName" placeholder="이름으로 검색">
						<span style="padding-left: 3.4%;"></span>
						<input type="submit" class="btn btn-primary" value="검색하기" onClick="">
					</dd>
				</dl>
			</div>
			
			<!-- 태그로 검색 아직 해놓지 않음, 배열로 변경 예정 -->
			<div style="display: block;">
				<dl>
					<dt><label for="searchKeyword">태그로 검색</label></dt>
					<dd>
						<a href="#none" class="tagBtn" id="">#힐링</a>
						<a href="#none" class="tagBtn" id="">#연인과함께</a>
						<a href="#none" class="tagBtn" id="">#아이와함께</a>
						<a href="#none" class="tagBtn" id="">#친구들과신나게</a>
						<a href="#none" class="tagBtn" id="">#가족과함께</a>
						<a href="#none" class="tagBtn" id="">#반려견동반</a>
						<a href="#none" class="tagBtn" id="">#깨끗한</a>
						<a href="#none" class="tagBtn" id="">#사이트간격이넓은</a>
						<a href="#none" class="tagBtn" id="">#별보기좋은</a>
						<a href="#none" class="tagBtn" id="">#흙바닥</a>
						<a href="#none" class="tagBtn" id="">#파쇄석</a>
						<a href="#none" class="tagBtn" id="">#개인데크</a>
						<a href="#none" class="tagBtn" id="">#오션뷰</a>
						<a href="#none" class="tagBtn" id="">#피톤치드</a>
					</dd>
				</dl>
			</div>
			
			<div align="center">
				
			</div>
		</form>
	</div>
	
	<table class="table table-bordered" style="">
		<caption>
			총 ${totalCount }개 캠핑장이 검색되었습니다. 
			<button onClick="goRegister()">캠핑장 등록하기(사업자 전용)</button>
		</caption>
		<thead>
			<tr class="active">
				<td colspan="2" align="left">
					<select name="orderBy" id="orderBy" onchange="listOrderBy()">
						<option value="moddate desc">업데이트순</option>
						<option value="readcount desc">조회수 높은순</option>
						<option value="recommend desc">추천 많은순</option>
						<option value="steamed desc">찜 많은순</option>
						<option value="reviewcount desc">리뷰 많은순</option>
					</select>
				</td>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty lists}">
				<tr>
					<td colspan="" align="center">조건에 맞는 캠핑장 목록이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:forEach var="bean" items="${lists}">
				<tr>
					<td rowspan="2" align="center" class="col-xs-3 col-sm-3 col-md-3">
						이미지
					</td>
					<td height="30px">
					</td>
				</tr>
				<tr>
					<td height="130px" align="left">
						<h3><a href="${contextPath }/campingDetail.do?num=${bean.num}">
							[${bean.address1}&nbsp;${bean.address2}]${bean.name }</a></h3>
						<p>${bean.summary }</p>
					</td>
				</tr>
		
		</c:forEach> 
		</tbody>
	</table>
	
	<div class="paginationCenter" align="center">
		${pageInfo.pagingHtml}
	</div>
	
	<%-- 	<c:forEach var="beanCell" items="${lists}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*2-1}">
			<td align="center" class="col-xs-12 col-sm-6 col-md-3 ">
			
				<ul class="thumbnail" style="list-style: none; border: none;">
					<li><img src="${images}/1.jpg" style="height: 100px;" alt="..."></li>
					<li class="caption">
					<h3>${beanCell.name} 이런식으로 사용하세요. : 캠핑명칭</h3>
			            <p>
			            	<span class="spanFlowRootP10">
								<b class="redColor">[캠핑/글램핑(구분)/ 테마]</b>
							</span>
							<span class="spanFlowRootP10 text-primary textFontSizeLarge">
							</span>
							<span class="">
								&nbsp; <span class="label label-warning"> 추천 </span>
								&nbsp; <span class="label label-danger"> HOT </span>
								&nbsp; <span class="label label-default"> NEW </span>
							</span>
						</p>
						<p> 한줄요약 </p>
			            <p>
			            	<a href="#" class="btn btn-primary" role="button" onclick="goDetail()" style="text-decoration:none; color: white;">상세보기</a> 
			            </p>
					</li>
				</ul>
			</td>
			</c:forEach>
		</tr> --%>
	
</div>
</article>
</section>


<%@ include file="../../../common/bottom.jsp" %>