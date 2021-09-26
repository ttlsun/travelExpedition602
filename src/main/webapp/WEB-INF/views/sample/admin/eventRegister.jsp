<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="../../../common/admin/top.jsp" %> 

<script type="text/javascript">

$(document).ready(function() {
	
	navActive('event');
	
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

function regBtn() {
	
	if(!isInputNullChk("이벤트 시작날짜 ", 'event_startDate')){
		return false;
	}
	
	if(!isInputNullChk("이벤트 끝날날짜 ", 'event_endDate')){
		return false;
	}
	
	var eventStartDate = $('#eventStartDate').val().replaceAll('-', '');
	var eventEndDate = $('#eventEndDate').val().replaceAll('-', '');
	
	if(eventEndDate < eventStartDate){
		alert("죄송합니다. 이벤트 끝날날짜는 시작날짜보다 앞으로 선택하지말아주세요.");
		return false;
	}
	
}


</script>    
 
<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary"> 이벤트 등록 </h2></header>
	<form action="" id="myFrom" enctype="multipart/form-data" method="post" name="from" class="form-horizontal" role="form">
	
		<div class="form-group">
		<table class="table table-bordered">
		<caption> <span class="redFont"> * </span> 필수 입력 해주세요.</caption>
			<tr>
				<td><label for="title"><span class="redFont"> * </span>이벤트 제목 </label> </td>
				<td>
					<input type="text" class="form-control" name="title" id="title" class="form-control input-sm" placeholder="제목 입력.">
				</td>
			</tr>
			<tr>
				<td><label for="eventStartDate"><span class="redFont"> * </span>이벤트 시작 날짜 </label> </td>
				<td>
					<input type="date" class="form-control" name="eventStartDate" id="eventStartDate" class="form-control input-sm">
				</td>
			</tr>
			<tr>
				<td><label for="eventEndDate"><span class="redFont"> * </span>이벤트 끝낼 날짜 </label> </td>
				<td>
					<input type="date" class="form-control" name="eventEndDate" id="eventEndDate" class="form-control input-sm">
				</td>
			</tr>
			<tr>
				<td>
					<label for="content"><span class="redFont"> * </span>이벤트 내용</label>
				</td>
				<td>
					<textarea class="form-control summernote" rows="20" cols="20"  name="content" id="content" class="form-control "></textarea>
				</td>
			</tr>
			<tr>
				<td>
					<label for="imgUrl"><span class="redFont"> * </span>이벤트 이미지 URL</label>
				</td>
				<td>
					<input type="file" name="imgUrl" id="imgUrl">
				</td>
			</tr>
		</table>
		</div>
		<div class="marginPadding10" align="center">
			<input type="submit" class="btn btn-primary" value="등록하기" onclick="return regBtn()">
			<input type="reset" class="btn btn-primary" value="취소">
			<input type="button" class="btn btn-primary" value="목록">
		</div>
	</form>
</div>
</article>
</section>


<%@ include file="../../../common/admin/bottom.jsp" %>