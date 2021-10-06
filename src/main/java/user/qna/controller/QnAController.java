package user.qna.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QnAController {
	
	/**
	 * 자주 묻는 질문
	 * @return
	 */
	@RequestMapping(value = "/qnaList.do")
	public String qnaListView() {
		return "user/qna/qnaList";
	}
	
}
