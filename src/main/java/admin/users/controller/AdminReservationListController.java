package admin.users.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.reservation.model.MyReservationBean;
import user.reservation.model.ReservationDao;

@Controller
public class AdminReservationListController {
	public static final String COMMAND = "/userReservationList.ad";
	public static final String GETPAGE = "admin/userInfo/userReservationList";
	
	@Autowired
	private ReservationDao reservationDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView eventListView(HttpServletRequest request, HttpSession session,
    								  @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		int totalCount = reservationDao.getMyReservationListTotalCnt(map);
	
		String pageUrl = request.getContextPath() + COMMAND; //페이지 URL
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		//bean 명칭을 잘못만들었네요 ㅠ.ㅠ. 그래도 같이 얻어오는게 좋으니깐 추후 변경해도되고..일단 진행합니다..
		List<MyReservationBean> lists = reservationDao.getMyReservationList(pageInfo, map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		return mav;
	}
}
