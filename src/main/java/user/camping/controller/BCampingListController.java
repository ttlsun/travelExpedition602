package user.camping.controller;

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

import user.camping.model.CampingBean;
import user.camping.model.CampingDao;
import user.users.model.UsersBean;

@Controller
public class BCampingListController {

	private static final String COMMAND = "/bCampingList.do";
	private static final String GETPAGE = "user/camping/bCampingList";
	
	@Autowired
	private CampingDao campingDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView campingList(ModelAndView mav,
							HttpSession session,
							@RequestParam Map<String, String> map,
							HttpServletRequest request) {
		
		//노출만 리스트업
		map.put("status", "01");
		
		//세션 아이디 얻어오기.
		UsersBean loginInfo = (UsersBean)session.getAttribute("loginInfo");
		String regid = loginInfo == null ? "" :  loginInfo.getId();
		
		//본인 id로 등록한 캠핑장만 리스트업
		map.put("regid", regid);
		
		//게시글 수
		int totalCount = campingDao.getTotalCount(map);
		
		//캠핑장 리스트 불러오기
		String pageUrl = request.getContextPath()+ COMMAND;
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<CampingBean> lists = campingDao.getCampingList(pageInfo,map);
		//System.out.println("lists:" + lists.size());
		
		System.out.println("-----------------------------------------------------");
		System.out.println("totalCount:::::::::::: " + totalCount);
		System.out.println("pageInfo :::::::::::: "+ pageInfo.getPageNumber());
		System.out.println("lists :::::::::::::" + lists.size());
		System.out.println("-----------------------------------------------------");
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		mav.setViewName(GETPAGE);
		return mav;
	}
	
}
