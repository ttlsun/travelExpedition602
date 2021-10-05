package user.community.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.community.model.CommunityDao;

@Controller
public class CommunityDeleteController {

	public static final String COMMAND = "/communityDelete.do";
	public static final String GOTOPAGE = "redirect:/communityList.do";
	
	@Autowired
	private CommunityDao communityDao;
	
	@RequestMapping(value = COMMAND)
	public ModelAndView doAction(@RequestParam Map<String, Object> map) {
		ModelAndView mav = new ModelAndView(GOTOPAGE);
		
		//노출값 02로 변경.(삭제 말고, 숨킴으로 .. 관리자만 삭제 가능하도록 처리할거임.)
		map.put("status", "02");
		communityDao.updateCommunityStatusChange(map);
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("type", map.get("type"));
		mav.addObject("regid", map.get("regid"));
		
		return mav;
	}
	
	
}
