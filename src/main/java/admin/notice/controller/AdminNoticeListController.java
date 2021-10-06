package admin.notice.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import admin.notice.model.AdminNoticeBean;
import admin.notice.model.AdminNoticeDao;

@Controller
public class AdminNoticeListController {
	
	public static final String COMMAND = "/noticeList.ad";
	public static final String GETPAGE = "admin/notice/noticeList";
	
	@Autowired
	private AdminNoticeDao adminNoticeDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView adminNoticeyListView(HttpServletRequest request, @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		int totalCount = adminNoticeDao.getNoticeListTotalCnt(map);
	
		String pageUrl = request.getContextPath() + COMMAND; //페이지 URL
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<AdminNoticeBean> lists = adminNoticeDao.getNoticeList(pageInfo, map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		return mav;
	}
	
}
