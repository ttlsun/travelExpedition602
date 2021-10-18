<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../../../common/top.jsp" %>   
<style type="text/css">
	th,td{
		text-align: center;
	}
</style>

<script type="text/javascript">
$(document).ready(function() {
	navActive('qna');
	
	//메타태그 설정.
	$("#metaTitle").attr("content", "자주 묻는 질문");
	$("#metaDescription").attr("content", "자주 묻는 질문");
	$("#metaKeywords").attr("content", "#여행자들602호 자주 묻는 질문");
});
</script>

<section class="container">
<article>
<div>
	<header>
		<div style="padding-bottom: 1%;">
			<img class="travelExpedition602" width="1140" src="${images}/faq.jpg" title="faq 이미지" alt="faq 이미지"/>
		</div>
	</header>
	
	<div class="marginPadding10">	
		<div>
			<div>
				<label class="text-primary textFontSizeLarge" > 자주 찾는 질문 Best 3  </label>
			</div>
			<div class="panel-group" id="accordion">
		        <div class="panel panel-default">
		          <div class="panel-heading">
		            <h4 class="panel-title">
		              <a data-toggle="collapse" data-parent="#accordion" href="#collapseOne">
		                	취소 수수료
		              </a>
		            </h4>
		          </div>
		          <div id="collapseOne" class="panel-collapse collapse in">
		            <div class="panel-body">
		            	<table class="table table-bordered">
		            		<caption>취소 수수료 안내</caption>
		            		<thead>
		            		<tr class="active">
		            			<th>취소기준</th>
		            			<th>취소수수료</th>
		            			<th>환불액</th>
		            		</tr>
		            		</thead>
		            		<tbody>
		            		<c:forEach var="i" begin="0" end="10">
		            		<tr>
		            			<td>
			            			<c:choose>
			            				<c:when test="${i == 0}">이용일 당일</c:when>
			            				<c:otherwise>이용일 ${i}일 전</c:otherwise>
			            			</c:choose>
		            			</td>
		            			<td>
		            				<c:choose>
			            				<c:when test="${i <= 3}">100%</c:when>
			            				<c:when test="${i <= 3 or i <= 5}"> 70%</c:when>
			            				<c:when test="${i <= 5 or i <= 7}"> 50%</c:when>
			            				<c:when test="${i <= 7 or i <= 8}"> 30%</c:when>
			            				<c:when test="${i <= 8 or i <= 9}"> 10%</c:when>
			            				<c:otherwise>0%</c:otherwise>
			            			</c:choose>
		            			</td>
		            			<td>
		            				<c:choose>
			            				<c:when test="${i == 0}">환불없음</c:when>
			            				<c:when test="${i <= 3}">20% 환불</c:when>
			            				<c:when test="${i <= 3 or i <= 5}"> 30% 환불</c:when>
			            				<c:when test="${i <= 5 or i <= 7}"> 50% 환불</c:when>
			            				<c:when test="${i <= 7 or i <= 8}"> 70% 환불</c:when>
			            				<c:when test="${i <= 8 or i <= 9}"> 90% 환불</c:when>
			            				<c:otherwise>100% 환불</c:otherwise>
			            			</c:choose>
								</td>
		            		</tr>
		            		</c:forEach>
		            		</tbody>
		            	</table>
		            	
		            	<ul>
		            		<li>취소 수수료는 위와 같습니다.</li>
		            		<li>예약취소는 전화 문의 바랍니다.</li>
		            		<li>우천으로 인한 환불 및 날짜 변경 불가합니다.</li>
		            		
		            		<li>천재지변 또는 기상악화 시, 현장(캠핑장/펜션)상황과 정책에 따라 당일 오전 현장 판단하에 연기 또는 취소 결정됩니다.</li>
							<li>코로나 등 전염병 관련 예약 취소는 병원/행정기관 등 유관기관에서 발급한 '예약자 본인 확인 가능한 증빙 서류 제출 시' 업체와 협의 후 가능합니다.</li>
							<li>사전 협의 없이 예약자가 직접 예약 취소 시 환불 규정에 따라 환불되며, 결제업체(결제수단)의 정책에 따라 취소수수료 환불이 불가할 수 있습니다.</li>
							<li>취소 시 결제금액에서 취소수수료를 제외한 금액이 환불되며, 취소수수료는 총 결제금액 기준으로 책정됩니다.</li>
							<li>취소 신청 후 간편결제 사업자 또는 은행/신용카드사에 따라 환불 절차에 일정 시간이 소요됩니다.</li>
							<li>영업일 기준(토/일/공휴일 제외)으로 실시간 계좌이체 2~3일, 신용카드 3~5일 소요됩니다.</li>
		            		<li>여행자들602호(주)는 중개플랫폼사로, 현장에서 발생된 숙박업체와의 분쟁으로 인한 취소 및 환불에 관여하지 않습니다.</li>
		            	</ul>
		            </div>
		          </div>
		        </div>
		        <div class="panel panel-default">
		          <div class="panel-heading">
		            <h4 class="panel-title">
		              <a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">
		               		문의 페이지 관련 질문
		              </a>
		            </h4>
		          </div>
		          <div id="collapseTwo" class="panel-collapse collapse">
		            <div class="panel-body">
		             	1:1 문의 게시판에 글을 올려서 물어봅니다.
		          	</div>
		          </div>
		        </div>
		        <div class="panel panel-default">
		          <div class="panel-heading">
		            <h4 class="panel-title">
		              <a data-toggle="collapse" data-parent="#accordion" href="#collapseThree">
		                관광지는 어디서보나요?
		              </a>
		            </h4>
		          </div>
		          <div id="collapseThree" class="panel-collapse collapse">
		            <div class="panel-body">
						캠핑/글램핑 하위 메뉴에 관광지 메뉴가 있습니다.
					</div>
		          </div>
		        </div>
			</div>
		</div>
		
		<div class="marginPadding10">
			<input type="button" class="btn btn-primary" value="문의 리스트" onclick="location.href='qnaList.do'">
		</div>
	</div>
	
</div>   
</article>
</section>
<%@ include file="../../../common/bottom.jsp" %>