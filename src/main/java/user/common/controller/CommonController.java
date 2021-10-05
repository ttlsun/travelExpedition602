package user.common.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CommonController {
	
	@RequestMapping(value = "/agreement.do")
	public String agreementView() {
		return "user/common/agreement";
	}
	
	@RequestMapping(value = "/privacy.do")
	public String privacyView() {
		return "user/common/privacy";
	}
	
	@RequestMapping(value = "/geoLocationAgreement.do")
	public String geoLocationAgreementView() {
		return "user/common/geoLocationAgreement";
	}
	
}
