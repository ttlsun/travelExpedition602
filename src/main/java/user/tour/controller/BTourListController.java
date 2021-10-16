package user.tour.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.common.model.KeywordBean;
import user.common.model.KeywordDao;
import user.tour.model.TourBean;
import user.tour.model.TourDao;
import user.users.model.UsersBean;

@Controller
public class BTourListController {

	private static final String COMMAND = "/bTourList.do";
	private static final String GETPAGE = "user/tour/bTourList";
	
	@Autowired
	private TourDao tourDao;

	@Autowired
	private KeywordDao keywordDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView tourListView(ModelAndView mav,
									HttpSession session,
									@RequestParam Map<String,String> map,
									HttpServletRequest request) {
		
		//노출만 보여주기.
		map.put("status", "01");	
		
		
		//세션 아이디 얻어오기.
		UsersBean loginInfo = (UsersBean)session.getAttribute("loginInfo");
		String regid = loginInfo == null ? "" :  loginInfo.getId();
				
		//본인 id로 등록한 캠핑장만 리스트업
		map.put("regid", regid);
				
			
		
		int totalCount = tourDao.getTotalCount(map);
		String pageUrl = request.getContextPath() + COMMAND;
		Paging pageInfo = new Paging(map,"10",totalCount, pageUrl);		
		List<TourBean> lists = tourDao.getTourList(pageInfo,map);
		
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		mav.setViewName(GETPAGE);
		return mav;
	}
}
	