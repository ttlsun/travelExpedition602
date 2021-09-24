package com.my.travelExpedition;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main() {
        logger.info("메인 화면입니다"); //아직 로그는 쌓진 않음..
        return "main";
    }
    
    /**
     * 샘플 데이터들 View.
     * @return
     */
    
    @RequestMapping(value = "/sampleList")
	public String samplelistView() {
		return "sample/list";
	}
    
    @RequestMapping(value = "/sampleAdminList")
  	public String sampleAdminListView() {
  		return "sample/adminList";
  	}

	@RequestMapping(value = "/sampleDetail")
	public String sampleDetailFormView() {
		return "sample/detailForm";
	}
    
	@RequestMapping(value = "/sampleInsert")
	public String sampleInsertView() {
		return "sample/insertForm";
	}
	
	@RequestMapping(value = "/sampleLogin")
	public String sampleLoginView() {
		return "sample/login";
	}
	
	@RequestMapping(value = "/sampleMemberRegister")
	public String sampleMemberRegisterView() {
		return "sample/memberRegister";
	}
	
	@RequestMapping(value = "/sampleNoticeList")
  	public String sampleNoticeListView() {
  		return "sample/noticeList";
  	}

	@RequestMapping(value = "/sampleNoticeDetail")
	public String sampleNoticeDetailView() {
		return "sample/noticeDetail";
	}
	
	
	@RequestMapping(value = "/sampleQuestionList")
  	public String sampleQuestionListView() {
  		return "sample/questionList";
  	}
	
	@RequestMapping(value = "/sampleIntroduction")
	public String sampleDeveloperIntroductionView() {
		return "sample/developerIntroduction";
	}
	
	@RequestMapping(value = "/sampleQnaList")
	public String sampleQnaListView() {
		return "sample/qnaList";
	}
	
	@RequestMapping(value = "/sampleCartList")
	public String samplecartListView() {
		return "sample/cartList";
	}
	
	@RequestMapping(value = "/sampleReservationList")
	public String sampleReservationListView() {
		return "sample/reservationList";
	}
	

	@RequestMapping(value = "/samplePwdChage")
	public String samplePwdChageView() {
		return "sample/pwdChage";
	}
	
	@RequestMapping(value = "/sampleAgreement")
	public String sampleAgreementView() {
		return "sample/agreement";
	}
	
	@RequestMapping(value = "/samplePrivacy")
	public String samplePrivacyView() {
		return "sample/privacy";
	}
	
	@RequestMapping(value = "/sampleGeoLocationAgreement")
	public String sampleGeoLocationAgreementView() {
		return "sample/geoLocationAgreement";
	}
	
	@RequestMapping(value = "/sampleCommunityList")
	public String sampleCommunityListView() {
		return "sample/communityList";
	}
	
	@RequestMapping(value = "/sampleCommunityRegister")
	public String sampleCommunityRegisterView() {
		return "sample/communityRegister";
	}
	
	@RequestMapping(value = "/sampleCommunityDetail")
	public String sampleCommunityDetailView() {
		return "sample/communityDetail";
	}
	
	@RequestMapping(value = "/sampleFindId")
	public String sampleFindIdView() {
		return "sample/findId";
	}
	
	@RequestMapping(value = "/sampleFindPwd")
	public String sampleFindPwdView() {
		return "sample/findPwd";
	}
	
	@RequestMapping(value = "/sampleMembersInfo")
	public String sampleMembersInfoView() {
		return "sample/membersInfo";
	}
	

}
