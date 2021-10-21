<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/top.jsp" %> 

<script type="text/javascript">

$(document).ready(function() {
	
	navActive('qna');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "회원 문의 수정");
	$("#metaDescription").attr("content", "회원 문의 수정");
	
	//설명
	$('.summernote').summernote({
	 	height: 200,   //set editable area's height
	 	placeholder : "설명 입력해주세요.", //placeholder
	  	codemirror: { // codemirror options
	    theme: 'monokai'
	  }
	});
	
	//저장시 사용
	var save = function() {
	  var markup = $('.click2edit').summernote('code');
	  $('.click2edit').summernote('destroy');
	};
	
});

function inputSave() {
	//비밀번호 초기화.
	$('#pwChk').html('');
	
	if (!confirm('수정 하시겠습니까?')){
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
			
			$('#myForm').attr("method","post").attr("action","qnaUpdate.do").submit();
			
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

	<header><h2 align="center" class="text-primary"> 문의 수정 </h2></header>
	<form:form commandName="qna" name="myForm" id="myForm" action="" method="post" enctype="multipart/form-data" class="form-horizontal">
		<input type="hidden" name="modid" value="${userId}">
		<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
		<input type="hidden" name="num" id="num" value="${qna.num}">
		
		<div class="form-group">
		<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
			<tr>
				<td class="active"><label for="title"><span class="redFont"> * </span>문의 제목 </label> </td>
				<td>
					<input type="text" maxlength="100" class="form-control" name="title" id="title" class="form-control input-sm" placeholder="제목 입력." value="${qna.title}">
					<form:errors cssClass="errMessage" path="title"/>
				</td>
			</tr>
			<tr>
				<td class="active">
					<label for="contents"><span class="redFont"> * </span>문의 내용</label>
				</td>
				<td>
					<textarea class="form-control summernote" rows="20" cols="20"  name="contents" id="contents" class="form-control ">${qna.contents}</textarea>
				</td>
			</tr>
			<tr>
				<td class="active"><label for="multipleImgFile"> 문의 이미지(여러장 올리기) </label> </td>
				<td>
					<c:if test="${!empty imgList}">
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
					                	<img src="${fileImg}/${list.imgname}" style="height: 100px;  display: block; margin: 0px auto;" alt="First slide" >
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
					</c:if>
					<input type="file" multiple id="multipleImgFile" name="multipleUpdateFile" value="" accept=".jpg, .jpeg, .png, .gif" >
				</td>
			</tr>
			<tr>
				<td class="active"><label for="regkeyword1">문의 키워드 </label></td>
				<td>
					<c:forEach items="${keywordLists}" var="keywordList" varStatus="status">
						<c:if test="${!fn:contains(keywordList.tag,'#답변')}">
							<label for="regkeyword_${status.index}" style="color: #337ab7;">
								&nbsp;
								<input type="checkbox" name="regkeyword" id="regkeyword_${status.index}" value="${keywordList.tag}" <c:if test="${fn:contains(qna.regkeyword,keywordList.tag)}">checked="checked"</c:if>> ${keywordList.tag}
							</label>
						</c:if>
					</c:forEach>
					<form:errors cssClass="errMessage" path="regkeyword"/>
				</td>
			</tr> 
			<c:if test="${!empty qna.pw}">
			<tr>
				<td class="active"><label for="pw"><span class="redFont"> * </span> 게시글 비밀번호 </label> </td>
				<td>
					<input type="password" maxlength="20" class="form-control" name="pw" id="pw" class="form-control input-sm" placeholder="비밀번호 입력." value="">
					<form:errors cssClass="errMessage" path="pw"/>
					<span id="pwChk" class="errMessage"></span>
				</td>
			</tr>
			</c:if>
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			<input type="button" class="btn btn-default" value="돌아가기" onclick="goDetail()">
			<input type="reset" class="btn btn-default" value="다시작성">
			<input type="submit" class="btn btn-primary" value="수정하기" onclick="return inputSave()">
		</div>
	</form:form>
</div>
</article>
</section>


<%@ include file="../../../common/bottom.jsp" %>