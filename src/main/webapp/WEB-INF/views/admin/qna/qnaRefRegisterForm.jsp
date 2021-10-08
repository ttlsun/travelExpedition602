<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/admin/top.jsp" %> 

<script type="text/javascript">

$(document).ready(function() {
	
	navActive('qna');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 문의 답변 등록");
	$("#metaDescription").attr("content", "관리자 문의 답변 등록");
	
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
	if (!confirm('답변 등록 하시겠습니까?')){
		return false;
	}
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/qnaList.ad?pageNumber="+${pageNumber};
}

</script>    
 
<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 문의 답변 등록 </h2></header>
	<form:form commandName="qna" name="myForm" action="qnaRefRegister.ad" method="post" enctype="multipart/form-data" class="form-horizontal">
		<input type="hidden" name="id" value="${userId}">
		<input type="hidden" name="pageNumber" id="pageNumber" value="${pageNumber}">
		<input type="hidden" name="num" value="${ref}">
		<input type="hidden" name="ref" value="${ref}">
		<input type="hidden" name="restep" value="${restep}">
		<input type="hidden" name="relevel" value="${relevel}">
		
		<div class="form-group">
		<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
			<tr>
				<td width="20%"><label for="title"><span class="redFont"> * </span>문의 답변 제목 </label> </td>
				<td>
					<input type="text" maxlength="100" class="form-control" name="title" id="title" class="form-control input-sm" placeholder="제목 입력." value="${qna.title}">
					<form:errors cssClass="errMessage" path="title"/>
				</td>
			</tr>
			<tr>
				<td>
					<label for="contents"><span class="redFont"> * </span>문의 답변 내용</label>
				</td>
				<td>
					<textarea class="form-control summernote" rows="20" cols="20"  name="contents" id="contents" class="form-control ">${qna.contents}</textarea>
				</td>
			</tr>
			<tr>
				<td><label for="multipleUpdateFile"> 문의 답변 이미지(여러장 올리기) </label> </td>
				<td>
					<input type="file" multiple id="multipleUpdateFile" name="multipleUpdateFile" value="" accept=".jpg, .jpeg, .png, .gif" >
					<input type="hidden" name="imgname" value="${qna.imgname}">
					<form:errors cssClass="errMessage" path="imgname"/>
				</td>
			</tr>
			<tr>
				<td><label for="regkeyword1"><span class="redFont"> * </span>문의 답변 키워드 </label></td>
				<td>
					<c:forEach items="${keywordLists}" var="keywordList" varStatus="status">
						<label for="regkeyword_${status.index}" style="color: #337ab7;">
							&nbsp;
							<input type="checkbox" name="regkeyword" id="regkeyword_${status.index}" value="${keywordList.tag}" <c:if test="${fn:contains(qna.regkeyword,keywordList.tag)}">checked="checked"</c:if>> ${keywordList.tag}
						</label>
					</c:forEach>
					<form:errors cssClass="errMessage" path="regkeyword"/>
				</td>
			</tr> 
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="submit" class="btn btn-primary" value="등록하기" onclick="return inputSave()">
			<input type="reset" class="btn btn-default" value="취소">
			<input type="button" class="btn btn-primary" value="목록" onclick="goList()">
		</div>
	</form:form>
</div>
</article>
</section>
<%@ include file="../../../common/admin/bottom.jsp" %>