package admin.community.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.community.model.CommunityRatingBean;
import user.rating.model.RatingDao;

@Controller
public class AdminCommunityRatingListController {

	public static final String COMMAND = "/communityRatingList.ad";
	public static final String GETPAGE = "admin/community/communityRatingList";
	
	@Autowired
	private RatingDao ratingDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView adminCommunityListView(HttpServletRequest request, @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		List<CommunityRatingBean> lists = ratingDao.getcommunityRatingSum();
		
		mav.addObject("lists", lists);
		
		return mav;
	}
	
	
}
