<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/admin/top.jsp" %> 

<script type="text/javascript">

$(document).ready(function() {
	
	navActive('notice');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 공지사항 등록");
	$("#metaDescription").attr("content", "관리자 공지사항 등록");
	
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

//등록버튼
function inputSave() {
	
	if (!confirm('등록 하시겠습니까?')){
		return false;
	}
	
}

//리스트로 이동.
function goList() {
	location.href= "${contextPath}/noticeList.ad";
}

</script>    
 
<section class="container">
<article>
<div>
	<div class="marginPadding10" align="right">
		<input type="button" style="float: left" class="btn btn-default" value="돌아가기" onclick="goDetail()">
		<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
	</div>

	<header><h2 align="center" class="text-primary"> 공지사항 등록 </h2></header>
	<form:form commandName="notice" name="myForm" action="noticeRegister.ad" method="post" enctype="multipart/form-data" class="form-horizontal">
		<input type="hidden" name="id" value="${userId}">
		
		<div class="form-group">
		<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
			<tr>
				<td class="active"><label for="title"><span class="redFont"> * </span>공지사항 제목 </label> </td>
				<td>
					<input type="text" class="form-control" name="title" id="title" class="form-control input-sm" placeholder="제목 입력." value="${notice.title}">
					<form:errors cssClass="errMessage" path="title"/>
				</td>
			</tr>
			<tr>
				<td class="active">
					<label for="contents"><span class="redFont"> * </span>공지사항 내용</label>
				</td>
				<td>
					<textarea class="form-control summernote" rows="20" cols="20"  name="contents" id="contents" class="form-control ">${notice.contents}</textarea>
					<form:errors cssClass="errMessage" path="contents"/>
				</td>
			</tr>
			<tr>
				<td class="active"><label for="multipleUpdateFile"> 공지사항 이미지(여러장 올리기) </label> </td>
				<td>
					<input type="file" multiple id="multipleUpdateFile" name="multipleUpdateFile" value="" accept=".jpg, .jpeg, .png, .gif" >
					<input type="hidden" name="imgname" value="${notice.imgname}">
					<form:errors cssClass="errMessage" path="imgname"/>
				</td>
			</tr>
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="button" class="btn btn-primary" value="목록" onclick="goList()">
			<input type="button" class="btn btn-default" value="돌아가기" onclick="goList()">
			<input type="reset" class="btn btn-default" value="다시작성">
			<input type="submit" class="btn btn-primary" value="등록하기" onclick="return inputSave()">
		</div>
	</form:form>
</div>
</article>
</section>


<%@ include file="../../../common/admin/bottom.jsp" %>