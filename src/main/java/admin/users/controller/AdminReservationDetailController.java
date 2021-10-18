package admin.users.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.reservation.model.MyReservationBean;
import user.reservation.model.ReservationDao;

@Controller
public class AdminReservationDetailController {

	public static final String COMMAND = "/userReservationDetail.ad";
	public static final String GETPAGE = "admin/userInfo/userReservationDetailForm";
	public static final String GOTOPAGE =  "redirect:/userReservationDetail.ad";
	
	@Autowired
	private ReservationDao reservationDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView eventListView(HttpServletRequest request,
    								  @RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		MyReservationBean myReservation = reservationDao.getMyReservationDetail(map);
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("myReservation", myReservation);
		
		return mav;
	}
	
	// ajax 태우는게 좋긴하지만.. 이런 방식도 해봄.
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
    public ModelAndView doActionPost(ModelAndView mav,@RequestParam Map<String, Object> map) {
		try {
			
			System.out.println("map: num" + map.get("num") +
								", status:" + map.get("status") +
								", pageNumber:" + map.get("pageNumber"));
			
			reservationDao.updateReservationStatusChange(map);
			
			mav.addObject("pageNumber", map.get("pageNumber"));
			mav.addObject("num", map.get("num"));
			mav.setViewName(GOTOPAGE);

		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("내부오류");
		}
		return mav;
	}
}
