<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/top.jsp" %> 

<script type="text/javascript">

$(document).ready(function() {
	
	navActive('qna');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "회원 문의 삭제");
	$("#metaDescription").attr("content", "회원 문의 삭제");
	
});

function inputSave() {
	//비밀번호 초기화.
	$('#pwChk').html('');
	
	if (!confirm('삭제 하시겠습니까?')){
		return false;
	}
	
	//비밀번호 체크
	if(!pwChk()){
		return false;
	}	
}

//비밀번호 체크
function pwChk() {
	$.ajax({
		url: "pwChk.do",
		type: "POST",
		data: {
			num : $('#num').val(),
			pw : $('#pw').val()
		},
		dataType: "json",
		success: function(data) {
			if (data.resultCode != 'OK') {
				alert(data.resultMsg);
				$('#pwChk').html(data.resultMsg);
				return false;
			}
			
			$('#myForm').attr("method","post").attr("action","qnaDelete.do").submit();
			
		},
		error: function(msg, error) {
			console.log("처리오류");
		}
	});
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/qnaList.do?pageNumber="+${pageNumber};
}

//상세페이지로(돌아가기) 이동 버튼
function goDetail() {
	var num = $('#num').val();
	var pageNumber = $('#pageNumber').val();
	location.href= "${contextPath}/qnaDetail.do?num=" + num + "&pageNumber=" + pageNumber;
}

</script>    
 <section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="goDetail()">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
	</div>
	
	<header><h2 align="center" class="text-primary"> 삭제 화면</h2></header>
	
	<form:form commandName="qna" name="myForm" id="myForm" action="" method="post" class="form-horizontal">
		<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
		<input type="hidden" name="num" id="num" value="${qna.num}">
		
	<table class="table table-bordered">
		<tr>
			<td width="20%" class="active">번호</td>
			<td>${qna.num}</td>
			<td class="active">등록자 아이디</td>
			<td>${qna.id}</td>
		</tr>
		<tr>
			<td class="active">제목</td>
			<td>${qna.title}</td>
			<td class="active">답변 여부</td>
			<td>
				<c:choose>
					<c:when test="${qna.status eq '01'}">대기</c:when>
					<c:when test="${qna.status eq '02'}">보류</c:when>
					<c:when test="${qna.status eq '03'}">완료</c:when>
					<c:otherwise>문의 전화 요망</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<c:if test="${!empty imgList}">
		<tr>
			<td class="active">이미지</td>
			<td colspan="3">
				<div class="rounded">
					<div class="container rounded" style="width: 200px;"> 
	
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
				                	<img src="${fileImg}/${list.imgname}" style="display: block; margin: 0px auto;" alt="First slide" >
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
			  	</div>
			</td>
		</tr>
		</c:if>
		<tr>
			<td colspan="4" style="border-bottom: none;"> 설명 </td>
		</tr>
		<tr>
			<td align="center" colspan="4" style="border-top: none;">
			${qna.contents}
			</td>
		</tr>
		<tr>
			<td style="border-bottom: none;" class="active"> 등록키워드 </td>
			<td colspan="3" style="border-bottom: none;">${qna.regkeyword} </td>
		</tr>
		<tr>
			<td class="active"><label for="pw"><span class="redFont"> * </span> 게시글 비밀번호 </label> </td>
			<td colspan="3">
				<input type="text" class="form-control" maxlength="20" name="pw" id="pw" class="form-control input-sm" placeholder="비밀번호 입력." value="">
				<form:errors cssClass="errMessage" path="pw"/>
				<span id="pwChk" class="errMessage"></span>
			</td>
		</tr>
	</table>
	
	</form:form>
	
	<!-- 버튼 -->
	<div class="marginPadding10" align="center">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
		<input type="button" class="btn btn-default" value="돌아가기" onclick="goDetail()">
		<input type="reset" class="btn btn-default" value="다시작성">
		<input type="submit" class="btn btn-primary" value="삭제하기" onclick="return inputSave()">
	</div>
	<!-- // 버튼 -->
</div>  
</article>
</section>
<script>
	$('.carousel').carousel();
</script>
<%@ include file="../../../common/bottom.jsp" %>