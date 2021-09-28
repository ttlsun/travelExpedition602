<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('community');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "후기 리스트");
	$("#metaDescription").attr("content", "캠핑/글램핑, 관광지 후기 리스트");
	$("#metaKeywords").attr("content", "#캠핑/글램핑, #관광지, #후기");
	
});

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
	<header><h2 align="center" class="text-primary">후기 리스트 화면</h2></header>
	
	<div class="form-horizontal rounded">
		<form action="">
			<input type="hidden"  name="pageNumber" value="${pageInfo.pageNumber}">
			<div>
				<dl>
					<dt><label for="searchWhatColumn">검색</label></dt>
					<dd>
						<select name="whatColumn" id="searchWhatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="name">이름</option>
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
		<input type="button" class="btn btn-primary" value="추가하기" onclick="goInsert()">
	</div>
  
	<table class="table table-bordered" style="padding-top: 5%;">
		<caption>레코드 총 갯수 : </caption>
		<thead>
			<tr class="active">
				<th width="70%" colspan="3">후기</th>
			</tr>
		</thead>
		<tbody>
		
		<!-- list가 없을 경우 -->
		<c:if test="${empty lists}">
		<tr>
			<td colspan="3" align="center"> 해당 후기 레코드가 없습니다.</td>
		</tr>
		</c:if>
		
		<c:forEach var="beanRow" items="${lists}" varStatus="vsRow" step="2">
		<tr>
			<c:forEach var="beanCell" items="${lists}" varStatus="vsCell" begin="${vsRow.index}" end="${vsRow.count*2-1}">
			<td align="center" class="col-xs-12 col-sm-6 col-md-3 ">
			
				<ul class="thumbnail" style="list-style: none; border: none;">
					<li><img src="${images}/1.jpg" style="height: 100px;" alt="..."></li>
					<li class="caption">
					<h3>${beanCell.name}</h3>
			            <p>
			            	<span class="spanFlowRootP10">
								<b class="redColor">[캠핑/글램핑 후기]</b>
							</span>
							<span class="spanFlowRootP10 text-primary textFontSizeLarge">
							</span>
							<span class="">
								&nbsp; <span class="label label-warning"> 추천 </span>
								&nbsp; <span class="label label-danger"> HOT </span>
								&nbsp; <span class="label label-default"> NEW </span>
							</span>
						</p>
						<p>${beanCell.contents}</p>
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