<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">

var selFirstArr = new Array('서울시','부산시','대구시','인천시','광주시','일산시','세종시','경기도','강원도','충청북도','충청남도','전라북도','경상북도','경상남도','제주도');
var selSecondArr = [['강남구','강동구','강북구','강서구','관악구'],
					['강서구','금정구','기장군','남구','동구','동래구'],
					['남구','달서구'],
					['강화군','계양구','남구'],
					['광산구','남구','동구','북구','서구'],
					['대덕구','덩구','서구','유성구','중구'],
					['남구'],
					['금남면'],
					['가평군'],
					['강릉시'],
					['계롱시'],
					['고창군'],
					['강진군'],
					['경산시'],
					['거세시'],
					['서귀포시','제주시']
				   ];

$(document).ready(function() {
	navActive('camping');
	
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
	
	$.each(selFirstArr, function (i, item) {
	    $('#searchAddr').append($('<option>', {
	        value: selFirstArr[i],
	        text : selFirstArr[i]
	    }));
	});
	
}

//첫번째 선택시, 두번째 샐랙트 박스 셋팅
function chageSelOpt() {
	
	var selFirstIndex = $("#searchAddr option:selected").index();
	
	//초기화
	$("#searchAddr2").empty(); 
	$("#searchAddr2").append(new Option("선택", ""));
	
	//셋팅
	if (selFirstIndex > 0) {
		$("#searchAddr2").empty(); //두번째 셀렉트박스 선택 나오게 할려면 주석 처리.
		$.each(selSecondArr[selFirstIndex-1], function (i, item) {
		    $('#searchAddr2').append($('<option>', {
		        value: selSecondArr[selFirstIndex-1][i],
		        text : selSecondArr[selFirstIndex-1][i]
		    }));
		});
	}	
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
		<form action="" >
			<div class="">
				<dl>
					<dt><label for="searchAddr">지역</label></dt>
					<dd>
						<select id="searchAddr" class="form-control45" onChange="chageSelOpt()"></select>
						<span style="padding-left: 3.4%;"></span>
						<select id="searchAddr2" class="form-control50" ></select>
					</dd>
				</dl>
				<dl>
					<dt><label for="searchTheme">테마</label></dt>
					<dd><select id="searchTheme" class="form-control"></select></dd>
				</dl>
				<dl>
					<dt><label for="whatColumnSearch">검색</label></dt>
					<dd>
						<select name="whatColumnSearch" id="whatColumnSearch" class="form-control">
							<option value="">전체</option>
							<option value="name">캠핑장이름</option>
						</select>
						
						<div align="left" style="padding-top: 5px;">
							<input type="hidden" id="whatColumn" name="whatColumn" placeholder="지역/테마/검색 선택">
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
		
		<c:forEach var="beanRow" items="${lists}" varStatus="vsRow" step="2">
		<tr>
			<c:forEach var="beanCell" items="${lists}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*2-1}">
			<td align="center" class="col-xs-12 col-sm-6 col-md-3 ">
			
				<ul class="thumbnail" style="list-style: none; border: none;">
					<li><img src="${images}/1.jpg" style="height: 100px;" alt="..."></li>
					<li class="caption">
					<h3><%-- ${beanCell.name} //이런식으로 사용하세요.--%> : 관광지 명칭</h3>
			            <p>
			            	<span class="spanFlowRootP10">
								<b class="redColor"> (관광지 구분) : 테마 </b>
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
<%@ include file="../../common/bottom.jsp" %>