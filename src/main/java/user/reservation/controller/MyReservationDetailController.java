package user.reservation.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.reservation.model.MyReservationBean;
import user.reservation.model.ReservationDao;
import user.users.model.UsersBean;

@Controller
public class MyReservationDetailController {

	public static final String COMMAND = "/myReservationDetail.do";
	public static final String GETPAGE = "user/myInfo/myReservationDetailForm";
	
	@Autowired
	private ReservationDao reservationDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView eventListView(HttpServletRequest request, HttpSession session,
    								  @RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//세션 아이디 얻어오기.
		UsersBean loginInfo = (UsersBean)session.getAttribute("loginInfo");
		String userId = loginInfo == null ? "" :  loginInfo.getId();
		
		map.put("id", userId);
		MyReservationBean myReservation = reservationDao.getMyReservationDetail(map);
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("myReservation", myReservation);
		
		return mav;
	}
	
}
