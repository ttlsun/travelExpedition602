<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   
<script type="text/javascript" >
$(document).ready(function() {
	//메뉴 on 유지.
	navActive('community');
	
	$("#metaTitle").attr("content", "${community.title}");
	$("#metaDescription").attr("content", "${community.summary}");
	$("#metaKeywords").attr("content", "${community.regkeyword}");
	
});

//리스트 버튼 클릭시
function goList() {
	var type = $('#type').val();
	if(type == 3){
		location.href= "${contextPath}/myCommunityList.do?pageNumber="+${pageNumber};
	}else if(type == 2){
		location.href= "${contextPath}/reviewCommunityList.do?pageNumber="+${pageNumber};
	}else{
		location.href= "${contextPath}/communityList.do?pageNumber="+${pageNumber};
	}
}

//글쓴이만 업뎃하러가기
function goUpdate() {
	$('#myForm').attr("action","communityUpdate.do").submit();
}

//글쓴이만 후기글 삭제
function goDelete(num) {
	if (!confirm('후기글 삭제 하시겠습니까?')){
		return false;
	}

	goAjaxDelete("communityUpdateStatus.do", num, 1);

}

//별 , 좋아요 등록 
function goRatingRegister(ratingtype) {
	var userid = "${userId}"; // 페이지 진입한 유저 아이디.
	var regid = "${community.regid}" //후기등록자 아이디
	var userCode = "${userCode}"; //유저 구분코드
	
	//회원이 아닐 경우,
	//로그인 페이지로 안보낼거임..
	if(userid == null || userid == ""){
		alert("로그인 후 하시길 바랍니다."); 
		return false; 
	}
	
	//사업자는 찜콩하지마쇼
	if(userCode == "business" || userCode == "admin"){
		alert("사업자/관리자는 후기에 추천/찜 하실 수 없습니다.");
		return;
	}
	
	//자기가 적은 후기는 추천할수 없게 설정.
	if(userid == regid || regid == "admin"){
		alert("자신이 적은 후기에 추천/찜 하실 수 없습니다.");
		return;
	}
	
	$.ajax({
		url: "communityRatingRegister.do",
		type: "POST",
		data: {
			num : $('#num').val(),
			reviewnum : $('#reviewnum').val(),
			reviewtype : $('#reviewtype').val(),
			ratingtype : ratingtype,
			regid : userid
		},
		dataType: "json",
		success: function(data) {
			if (data.resultCode != 'OK') {

				console.log(data.resultMsg);
				if(ratingtype == 01){
					alert("이미 추천 하신분은 또 추천 하실수 없습니다.");
				}else{
					alert("이미 찜 하신분은 또 추천 하실수 없습니다.");
				}
				
				return;
			}
			
			console.log(ratingtype);
			if(ratingtype == 02){
				likesRegisters();
			}
			
			location.reload();
			
		},
		error: function(msg, error) {
			console.log("처리오류");
		}
	});
	
}

//공통으로 같이 태울 찜 likes 등록.
function likesRegisters() {
	var userId = "${userId}"; // 페이지 진입한 유저 아이디.
	var num = $('#num').val(); //id로 얻어온 자기 고유값 넣기.
	var acode = "3"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티)
	
	$.ajax({
		url: "myLikesRegister.do",
		type: "POST",
		data: {
			num : num,
			userId : userId,
			acode : acode
		},
		dataType: "json",
		success: function(data) {
			if (data.resultCode != 'OK') {
				//alert(data.resultMsg);
				return;
			}
			
			goMyLikesList();
			
		},
		error: function(msg, error) {
			console.log("처리오류");
		}
	});
}

//찜목록으로 이동
function goMyLikesList() {
	location.href= "${contextPath}/myLikesList.do";
}

//댓글 등록.
function goReplyRegister() {
	var regid = "${userId}"; // 페이지 진입한 유저 아이디.

	//회원이 아닐 경우,
	if(regid == null || regid == ""){
		alert("로그인 후 댓글 등록 바랍니다.");
		return false; 
	}
	
	//댓글 길이 체크
	if(!isInputLen("후기댓글","content",2,300)){
		return false;
	}
	
	if (!confirm('후기 댓글 등록 하시겠습니까?')){
		return false;
	}
	
	$.ajax({
		url: "communityReplyRegister.do",
		type: "POST",
		data: {
			reviewnum : $('#num').val(),
			reviewtype : $('#reviewtype').val(),
			contents : $('#content').val(),
			regid : regid
		},
		dataType: "json",
		success: function(data) {
			if (data.resultCode != 'OK') {
				//alert(data.resultMsg);
				return;
			}
			
			location.reload();
		},
		error: function(msg, error) {
			console.log("처리오류");
		}
	});
	
}


function goReplyDelete(num) {
	
	if (!confirm('후기 댓글 삭제 하시겠습니까?')){
		return;
	}
	
	goAjaxDelete("communityReplyDelete.do", num , 2);
}

//삭제 ajax
function goAjaxDelete(url, numData , type) {
	$.ajax({
		url: url,
		type: "POST",
		data: {
			num : numData
		},
		dataType: "json",
		success: function(data) {
			if (data.resultCode != 'OK') {
				//alert(data.resultMsg);
				return;
			}
			
			if(type == 1){
				goList();
			}else{
				location.reload();
			}
		},
		error: function(msg, error) {
			console.log("처리오류");
		}
	});
}

</script>

<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="목록보기" onclick="goList()">
	
		<c:if test="${community.regid eq userId}">
			<input type="submit" class="btn btn-primary" value="수정" onclick="goUpdate()">
			<input type="submit" class="btn btn-primary" value="삭제" onclick="return goDelete(${community.num})">
		</c:if>
	</div>
	
	<header><h2 align="center" class="text-primary">${community.title} 상세 화면</h2></header>
	
	<form name="myForm" id="myForm" action="" method="get" class="form-horizontal">
	<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
	<input type="hidden" name="num" id="num" value="${community.num}">
	<input type="hidden" name="reviewnum" id="reviewnum" value="${community.reviewnum}">
	<input type="hidden" name="reviewtype" id="reviewtype" value="${community.reviewtype}">
	<input type="hidden" name="type" id="type" value="${type}">
	
	<table class="table table-bordered">
		<tr>
			<td colspan="4" align="center" style="border-bottom: none;">
				<img src="${fileImg}/${community.imgurl}" alt="${community.imgurl} 이미지" title="${community.imgurl} 이미지" width="30%">
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" style="border: none; padding-bottom: 20px;">
				<span class="text-primary" style="font-size: 20px;">
				후기 상세 화면
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="1" style="border: none;">
				<c:choose>
					<c:when test="${community.reviewtype eq '01'}">
						캠핑/글램핑 후기
					</c:when>
					<c:when test="${community.reviewtype eq '02'}">
						관광지 후기
					</c:when>
					<c:otherwise>
						커뮤니티 후기
					</c:otherwise>
				</c:choose>
			
			</td>
			<td colspan="3" align="right" style="border: none; padding-top: 2%" width="20%">
				<div class="fs-4 mb-3">
             		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-eye" viewBox="0 0 16 16">
 						<path d="M16 8s-3-5.5-8-5.5S0 8 0 8s3 5.5 8 5.5S16 8 16 8zM1.173 8a13.133 13.133 0 0 1 1.66-2.043C4.12 4.668 5.88 3.5 8 3.5c2.12 0 3.879 1.168 5.168 2.457A13.133 13.133 0 0 1 14.828 8c-.058.087-.122.183-.195.288-.335.48-.83 1.12-1.465 1.755C11.879 11.332 10.119 12.5 8 12.5c-2.12 0-3.879-1.168-5.168-2.457A13.134 13.134 0 0 1 1.172 8z"/>
 						<path d="M8 5.5a2.5 2.5 0 1 0 0 5 2.5 2.5 0 0 0 0-5zM4.5 8a3.5 3.5 0 1 1 7 0 3.5 3.5 0 0 1-7 0z"/>
				</svg>
					조회수 ${community.readcount}
           		</div>
			</td>
		</tr>
		<tr>
			<c:choose>
				<c:when test="${community.reviewtype ne '03' }">
					<td colspan="1" style="border: none;" width="30%">
						<fmt:parseNumber var="starranking" value="${community.starranking}"/>
						<c:forEach var="i" begin="1" end="5">
							<c:choose>
								<c:when test="${i <= starranking}">
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star-fill" viewBox="0 0 16 16">
									  <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.282.95l-3.522 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
									</svg>
								</c:when>
								<c:otherwise>
									<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-star" viewBox="0 0 16 16">
									  <path d="M2.866 14.85c-.078.444.36.791.746.593l4.39-2.256 4.389 2.256c.386.198.824-.149.746-.592l-.83-4.73 3.522-3.356c.33-.314.16-.888-.282-.95l-4.898-.696L8.465.792a.513.513 0 0 0-.927 0L5.354 5.12l-4.898.696c-.441.062-.612.636-.283.95l3.523 3.356-.83 4.73zm4.905-2.767-3.686 1.894.694-3.957a.565.565 0 0 0-.163-.505L1.71 6.745l4.052-.576a.525.525 0 0 0 .393-.288L8 2.223l1.847 3.658a.525.525 0 0 0 .393.288l4.052.575-2.906 2.77a.565.565 0 0 0-.163.506l.694 3.957-3.686-1.894a.503.503 0 0 0-.461 0z"/>
									</svg>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</td>
				</c:when>
				<c:otherwise>
					<td colspan="1" style="border: none;"></td>
				</c:otherwise>
			</c:choose>
			
			<td colspan="3" style="border: none; text-align:end;" width="30%">
				<button type="button" class="btn outline-secondary" onclick="goRatingRegister('01')">
					추천
			    	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-hand-thumbs-up" viewBox="0 0 16 16">
			  		<path d="M8.864.046C7.908-.193 7.02.53 6.956 1.466c-.072 1.051-.23 2.016-.428 2.59-.125.36-.479 1.013-1.04 1.639-.557.623-1.282 1.178-2.131 1.41C2.685 7.288 2 7.87 2 8.72v4.001c0 .845.682 1.464 1.448 1.545 1.07.114 1.564.415 2.068.723l.048.03c.272.165.578.348.97.484.397.136.861.217 1.466.217h3.5c.937 0 1.599-.477 1.934-1.064a1.86 1.86 0 0 0 .254-.912c0-.152-.023-.312-.077-.464.201-.263.38-.578.488-.901.11-.33.172-.762.004-1.149.069-.13.12-.269.159-.403.077-.27.113-.568.113-.857 0-.288-.036-.585-.113-.856a2.144 2.144 0 0 0-.138-.362 1.9 1.9 0 0 0 .234-1.734c-.206-.592-.682-1.1-1.2-1.272-.847-.282-1.803-.276-2.516-.211a9.84 9.84 0 0 0-.443.05 9.365 9.365 0 0 0-.062-4.509A1.38 1.38 0 0 0 9.125.111L8.864.046zM11.5 14.721H8c-.51 0-.863-.069-1.14-.164-.281-.097-.506-.228-.776-.393l-.04-.024c-.555-.339-1.198-.731-2.49-.868-.333-.036-.554-.29-.554-.55V8.72c0-.254.226-.543.62-.65 1.095-.3 1.977-.996 2.614-1.708.635-.71 1.064-1.475 1.238-1.978.243-.7.407-1.768.482-2.85.025-.362.36-.594.667-.518l.262.066c.16.04.258.143.288.255a8.34 8.34 0 0 1-.145 4.725.5.5 0 0 0 .595.644l.003-.001.014-.003.058-.014a8.908 8.908 0 0 1 1.036-.157c.663-.06 1.457-.054 2.11.164.175.058.45.3.57.65.107.308.087.67-.266 1.022l-.353.353.353.354c.043.043.105.141.154.315.048.167.075.37.075.581 0 .212-.027.414-.075.582-.05.174-.111.272-.154.315l-.353.353.353.354c.047.047.109.177.005.488a2.224 2.224 0 0 1-.505.805l-.353.353.353.354c.006.005.041.05.041.17a.866.866 0 0 1-.121.416c-.165.288-.503.56-1.066.56z"/>
					</svg>
					${community.recommend}
			    </button>
			   <button type="button" class="btn outline-secondary" onclick="goRatingRegister('02')">
	           		찜
	           		<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="bi bi-suit-heart" viewBox="0 0 16 16">
					  <path d="m8 6.236-.894-1.789c-.222-.443-.607-1.08-1.152-1.595C5.418 2.345 4.776 2 4 2 2.324 2 1 3.326 1 4.92c0 1.211.554 2.066 1.868 3.37.337.334.721.695 1.146 1.093C5.122 10.423 6.5 11.717 8 13.447c1.5-1.73 2.878-3.024 3.986-4.064.425-.398.81-.76 1.146-1.093C14.446 6.986 15 6.131 15 4.92 15 3.326 13.676 2 12 2c-.777 0-1.418.345-1.954.852-.545.515-.93 1.152-1.152 1.595L8 6.236zm.392 8.292a.513.513 0 0 1-.784 0c-1.601-1.902-3.05-3.262-4.243-4.381C1.3 8.208 0 6.989 0 4.92 0 2.755 1.79 1 4 1c1.6 0 2.719 1.05 3.404 2.008.26.365.458.716.596.992a7.55 7.55 0 0 1 .596-.992C9.281 2.049 10.4 1 12 1c2.21 0 4 1.755 4 3.92 0 2.069-1.3 3.288-3.365 5.227-1.193 1.12-2.642 2.48-4.243 4.38z"/>
					</svg>
					${community.steamed}
				</button>
			</td>
		</tr>
		<tr>
			<td width="10%" class="active">번호</td>
			<td width="20%">${community.num}</td>
			<td width="30%" class="active">등록 ID</td>
			<td width="40%">${community.regid}</td>
		</tr>
		<tr>
			<td colspan="4" style="border-bottom: none;"> 설명 </td>
		</tr>
		<tr>
			<td align="center" colspan="4" style="border-top: none;">
			${community.contents}
			</td>
		</tr>
		<c:if test="${!empty community.regkeyword}">
		<tr>
			<td width="20%" class="active"> 키워드 </td>
			<td colspan="3"> <span class="text-primary"> ${community.regkeyword} </span> </td>
		</tr>
		</c:if>
	</table>
	
	<!-- 후기 사진  -->
	<c:choose>
		<c:when test="${!empty imgList }">
		<div class="container"> 
			<div class="marginPadding10">
				<label class="text-primary textFontSizeLarge"> 후기이미지들 </label>
			</div>
	        <div id="carousel-example-generic" class="carousel slide">
	        
	            <!-- Indicators(이미지 하단의 동그란것->class="carousel-indicators") -->
	            <ol class="carousel-indicators">
	              <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	              <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	              <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	            </ol>
	            
	             <!-- Carousel items -->
	             <div class="carousel-inner">
	                <c:forEach items="${imgList}" var="list" varStatus="status">
	                	<div class="item <c:if test="${status.first}"> active </c:if> ">
	                	<img src="${fileImg}/${list.imgname}" style="height:400px; display: block; margin: 0px auto;" alt="${list.imgname} 이미지" title="${list.imgname} 이미지" >
		                </div>
	                </c:forEach>
	             </div>
	            <!-- Controls -->
	              <a class="left carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="prev">
	                <span class="icon-prev"></span>
	              </a>
	              <a class="right carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="next">
	                <span class="icon-next"></span>
	              </a>
	          </div>
	  	</div>
		<!-- // 후기 사진  -->
		
		</c:when>
	</c:choose>
	</form>
	
	<form action="communityDetail.do" name="myReplyForm">
	<input type="hidden" name="replyPageNumber" id="replyPageNumber" value="${replyPageInfo.pageNumber}">
	<div class="marginPadding10">
		<fieldset>
		<legend class="textAlignLeft">후기 댓글</legend>
			<div class="form-group">
				<label for="content" class="col-xs-2 col-lg-2 control-label text-primary">${userId}댓글</label> 
				<div class="col-xs-6 col-lg-6">
					<span>
						<input type="text" class="form-control" name="content" id="content" value="">
						<%-- <form:errors cssClass="errMessage" path="content"/> --%>
					</span>
				</div>
				<div align="left">
					<button type="button" class="btn btn-outline-secondary" onclick="return goReplyRegister()">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-reply" viewBox="0 0 16 16">
					<path d="M6.598 5.013a.144.144 0 0 1 .202.134V6.3a.5.5 0 0 0 .5.5c.667 0 2.013.005 3.3.822.984.624 1.99 1.76 2.595 3.876-1.02-.983-2.185-1.516-3.205-1.799a8.74 8.74 0 0 0-1.921-.306 7.404 7.404 0 0 0-.798.008h-.013l-.005.001h-.001L7.3 9.9l-.05-.498a.5.5 0 0 0-.45.498v1.153c0 .108-.11.176-.202.134L2.614 8.254a.503.503 0 0 0-.042-.028.147.147 0 0 1 0-.252.499.499 0 0 0 .042-.028l3.984-2.933zM7.8 10.386c.068 0 .143.003.223.006.434.02 1.034.086 1.7.271 1.326.368 2.896 1.202 3.94 3.08a.5.5 0 0 0 .933-.305c-.464-3.71-1.886-5.662-3.46-6.66-1.245-.79-2.527-.942-3.336-.971v-.66a1.144 1.144 0 0 0-1.767-.96l-3.994 2.94a1.147 1.147 0 0 0 0 1.946l3.994 2.94a1.144 1.144 0 0 0 1.767-.96v-.667z"/>
					</svg>
					<span class="visually-hidden"> 댓글</span>
					</button>
				</div>
			</div>
		</fieldset>
	</div>
	<!-- 댓글 리스트 -->
	<div class="marginPadding10">
	
		<div class="form-group">
			<table class="table table-bordered rounded">
			<caption>후기 댓글 목록(총갯수 : ${replyTotalCount})</caption>
				<!-- list가 없을 경우 -->
				<c:if test="${empty replyLists}">
				<tr>
					<td colspan="3" align="center"> 해당 후기 레코드가 없습니다.</td>
				</tr>
				</c:if>
				<c:forEach var="replyList" items="${replyLists}">
				<tr>
					<td class="tableWidth200" style="border: none;" align="center">
						<label for="replyNo"> ${replyList.regid } </label> 
					</td>
					<td style="border: none;">
						${replyList.contents}
					</td>
					<c:if test="${replyList.regid eq userId}">
					<td style="border: none;">
						<input type="button" class="btn btn-primary" value="X" onclick="return goReplyDelete(${replyList.num})">
					</td>
					</c:if>
				</tr>
				</c:forEach>
			</table>
		</div>
		
		<!-- 댓글 페이징 -->
		<div class="paginationCenter" align="center">
			${replyPageInfo.pagingHtml}
		</div>
		<!-- // 댓글 페이징 -->
	</div>
	<!-- // 댓글 리스트 -->
	</form>
	
	
	<!-- 추천  -->
	<c:choose>
		<c:when test="${!empty recommendList }">
		<div class="container"> 
			<div class="marginPadding10">
				<label class="text-primary textFontSizeLarge"> 추천 </label>
			</div>
	        <div id="carousel-example-generic" class="carousel slide">
	        
	            <!-- Indicators(이미지 하단의 동그란것->class="carousel-indicators") -->
	            <ol class="carousel-indicators">
	              <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
	              <li data-target="#carousel-example-generic" data-slide-to="1"></li>
	              <li data-target="#carousel-example-generic" data-slide-to="2"></li>
	            </ol>
	            
	             <!-- Carousel items -->
	             <div class="carousel-inner">
	                <c:forEach items="${recommendList}" var="list" varStatus="status">
	                	<div class="item <c:if test="${status.first}"> active </c:if> ">
	                	<c:choose>
	                		<c:when test="${community.reviewtype eq '01'}">
	                			<a href="${contextPath}/campingDetail.do?pageNumber=1&num=${list.num}">
			                		<img src="${fileImg}/${list.imgname}" style="height:400px; display: block; margin: 0px auto;" alt="${list.imgname} 이미지" title="${list.imgname} 이미지" >
				                </a>
	                		</c:when>
	                		<c:when test="${community.reviewtype eq '02'}">
	                			<a href="${contextPath}/tourDetail.do?pageNumber=1&num=${list.num}">
			                		<img src="${fileImg}/${list.imgname}" style="height:400px; display: block; margin: 0px auto;" alt="${list.imgname} 이미지" title="${list.imgname} 이미지" >
				                </a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="${contextPath}/campingDetail.do?pageNumber=1&num=${list.num}">
			                		<img src="${fileImg}/${list.imgname}" style="height:400px; display: block; margin: 0px auto;" alt="${list.imgname} 이미지" title="${list.imgname} 이미지" >
				                </a>
	                		</c:otherwise>
	                	</c:choose>
	                	</div>
	                </c:forEach>
	             </div>
	            <!-- Controls -->
	              <a class="left carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="prev">
	                <span class="icon-prev"></span>
	              </a>
	              <a class="right carousel-control" href="#carousel-example-generic" style="background-image:none;" data-slide="next">
	                <span class="icon-next"></span>
	              </a>
	          </div>
	  	</div>
		</c:when>
	</c:choose>
	<!-- // 추천  -->
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<c:if test="${community.regid eq userId}">
			<input type="submit" class="btn btn-primary" value="수정" onclick="goUpdate()">
			<input type="submit" class="btn btn-primary" value="삭제" onclick="return goDelete(${community.num})">
		</c:if>
		<input type="button" class="btn btn-default" value="목록보기" onclick="goList()">
	</div>
	<!-- // 버튼 -->
</div>  
</article>
</section>
<script>
	$('.carousel').carousel();
</script>
<%@ include file="../../../common/bottom.jsp" %>   