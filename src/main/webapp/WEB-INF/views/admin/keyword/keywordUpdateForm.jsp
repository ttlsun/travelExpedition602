<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/admin/top.jsp" %> 

<script type="text/javascript">

$(document).ready(function() {
	
	navActive('keyword');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "관리자 키워드 태그관리 수정");
	$("#metaDescription").attr("content", "관리자 키워드 태그관리 수정");
	
});

function inputSave() {
	//js안에 있는 null체크 함수 사용.
	if(!isInputNullChk('키워드 구분값','acode','select')){
		$('#acode').focus();
		return false;
	}
	
	//태그 앞에만 #체크
	var tag = $('#tag').val();
	if(tag.indexOf("#") != 0){
		alert("#이 앞에 없습니다. #을 넣어주세요.");
		$('#tag').focus();
		return false;
	}
	
	if (!confirm('수정 하시겠습니까?')){
		return false;
	}
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/keywordList.ad?pageNumber="+${pageNumber};
}

//상세페이지로(돌아가기) 이동 버튼
function goDetail() {
	var num = $('#num').val();
	location.href= "${contextPath}/keywordDetail.ad?num=" + num + "&pageNumber=" + ${pageNumber};
}
</script>    
 
<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 키워드 태그관리 수정 </h2></header>
	<form:form commandName="keyword" name="myForm" action="keywordUpdate.ad" method="post" class="form-horizontal">
		<input type="hidden" name="modid" value="${userId}">
		<input type="hidden" name="num" id="num" value="${keyword.num }">
		<input type="hidden" name="pageNumber" value="${pageNumber}">
		
		<div class="form-group">
		<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
			<tr>
				<td><label for="acode"><span class="redFont"> * </span>키워드 구분값 </label> </td>
				<td>
					<select name="acode" class="form-control">
						<option value="1" <c:if test="${keyword.acode eq '1'}"> selected="selected" </c:if>>캠핑/글램핑</option>
						<option value="2" <c:if test="${keyword.acode eq '2'}"> selected="selected" </c:if>>관광지</option>
						<option value="3" <c:if test="${keyword.acode eq '3'}"> selected="selected" </c:if>>커뮤니티</option>
						<option value="4" <c:if test="${keyword.acode eq '4'}"> selected="selected" </c:if>>문의</option>
					</select>
					<form:errors cssClass="errMessage" path="acode"/>
				</td>
			</tr>
			<tr>
				<td><label for="tag"><span class="redFont"> * </span> 키워드 명칭 </label> </td>
				<td>
					<input type="text" class="form-control" name="tag" id="tag" class="form-control input-sm" value="${keyword.tag}" placeholder="#키워드,#입력">
					<form:errors cssClass="errMessage" path="tag"/>
				</td>
			</tr>
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="button" class="btn btn-primary" value="목록" onclick="goList()">
			<input type="button" class="btn btn-default" value="돌아가기" onclick="goDetail()">
			<input type="reset" class="btn btn-default" value="다시작성">
			<input type="submit" class="btn btn-primary" value="수정하기" onclick="return inputSave()">
		</div>
	</form:form>
</div>
</article>
</section>


<%@ include file="../../../common/admin/bottom.jsp" %>