package user.introduction.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IntroductionController {

	public static final String COMMAND = "/introduction.do";
	public static final String GETPAGE = "user/introduction/developerIntroduction";
	
	@RequestMapping(value = COMMAND)
	public String sampleDeveloperIntroductionView() {
		return GETPAGE;
	}
	
}
