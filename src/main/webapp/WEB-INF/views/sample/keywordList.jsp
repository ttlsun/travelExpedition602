<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../common/top.jsp" %>   

<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	
});

</script>

<section class="container">
<article>
<div>
	<header><h2 align="center" class="text-primary">키워드 불러오기.</h2></header>
	
	<div class="form-group rounded">
		<form action="sampleCCTList" method="post">

			<div>
				<c:forEach items="${keywordLists}" var="keywordList">
					<input type="checkbox" value="${keywordList.tag}"> ${keywordList.tag}
				</c:forEach>
			</div>
		</form>
	</div>
	
   
</div>   
</article>
</section>
<%@ include file="../../common/bottom.jsp" %>