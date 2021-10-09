package user.room.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.room.model.RoomDao;

@Controller
public class RoomDetailController {

	private static final String COMMAND = "/roomDetail.do";
	private static final String GETPAGE = "user/room/roomDetailView";
	
	@Autowired
	private RoomDao roomDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView roomDetailView(ModelAndView mav) {
		
		mav.setViewName(GETPAGE);
		return mav;
	}
}
