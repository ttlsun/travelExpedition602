<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">

//키워드 선택 여부 체크
function keywordChk(index) {
	
	//값 확인(값을 따로 내려주고싶을때 사용해도 됨.)
	var regkeywordIndex = $('#regkeyword_'+index).val();
	//alert(regkeywordIndex);
	//alert($('#regkeyword_'+index).is(':checked')); //내가 선택했는지 여부 체크.
	
	//키워드가 체크되어있으면 색변경
	if($('#regkeyword_'+index).is(':checked') == true){
		$('#labelKegkeyword_'+index).css("color","#15b15a"); //변경색
	}else{
		$('#labelKegkeyword_'+index).css("color","#337ab7");
	}
}


</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">키워드 불러오기.</h2></header>
	
	<div class="form-group rounded">
		<form action="sampleCCTList" method="post">

			<div>
				<br>
				<span>검색 관련 예제</span>
				<br>
				<br>
				<c:forEach items="${keywordLists}" var="keywordList" varStatus="status">
					<label for="regkeyword_${status.index}" id="labelKegkeyword_${status.index}" style="color: #337ab7;">
						&nbsp;
						<input type="checkbox" name="regkeyword" id="regkeyword_${status.index}" value="${keywordList.tag}" style="display:none;" onclick="keywordChk(${status.index})"> ${keywordList.tag}
					</label>
				</c:forEach>
				
				<br><br>
				<span>등록 관련 예제</span>
				<br><br>
				<c:forEach items="${keywordLists}" var="keywordList" varStatus="status">
					<label for="regkeywords_${status.index}" style="color: #337ab7;">
						&nbsp;
						<input type="checkbox" name="regkeywords" id="regkeywords_${status.index}" value="${keywordList.tag}"> ${keywordList.tag}
					</label>
				</c:forEach>
				
			</div>
		</form>
	</div>
	
   
</div>   
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>