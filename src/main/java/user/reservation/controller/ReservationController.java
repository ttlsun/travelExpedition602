package user.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.reservation.model.ReservationDao;
import user.room.model.RoomDao;

@Controller
public class ReservationController {
	
	private static final String COMMAND = "/reservation.do";
	private static final String GETPAGE = "user/reservation/reservationForm";
	private static final String GOTOPAGE = "redirect:/어디로갈까요.do";
	
	@Autowired
	private RoomDao roomDao;
	
	@Autowired
	private ReservationDao reservationDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView reservationGet(ModelAndView mav,
								@RequestParam("num") String room_num) {
		
		mav.addObject("room_num", room_num);
		mav.setViewName(GETPAGE);
		return mav;
	}
}
