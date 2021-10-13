<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/top.jsp" %>   

<div class="marginPadding10">
	<div class="container" style="margin: auto;">
		<div>
			<h2><label class="text-primary"> 탐험대 샘플 메인 </label></h2>
		</div>
	
		<div>
			<span>반갑습니다. 같이 코딩 잘해보아요~!(이건 예제페이지라 br을 엄청썻지만.. br를 가능하면 안쓰도록하는게 좋을 것 같아요.)</span>

			<div>
						
				<br>--------------------------------------------------------------------------------------------------------------------------------------------------------------
				
				<br><br>[css, js참고하셔야할 부분 : 공통으로 사용 모아놓은 jsp 파일은 : css_script_js.jsp]  
				<br>css 랑 js 라이브러리 버전이 썸머노트랑 안맞아서 ..  
				<br>css,js을 넣어놓긴했지만.. css, js 사용안하는것들이 있습니다.
				<br>(선생님께서 공유해주신거니깐.. 추후 지워도 되지만, 혹시 몰라 일단 둠.)
				<br>
				<br><br>[css 폴더]
				<br>- style.css : 사용안함
				<br>- bootstrap.css : 사용안함
				<br>- jquery-ui.css : 사용안함
				<br>- custom2.css : 사용안함
				<br>
				<br><br>[사용중]
				<br>- kfonts2.css : 사용중
				<br>- common.css : 사용중(우리가 css 공통으로 쓸것들 모아놓음. 여기다가 추가 및 따로 만드셔서 css+script+js.jsp 추가하셔도되요.)
				<br>- mapview-1.0.0.css : 사용중 (지도관련 마커css)
				
				
				<br><br>[js 폴더]
				<br>- bootstrap.js : 사용안함
				<br>- bootstrap.min.js : 사용안함
				<br>- jquery.imagezoom.js : 사용안함(사용하실분은 추가 하셔도됨. 다만 다른 페이지도 테스트 부탁.)
				<br>- jquery.js : 사용안함
				<br>- jquery.magnify-1.0.2 : 사용안함(사용하실분은 추가 하셔도됨. 다만 다른 페이지도 테스트 부탁.)
				<br>- jquery.rotator.js : 사용안함(사용하실분은 추가 하셔도됨. 다만 다른 페이지도 테스트 부탁.)
				<br>- jquery-1.11.3.js : 사용안함
				<br>- jquery-1.11.3.min.js : 사용안함
				<br>- jquery-ui-1.8.16.custom.min.js : 사용안함
				<br><br>
				<br>[사용중]
				<br>- common.js : 사용중 (우리가 공통으로 쓸것들 모아놓음. 여기다가 추가 및 따로 만들어도 됨.)
				<br>- mapview-1.0.0.js : 지도, 주소관련 모아놓은 js (지도,주소 자세히 알고 싶으면 여기 참고부탁)
				
				<br>--------------------------------------------------------------------------------------------------------------------------------------------------------------
				<br><br>
				샘플 페이지 연결(샘플보기 - home ) <br>
				<br>--------------------------------------------------------------------------------------------------------------------------------------------------------------
				<br><br><br><br>
				
				<span> 관리자 : 메인(<a href="main.ad">관리자 - 메인</a>) </span>
				<br>
				<span> 회원 : 메인(<a href="main.do">회원 - 메인</a>) </span>
				<br><br>
				
				<br><br>[기본샘플(공통) - 파일업로드]
				<br><a href="${contextPath}/sampleFileUpload">파일업로드 페이지(1개, 여러개 둘다)</a>
				
				<br><br>[기본샘플(공통) - 키워드리스트]
				<br><a href="${contextPath}/sampleKeywordList">키워드 리스트</a>
				
				<br><br>[기본샘플(공통) - 달력예제]
				<br><a href="${contextPath}/sampleDatepicker">제이쿼리 UI 달력</a>
				
				<br><br>[기본샘플(공통) - 지도/주소]
				<br><a href="${contextPath}/mapRegister">지도/주소관련 샘플</a>
				
				<br><br>[기본샘플 - 리스트/상세/등록]
				<!-- 추후 기본 리스트 만들 것들이 생길시 사용 -->
				<br><a href="${contextPath}/sampleList">기본 리스트 페이지</a>
				<br><a href="${contextPath}/sampleDetail">기본 상세용 페이지</a>
				<br><a href="${contextPath}/sampleInsert">기본 등록 페이지</a>
				<br><a href="${contextPath}/sampleCCTList">캠핑/관광지/후기 리스트 샘플 페이지</a>
				<!-- //추후 기본 리스트 만들 것들이 생길시 사용 -->
				
				
				<br><br>[로그인/회원가입용]
				<br><a href="${contextPath}/sampleLogin">로그인용 페이지</a>
				<br><a href="${contextPath}/sampleMemberRegister">회원가입 페이지</a>
				<br><a href="${contextPath}/sampleFindId">아이디찾기 페이지</a>
				<br><a href="${contextPath}/sampleFindPwd">비밀번호찾기 페이지</a>
				
				<br><br>[관리자 - top달린 기본 리스트]
				<br><a href="${contextPath}/sampleAdminList">관리자용 리스트 예시용 페이지 </a>
				<br><a href="${contextPath}/sampleAdminEventList">관리자용 이벤트 리스트 페이지 </a>
				<br><a href="${contextPath}/sampleAdminEventRegister">관리자용 이벤트 등록 페이지</a>
				
				<br><br>[회원 - 여행자들 소개]
				<br><a href="${contextPath}/sampleIntroduction"> 여행자들 소개 페이지</a>
				
				<br><br>[회원 - 캠핑/글램핑 리스트/상세/등록]
				<br><a href="${contextPath}/sampleCampingList"> 캠핑/글램핑 리스트 페이지</a>
				<br><a href="${contextPath}/sampleCampingDetail"> 캠핑/글램핑 상세 페이지</a>
				
				<br><br>[사업자 회원 - 캠핑/글램핑 등록]
				<br><a href="${contextPath}/sampleCampingRegister"> 캠핑/글램핑 등록 페이지</a>
				<br><a href="${contextPath}/sampleCampingRoomRegister"> 캠핑/글램핑 객실 등록 페이지</a>
				
				
				<br><br>[회원 - 관광지리스트/상세/등록]
				<br><a href="${contextPath}/sampleTourismList"> 관광지 리스트 페이지</a>
				<br><a href="${contextPath}/sampleTourismDetail"> 관광지 상세 페이지</a>
				
				<br><br>[사업자 회원 - 관광지리스트 등록]
				<br><a href="${contextPath}/sampleTourismRegister"> 관광지 등록 페이지</a>
				
				<br><br>[회원 - 후기리스트/상세/등록]
				<br><a href="${contextPath}/sampleCommunityList"> 후기리스트 페이지</a>
				<br><a href="${contextPath}/sampleCommunityDetail"> 후기상세 페이지</a>
				<br><a href="${contextPath}/sampleCommunityRegister"> 후기등록 페이지</a>
				
				<br><br>[회원 - 이벤트 리스트]
				<br><a href="${contextPath}/sampleEventList">회원용 이벤트리스트 페이지</a>
				
				
				<br><br>[회원 - 공지사항 리스트]
				<br><a href="${contextPath}/sampleNoticeList"> 회원용 공지사항 리스트 페이지</a>
				<br><a href="${contextPath}/sampleNoticeDetail">회원용 공지사항 상세용 페이지</a>
				
				<br><br>[회원 - Q&amp;A 리스트]
				<br><a href="${contextPath}/sampleQnaList"> Q&amp;A 페이지</a>
				<br><a href="${contextPath}/sampleQuestionList"> 문의리스트 페이지</a>
				
				<br><br>[회원 - 예약]
				<br><a href="${contextPath}/sampleCartList"> 찜목록 페이지</a>
				<br><a href="${contextPath}/sampleReservationList"> 예약리스트 페이지</a>
				<br><a href="${contextPath}/sampleReservationRegister"> 예약등록 페이지</a>
				
				<br><br>[회원 - 내정보관리]
				<br><a href="${contextPath}/samplePwdChage"> 비밀번호 변경 페이지</a>
				<br><a href="${contextPath}/sampleMembersInfo"> 내정보 변경 페이지</a>
				
				
				<br><br>[bottom -이용약관]
				<br><a href="${contextPath}/sampleAgreement"> 이용약관</a>
				<br><a href="${contextPath}/samplePrivacy"> 개인정보 처리방침</a>
				<br><a href="${contextPath}/sampleGeoLocationAgreement"> 위치기반 서비스 이용약관</a>
				
				<br><br>[에러페이지 보기 (401/402/403/404/500 에러 등 처리.]
				<br><a href="${contextPath}/sampleError"> 에러페이지 </a> 
				
				<br>--------------------------------------------------------------------------------------------------------------------------------------------------------------
				
			</div>

		</div>
	</div>
</div>



<%@ include file="../common/bottom.jsp" %>