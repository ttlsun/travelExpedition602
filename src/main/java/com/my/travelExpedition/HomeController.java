package com.my.travelExpedition;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.my.travelExpedition.utility.MessageUtil;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main() {
		logger.info("메인 화면입니다");
		
		logger.info("message:" + MessageUtil.getMessage("error.isNull"));
		
		return "main";
	}
	
}
