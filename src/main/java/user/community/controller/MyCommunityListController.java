package user.community.controller;

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

import user.community.model.CommunityBean;
import user.community.model.CommunityDao;
import user.users.model.UsersBean;

@Controller
public class MyCommunityListController {

	public static final String COMMAND = "/myCommunityList.do";
	public static final String GETPAGE = "user/community/myCommunityList";
	
	@Autowired
	private CommunityDao communityDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView communityListView(HttpServletRequest request, HttpSession session,
    									 @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//세션 아이디 얻어오기.
		UsersBean loginInfo = (UsersBean)session.getAttribute("loginInfo");
		String regid = loginInfo == null ? "" :  loginInfo.getId();
		
		map.put("regid", regid); //내예약 후기 리뷰.
		map.put("status", "01"); //노출만 리스트 뿌리기.
		
		int totalCount = communityDao.getCommunityListTotalCnt(map);
	
		String pageUrl = request.getContextPath()+ COMMAND; //페이지 URL
		
		//
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<CommunityBean> lists = communityDao.getCommunityList(pageInfo, map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		return mav;
	}
	
}
