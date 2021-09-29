package user.camping.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class CampingListController {

	private static final String COMMAND = "/campingList.do";
	private static final String GETPAGE = "user/camping/campingList";
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView campingListView(ModelAndView mav) {
		
		mav.setViewName(GETPAGE);
		return mav;
	}
}
