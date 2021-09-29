<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<script type="text/javascript" >
$(document).ready(function() {
	
	//메뉴 on 유지.
	navActive('sample');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "등록");
	$("#metaDescription").attr("content", "등록");
	$("#metaKeywords").attr("content", "#등록");
	
	//summernote 선언
	$('.summernote').summernote({
	 	height: 200,   //set editable area's height
	 	placeholder : "설명을 입력해주세요.", //placeholder
	  	codemirror: { // codemirror options
	   		theme: 'monokai'
	  	}
	});
	
	//summernote 저장시 사용
	var save = function() {
	  	var markup = $('.click2edit').summernote('code');
	  	$('.click2edit').summernote('destroy');
	};
	
});


//등록버튼 클릭시
function inputSave() {
	if (!confirm('등록 하시겠습니까?')){
		return false;
	}
	
	return true;	
}

//리스트 버튼 클릭시
function goList() {
	location.href= "${contextPath}/sampleList";
}

</script>


<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">등록 화면</h2></header>
	
	<form name="myForm" action="" method="post" class="form-horizontal">
	<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td width="20%"><label for="textId"><span class="redFont"> * </span> 일반 text </label></td>
			<td>
				<input type="text" class="form-control" id="textId" name="textName" value="" placeholder="입력해주세요.">
			</td>
		</tr>
		<tr>
			<td><label for="selectText"><span class="redFont"> * </span>select박스 </label></td>
			<td>
				<select class="form-control" name="" id="selectText" >
					<option value="">선택</option>
				</select>
			</td>
		</tr>
		<!-- label 없는경우, radio 박스는 버튼 클릭시에만 클릭이 됨 -->
		<tr>
			<td><label for="radioNolabel">label 없는경우, radio 박스</label></td>
			<td>
				<input type="radio" class="" name="radioNolabel" value="">  radio1 
				<input type="radio" class="" name="radioNolabel" value="">  radio2 
			</td>
		</tr>
		<!-- // label 없는경우, radio 박스는 버튼 클릭시에만 클릭이 됨 -->
		<!--  label 있는경우, radio label 안에 있는 것들 클릭 가능 for="radio아이디명시" -->
		<tr>
			<td><label for="radioId1"><span class="redFont"> * </span>radio 박스</label></td>
			<td>
				<label for="radioId1">
					<input type="radio" class="" id="radioId1" name="radioName" value="">  radio1 
				</label>
				<label for="radioId2">
					<input type="radio" class="" id="radioId2" name="radioName" value="">  radio2 
				</label>
			</td>
		</tr>
		<!--  // label 있는경우, radio label 안에 있는 것들 클릭 가능 for="radio아이디명시" -->
		<tr>
			<td><label for="checkbox1"><span class="redFont"> * </span>checkbox 박스</label></td>
			<td>
				<label for="checkbox1"><input type="checkbox" class="" id="checkbox1" name="checkboxName" value=""> checkbox1 </label>
				<label for="checkbox2"><input type="checkbox" class="" id="checkbox2" name="checkboxName" value=""> checkbox2 </label>
			</td>
		</tr>
		<!-- class 에 summernote 추가 -->
		<tr>
			<td><label for="summernoteText"><span class="redFont"> * </span> 설명</label></td>
			<td>
				<textarea rows="10" cols="3" id="summernoteText" class="form-control summernote" name=""></textarea>
			</td>
		</tr>
		<!-- // class 에 summernote 추가 -->
		<tr>
			<td colspan="2" align="center">
				<input type="submit" class="btn btn-primary" value="글쓰기" onclick="return inputSave()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			</td>
		</tr>
	</table>
	</form>
</div>  


<hr>

<!-- form:form 할경우 -->
<div class="marginPadding10">
	<h2 align="center">form:form 적용 등록 화면</h2>
	
	<form:form commandName="" name="myForm" action="" method="post" class="form-horizontal">
	<table border="1" class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
		<tr>
			<td width="20%"><label for="textId"><span class="redFont"> * </span> 일반 text </label></td>
			<td>
				<input type="text" class="form-control" id="textId" name="" value="" placeholder="입력해주세요.">
				<form:errors cssClass="errMessage" path="textName"/>
			</td>
		</tr>
		<tr>
			<td><label for="selectText"><span class="redFont"> * </span>select박스</label></td>
			<td>
				<select class="form-control" name="" id="selectText">
					<option value="">선택</option>
				</select>
				<form:errors cssClass="errMessage" path=""/>
			</td>
		</tr>
		<!-- label 없는경우, radio 박스는 버튼 클릭시에만 클릭이 됨 -->
		<tr>
			<td width="20%"><label for="">label 없는경우, radio 박스</label></td>
			<td>
				<input type="radio" class="" name="radioNolabel" value="">  radio1 
				<input type="radio" class="" name="radioNolabel" value="">  radio2 
			</td>
		</tr>
		<!-- // label 없는경우, radio 박스는 버튼 클릭시에만 클릭이 됨 -->
		<!--  label 있는경우, radio label 안에 있는 것들 클릭 가능 for="radio아이디명시" -->
		<tr>
			<td width="20%"><span class="redFont"> * </span>radio 박스</td>
			<td>
				<label for="radioId1">
					<input type="radio" class="" id="radioId1" name="radioName" value="">  radio1 
				</label>
				<label for="radioId2">
					<input type="radio" class="" id="radioId2" name="radioName" value="">  radio2 
				</label>
				
				<form:errors cssClass="errMessage" path="radioName"/>
			</td>
		</tr>
		<!--  // label 있는경우, radio label 안에 있는 것들 클릭 가능 for="radio아이디명시" -->
		<tr>
			<td width="20%"><label for="checkbox1"><span class="redFont"> * </span>checkbox 박스</label></td>
			<td>
				<label for="checkbox1">
					<input type="checkbox" class="" id="checkbox1" name="checkboxName" value=""> checkbox1 
				</label>
				<label for="checkbox2">
					<input type="checkbox" class="" id="checkbox2" name="checkboxName" value=""> checkbox2 
				</label>
				
				<form:errors cssClass="errMessage" path="checkboxName"/>
			</td>
		</tr>
		<tr>
			<td><label for=""> <span class="redFont"> * </span> 설명 </label></td>
			<td>
				<textarea rows="10" cols="3"  class="form-control summernote" name=""></textarea>
				<form:errors cssClass="errMessage" path=""/>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" class="btn btn-primary" value="글쓰기" onclick="return inputSave()">
				<input type="reset" class="btn btn-default" value="다시작성">
				<input type="button" class="btn btn-primary" value="목록보기" onclick="goList()">
			</td>
		</tr>
	</table>
	</form:form>
</div>
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>   