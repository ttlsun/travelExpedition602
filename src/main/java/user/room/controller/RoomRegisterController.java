package user.room.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.room.model.RoomDao;


@Controller
public class RoomRegisterController {

	private static final String COMMAND = "/roomRegister.do";
	private static final String GETPAGE = "user/room/roomRegister";
	private static final String GOTOPAGE = "redirect:/campingDetail.do";
	
	@Autowired
	private RoomDao roomDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView roomRegisterGet(ModelAndView mav) {
		
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView roomRegisterPost(ModelAndView mav) {
		
		mav.setViewName(GOTOPAGE);
		return mav;
	}
}
