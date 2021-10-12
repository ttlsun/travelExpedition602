package user.like.controller;

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

import user.like.model.LikeBean;
import user.like.model.LikeDao;
import user.users.model.UsersBean;

@Controller
public class LikesListController {

	public static final String COMMAND = "/myLikesList.do";
	public static final String GETPAGE = "user/myInfo/myLikesList";
	
	@Autowired
	private LikeDao likeDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView eventListView(HttpServletRequest request, HttpSession session,
    								  @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//세션 아이디 얻어오기.
		UsersBean loginInfo = (UsersBean)session.getAttribute("loginInfo");
		String userId = loginInfo == null ? "" :  loginInfo.getId();
		
		map.put("id", userId);
		int totalCount = likeDao.getAllLikesListTotalCnt(map);
	
		String pageUrl = request.getContextPath() + COMMAND; //페이지 URL
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<LikeBean> lists = likeDao.getAllLikesList(pageInfo, map);
		
		System.out.println("lists:" + lists.toString());
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		return mav;
	}
	
}
