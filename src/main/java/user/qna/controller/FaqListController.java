package user.qna.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FaqListController {
	
	public static final String COMMAND = "/faqList.do";
	public static final String GETPAGE = "user/qna/faqList";
	
	/**
	 * 자주 묻는 질문
	 * @return
	 */
	@RequestMapping(value = COMMAND)
	public String faqListView() {
		return GETPAGE;
	}
	
}
