<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<%
 	String[][] lists = {{"1"},{"2"},{"3"},{"4"}}; 
	request.setAttribute("lists",lists);

%>

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>
<script type="text/javascript">
var selFirstArr = new Array('서울시','부산시','대구시','인천시','광주시','일산시','세종시','경기도','강원도','충청북도','충청남도','전라북도','경상북도','경상남도','제주도');
var selSecondArr = [['강남구','강동구','강북구','강서구','관악구'],
					['강서구','금정구','기장군','남구','동구','동래구','부산진구','북구','사상구','사하구','서구','수영구','연제구','영동구','중구','해운대구'],
					['남구','달서구','달성군','동구','북구','상주','서구','수성구','중구'],
					['강화군','계양구','남구','남동구','동구','부평구','서구','연수구','옹진구','중구'],
					['광산구','남구','동구','북구','서구'],
					['대덕구','덩구','서구','유성구','중구'],
					['남구','동구','북구','울주군','중구'],
					['금남면','세종시','소정면','연서면','전동면'],
					['가평군'],
					['강릉시'],
					['계롱시'],
					['고창군'],
					['강진군'],
					['경산시','경주시','고령군','구미시','군위군','김천시','문경시','봉화군','상주시','성주군','안동시','영덕군','영양군','영주시','영천시','예천군','울릉군','울진군','의성군','청도군','청송군','칠곡군','포항시'],
					['거세시','거창군','고성군','김해시','남해군','밀양시','사천시','사청군','양산시','의령군','진주시','창녕군','창원시','통영시','하동군','함안군','함양군','합천군'],
					['서귀포시','제주시']
				   ];
//지역관련 테스트중..	(2021.09.26 수정중..)			   
var addr1 = [
	{'CODE':11,'NAME':'서울시'},
	{'CODE':26,'NAME':'부산시'},
	{'CODE':27,'NAME':'대구시'},
	{'CODE':28,'NAME':'인천시'},
	{'CODE':29,'NAME':'광주시'},
	{'CODE':30,'NAME':'대전시'},
	{'CODE':31,'NAME':'울산시'},
	{'CODE':36,'NAME':'세종시'},
	{'CODE':41,'NAME':'경기도'},
	{'CODE':42,'NAME':'강원도'},
	{'CODE':43,'NAME':'충청북도'},
	{'CODE':44,'NAME':'충청남도'},
	{'CODE':45,'NAME':'전라북도'},
	{'CODE':46,'NAME':'전라남도'},
	{'CODE':47,'NAME':'경상북도'},
	{'CODE':48,'NAME':'경상남도'},
	{'CODE':50,'NAME':'제주도'}
	];
	
var addr2 = {
		11:[
			{"CODE":11680,"NAME":"강남구"},
			{"CODE":2,"NAME":"부산시"},
			{"CODE":3,"NAME":"대구시"},
			],
		26:[
			{"CODE":1,"NAME":"서울시2"},
			{"CODE":2,"NAME":"부산시"},
			{"CODE":3,"NAME":"대구시"},
			],
		27:[
			{"CODE":1,"NAME":"서울시3"},
			{"CODE":2,"NAME":"부산시"},
			{"CODE":3,"NAME":"대구시"},
			]
};

$(document).ready(function() {
	navActive('camping');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "리스트");
	$("#metaDescription").attr("content", "리스트");
	$("#metaKeywords").attr("content", "#캠핑리스트 ,#관광지리스트,#후기리스트");
	
	//셀렉트 박스 셋팅.
	selInit();
	selThemeInit();
});

function samapleAjax(type, code, callback) {
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
	
	samapleAjax("시도", "", function(data) {
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
	
	//셋팅
	if (selFirstIndex > 0) {
		samapleAjax("구군", $("#searchAddr option:selected").val(), function(data) {
			$.each(data.body, function (i, item) {
			    $('#searchAddr2').append($('<option>', {
			        value: item,
			        text : item
			    }));
			});
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
	<header><h2 align="center" class="text-primary"> 캠핑/관광지/후기 리스트 공통예제 화면</h2></header>
	
	<div class="form-group rounded">
		<form action="sampleCCTList" method="post">
			<input type="hidden"  name="pageNumber" value="${pageInfo.pageNumber}">
			
			<!-- 테스트데이터 : 보는용도로 사용(넣지마세요..) -->
			<input type="text" class="form-control" value="${pageInfo.params}">
			<!-- //테스트데이터 : 보는용도로 사용(넣지마세요..) -->
			
			<div class="">
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
							<option value="name">캠핑장이름</option>
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
			<tr class="tableColor">
				<th width="70%" colspan="3"> 리스트 </th>
			</tr>
		</thead>
		<tbody>
		
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="3" align="center"> 해당 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<c:forEach var="beanRow" items="${lists}" varStatus="vsRow" step="2">
		<tr>
			<c:forEach var="beanCell" items="${lists}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*2-1}">
			<td align="center" class="col-xs-12 col-sm-6 col-md-3 " style="width: 50%;">
				<ul class="thumbnail" style="list-style: none; border: none;">
					<li><img src="${images}/1.jpg" style="height: 100px;" alt="..."></li>
					<li class="caption">
					<h3> 타이틀 </h3>
			            <p>
				            <span class="spanFlowRootP10">
								<b class="redColor"> 구분 (테마) </b>
							</span>
							<span class="spanFlowRootP10 text-primary textFontSizeLarge">
							</span>
							<span class="">
								&nbsp; <span class="label label-warning"> 추천 </span>
								&nbsp; <span class="label label-danger"> HOT </span>
								&nbsp; <span class="label label-default"> NEW </span>
							</span>
						</p>
						<p> 한줄 설명 </p>
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
	
	<!-- 페이징 : 내려주는 게 없어서 적용이 안됨. -->
	<div class="paginationCenter" align="center">
		${pageInfo.pagingHtml}
	</div>
	
</div>   
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>
