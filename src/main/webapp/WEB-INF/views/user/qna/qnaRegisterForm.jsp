<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/top.jsp" %> 

<script type="text/javascript">

$(document).ready(function() {
	
	navActive('qna');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "회원 문의 등록");
	$("#metaDescription").attr("content", "회원 문의 등록");
	
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
	if (!confirm('등록 하시겠습니까?')){
		return false;
	}
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/qnaList.do";
}

</script>    
 
<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="history.go(-1)">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
	</div>

	<header><h2 align="center" class="text-primary"> 문의 등록 </h2></header>
	<form:form commandName="qna" name="myForm" action="qnaRegister.do" method="post" enctype="multipart/form-data" class="form-horizontal">
		<input type="hidden" name="id" value="${userId}">
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
				<td class="active"><label for="multipleUpdateFile"> 문의 이미지(여러장 올리기) </label> </td>
				<td>
					<input type="file" multiple id="multipleUpdateFile" name="multipleUpdateFile" value="" accept=".jpg, .jpeg, .png, .gif" >
					<input type="hidden" name="imgname" value="${qna.imgname}">
					<form:errors cssClass="errMessage" path="imgname"/>
				</td>
			</tr>
			<tr>
				<td class="active"><label for="regkeyword1"><span class="redFont"> * </span>문의 키워드 </label></td>
				<td>
					<c:forEach items="${keywordLists}" var="keywordList" varStatus="status">
						<%-- <c:if test="${keywordList.tag ne '#답변'}"> --%>
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
			<tr>
				<td class="active"><label for="pw"> 게시글 비밀번호 </label> </td>
				<td>
					<input type="password" maxlength="20" class="form-control" name="pw" id="pw" class="form-control input-sm" placeholder="비밀번호 입력." value="${qna.pw}">
					<form:errors cssClass="errMessage" path="pw"/>
				</td>
			</tr>
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="button" class="btn btn-primary" value="목록" onclick="goList()">
			<input type="reset" class="btn btn-default" value="다시작성">
			<input type="submit" class="btn btn-primary" value="등록하기" onclick="return inputSave()">
		</div>
	</form:form>
</div>
</article>
</section>


<%@ include file="../../../common/bottom.jsp" %>