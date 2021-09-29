package user.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class NoticeListController {
	
	@RequestMapping(value = "/noticeList.do", method = RequestMethod.GET)
    public String noticeListView() {
        return "user/notice/noticeList";
    }
	
}
