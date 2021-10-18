package user.users.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingBean;
import user.camping.model.CampingDao;
import user.community.model.CommunityBean;
import user.community.model.CommunityDao;
import user.tour.model.TourBean;
import user.tour.model.TourDao;

@Controller
public class MainController {

	public static final String COMMAND = "/main.do";
	public static final String GETPAGE = "user/main";
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private TourDao tourDao;
	
	@Autowired
	private CommunityDao communityDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView mainListView(HttpServletRequest request) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//각각 3개씩 내려보내주기.
		List<CampingBean> campingLists = campingDao.getCampingMainList();
		List<TourBean> tourLists = tourDao.getTourMainList();
		List<CommunityBean> communityLists = communityDao.getCommunityMainList();
		
		mav.addObject("campingLists", campingLists);
		mav.addObject("tourLists", tourLists);
		mav.addObject("communityLists", communityLists);
		
		return mav;
	}
}
