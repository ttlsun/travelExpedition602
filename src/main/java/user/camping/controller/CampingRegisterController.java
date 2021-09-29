package user.camping.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CampingRegisterController {
	
	private static final String COMMAND = "/campingRegister.do";
	private static final String GETPAGE = "user/camping/campingRegister";
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView campingListView(ModelAndView mav) {
		
		mav.setViewName(GETPAGE);
		return mav;
	}
}
