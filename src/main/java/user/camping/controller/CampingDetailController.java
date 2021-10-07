package user.camping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingDao;
import user.room.model.RoomDao;

@Controller
public class CampingDetailController {
	
	private static final String COMMAND = "/campingDetail.do";
	private static final String GETPAGE = "user/camping/campingDetailView";
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private RoomDao roomDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView campingDetail(ModelAndView mav) {
		
		
		mav.setViewName(GETPAGE);
		return mav;
	}
}
