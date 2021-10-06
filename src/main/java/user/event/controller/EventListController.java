package user.event.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import admin.event.model.AdminEventBean;
import admin.event.model.AdminEventDao;

@Controller
public class EventListController {

	public static final String COMMAND = "/eventList.do";
	public static final String GETPAGE = "user/event/eventList";
	
	@Autowired
	private AdminEventDao adminEventDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView eventListView(HttpServletRequest request, @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		map.put("type", "01"); //01:진행중인 이벤트, 02:종료된 이벤트
		int totalCount = adminEventDao.getEventListTotalCnt(map);
	
		String pageUrl = request.getContextPath() + COMMAND; //페이지 URL
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<AdminEventBean> lists = adminEventDao.getEventList(pageInfo, map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		return mav;
	}
	
}
