<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../common/top.jsp" %>   

<div class="marginPadding10">
	<div class="container" style="margin: auto;">
		<div>
			<h2><label class="text-primary"> 탐험대 샘플 메인 </label></h2>
		</div>
	
		<div>
			<span>반갑습니다. 같이 코딩 잘해보아요~!</span>

			<div>
				
				샘플 페이지 연결(샘플보기 - home ) <br>
				<br>--------------------------------------------------------
				
				
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
				
				<br><br>[에러페이지 보기 (401/402/403/404/500 에러 등 처리.-로그인으로 가야하는데 일단 예시를 위해 main으로 걸어놈.)]
				<br><a href="${contextPath}/sampleError"> 에러페이지 </a> 
				
				<br>--------------------------------------------------------
			</div>

		</div>
	</div>
</div>



<%@ include file="../common/bottom.jsp" %>