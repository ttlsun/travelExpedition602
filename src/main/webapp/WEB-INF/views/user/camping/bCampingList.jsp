<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>

<style type="text/css">
	th,td{
		text-align: center;
	}
}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('bCamping');
	
	$("#metaTitle").attr("content", "캠핑 리스트");
	$("#metaDescription").attr("content", "캠핑리스트");
	$("#metaKeywords").attr("content", "#캠핑리스트");
	
});

//캠핑장 등록하기 버튼 클릭시
function goRegister(){
	location.href="${contextPath}/bCampingRegister.do";
}

</script>

<section class="container">
<article>
<div>
	<header>
		<div style="padding-bottom: 1%;">
			<img class="travelExpedition602" width="1140" src="${images}/camping.jpg" title="camping 이미지" alt="camping 이미지"  />
		</div>
	</header>
	
	<form name="myform" action="${contextPath}/bCampingList.do" method="post">
	<table class="table table-bordered" style="">
		<caption>
			<span style="text-align: left">총 ${totalCount }개 캠핑장이 검색되었습니다. </span>
			<input type="button" style="float: right;" class="btn btn-primary" value="캠핑장 등록" onClick="goRegister()">
		</caption>
		<thead>
			<tr class="active">
				<td colspan="3"></td>
			</tr>
		</thead>
		<tbody>
			<c:if test="${empty lists}">
				<tr>
					<td colspan="3" align="center">조건에 맞는 캠핑장 목록이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:forEach var="bean" items="${lists}">
				<tr>
					<td rowspan="3" align="center" class="col-xs-4 col-sm-4 col-md-4">
						<img src="${fileImg}/${bean.imgurl}" alt="" title="" width="100%">
					</td>
					<td colspan="2"align="left">
						<h3><a href="${contextPath }/bCampingDetail.do?num=${bean.num}&pageNumber=${pageInfo.pageNumber}">
							[${bean.address1}&nbsp;${bean.address2}]&nbsp;${bean.name }</a></h3>
						<p style="font-style: italic;">"${bean.summary }"</p>
						<h4 style="color:purple; font-weight: normal;">
							<c:forTokens var="keyword" items="${bean.regkeyword }" delims=",">
								${keyword }
							</c:forTokens>
						</h4>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" class="text-center">
						<c:if test="${fn:contains(bean.camptype,'01') }">일반캠핑장&nbsp;</c:if>
						<c:if test="${fn:contains(bean.camptype,'02') }">자동차캠핑장&nbsp;</c:if>
						<c:if test="${fn:contains(bean.camptype,'03') }">글램핑&nbsp;</c:if>
						<c:if test="${fn:contains(bean.camptype,'04') }">카라반&nbsp;</c:if>
					</td>
				</tr>
				<tr>
					<td style="border-right: none; width:25%">
						<div class="fs-4 mb-3 text-left">
             				<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
 								<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
 								<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
							</svg>
						조회수 ${bean.readcount }
           				</div>
					</td>
					<td colspan="3" class="text-right" style="border-left: none;">
						<span class="outline-secondary" style="padding-left: 1%;">
						추천
			   		 	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
			  				<path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
						</svg>
						${bean.recommend }
			   			</span>
						<span class="outline-secondary" style="padding-left: 1%;">
	           			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-suit-heart" viewBox="0 0 16 16">
						  <path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
						</svg>
						찜&nbsp;${bean.steamed }
						</span>
						<span class="outline-secondary" style="padding-left: 1%;">
						리뷰&nbsp;
						${bean.reviewcount }
			   			</span>
					</td>
				</tr>
		</c:forEach> 
		</tbody>
	</table>
	
	<div class="paginationCenter" align="center">
		${pageInfo.pagingHtml}
	</div>
	</form>
		
</div>
</article>
</section>


<%@ include file="../../../common/bottom.jsp" %>