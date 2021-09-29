package admin.notice.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AdminNoticeListController {

	@RequestMapping(value = "/noticeList.ad", method = RequestMethod.GET)
    public String noticeAdminListView() {
        return "admin/notice/noticeList";
    }
	
}
