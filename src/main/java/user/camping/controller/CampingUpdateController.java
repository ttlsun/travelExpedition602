package user.camping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingDao;

@Controller
public class CampingUpdateController {
	
	private static final String COMMAND = "/campingUpdate.do";
	private static final String GETPAGE = "user/camping/campingUpdateForm";
	private static final String GOTOPAGE = "redirect:/campingDetail.do";
	
	@Autowired
	private CampingDao campingDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView campingUpdateGet(ModelAndView mav) {
		
		
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView campingUpdatePost(ModelAndView mav) {
		
		
		mav.setViewName(GOTOPAGE);
		return mav;
	}
}
