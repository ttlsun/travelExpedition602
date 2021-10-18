package admin.users.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import user.users.model.UsersDao;

@Controller
public class AdminMainController {

	public static final String COMMAND = "/main.ad";
	public static final String GETPAGE = "admin/main";
	
	@Autowired
	private UsersDao usersDao;
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private TourDao tourDao;
	
	@Autowired
	private CommunityDao communityDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView mainListView(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//레코드 갯수
		Map<String, String> map = new HashMap<String, String>();
		int usersCount = usersDao.getTotalCount(map);
		int campingCount = campingDao.getTotalCount(map);
		int tourCount = tourDao.getTotalCount(map);
		int communityCount = communityDao.getCommunityListTotalCnt(map);
		
		//각각 3개씩 내려보내주기.
		List<CampingBean> campingLists = campingDao.getCampingMainList();
		List<TourBean> tourLists = tourDao.getTourMainList();
		List<CommunityBean> communityLists = communityDao.getCommunityMainList();
		
		mav.addObject("usersCount", usersCount);
		mav.addObject("campingCount", campingCount);
		mav.addObject("tourCount", tourCount);
		mav.addObject("communityCount", communityCount);
		mav.addObject("campingLists", campingLists);
		mav.addObject("tourLists", tourLists);
		mav.addObject("communityLists", communityLists);
		
		return mav;
	}
}
