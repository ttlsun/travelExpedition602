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
	navActive('community');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "내 예약리뷰 후기 리스트");
	$("#metaDescription").attr("content", "내 후기(리뷰) 캠핑/글램핑, 관광지 후기 리스트");
	$("#metaKeywords").attr("content", "#내 후기(리뷰) #캠핑/글램핑, #관광지, #후기");
	
});

//상세페이지로 이동 버튼
function goDetail(num) {
	location.href= "${contextPath}/communityDetail.do?num=" + num + "&pageNumber=" + ${pageInfo.pageNumber} +"&type=3";
}
	
</script>

<section class="container">
<article>
<div>
	<header>
		<div style="padding-bottom: 1%;">
			<img class="travelExpedition602" width="1140" src="${images}/review.jpg" title="review 이미지" alt="review 이미지"  />
		</div>
	</header>
	
	<div class="form-horizontal rounded">
		<form action="myCommunityList.do">
			<div>
				<dl>
					<dt><label for="searchWhatColumn">검색</label></dt>
					<dd>
						<select name="whatColumn" id="searchWhatColumn" class="form-control">
							<option value="">전체 검색</option>
							<option value="title">타이틀</option>
							<option value="summary">한줄내용</option>
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
	
	<table class="table table-bordered" style="padding-top: 5%;">
		<caption>레코드 총 갯수 : ${totalCount} </caption>
		<thead>
			<tr class="active">
				<th colspan="3">MY 후기</th>
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
			<td align="center" class="col-xs-12 col-sm-6 col-md-3" width="50%">
			
				<ul class="thumbnail" style="list-style: none; border: none;">
					<li><img src="${fileImg}/${beanCell.imgurl}" style="height: 100px;" alt="${beanCell.imgurl} 이미지" title="${beanCell.imgurl} 이미지"></li>
					<li class="caption">
						<!-- 내가 등록한 날짜 -->
						<fmt:parseDate var="fmtDate" value="${beanCell.regdate}" pattern="yyyy-MM-dd"/>
						<fmt:formatDate var="regdate" value="${fmtDate}" pattern="yyyy-MM-dd"/>
						
						<!-- 현재날짜 -->
						<c:set var="today" value="<%=new java.util.Date()%>" />
						<c:set var="date"><fmt:formatDate value="${today}" pattern="yyyy-MM-dd" /></c:set>
														
					<h3>${beanCell.title}</h3>
			            <p>
			            	<span class="spanFlowRootP10">
								<b class="redColor">[${beanCell.reviewtype}]</b>
							</span>
							<span class="spanFlowRootP10 text-primary textFontSizeLarge">
							</span>
							<span class="">
								<c:if test="${beanCell.recommend >= 10}">
									&nbsp; <span class="label label-warning"> 추천 </span>
								</c:if>
								<c:if test="${beanCell.readcount >= 10}">
									&nbsp; <span class="label label-danger"> HOT </span>
								</c:if>
								<c:if test="${date eq regdate}">
									&nbsp; <span class="label label-default"> NEW </span>
								</c:if>
								<c:if test="${beanCell.steamed >= 10}">
									&nbsp; <span class="label label-warning"> 찜 </span>
								</c:if>
								<c:if test="${beanCell.reservationnum > 0}">
									&nbsp; <span class="label btn-info"> 예약후기 </span>
								</c:if>
							</span>
						</p>
						<p>${beanCell.summary}</p>
						<p>
							${regdate}
						</p>
			            <p>
			            	<a href="#" class="btn btn-primary" role="button" onclick="goDetail(${beanCell.num})" style="text-decoration:none; color: white;">상세보기</a> 
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
<%@ include file="../../../common/bottom.jsp" %>