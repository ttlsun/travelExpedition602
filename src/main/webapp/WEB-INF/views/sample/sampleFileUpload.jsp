<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<script type="text/javascript" >
$(document).ready(function() {
	
});


//등록버튼 클릭시
function inputSave() {
	if (!confirm('등록 하시겠습니까?')){
		return false;
	}
	
	return true;	
}


</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 파일업로드 샘플 페이지(1개 , 여러개(multiple))</h2></header>
	
	<form:form commandName="sampleFileUploadBean" name="myForm" action="sampleFileUpload" method="post" enctype="multipart/form-data" class="form-horizontal">
	<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td><label for="imgFile"><span class="redFont"> * </span> 대표 타이틀 이미지 </label> </td>
			<td>
				<input type="file" name="imgFile" value="" accept=".jpg, .jpeg, .png, .gif">
			</td>
		</tr>
		<tr>
			<td><label for="multipleImgFile"><span class="redFont"> * </span> 여럿 이미지 올릴거(multiple 적용) </label> </td>
			<td>
				<input type="file" multiple name="multipleImgFile" value="" accept=".jpg, .jpeg, .png, .gif">
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" class="btn btn-primary" value="등록" onclick="return inputSave()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			</td>
		</tr>
	</table>
	</form:form>
	
	<!-- 각자 서버에 넣은 이미지명 넣어서 테스트해보기-->
	<c:set var="imgName" value="1632810029533_체리보드.jpg"/>
	<div>
		<img src="${fileImg}/${imgName}" alt="${imgName}" title="${imgName}" style="width: 300px; height: 200px;"/>
	</div>
</div>  
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>   