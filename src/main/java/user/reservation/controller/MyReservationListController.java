package user.reservation.controller;

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
import user.users.model.UsersBean;

@Controller
public class MyReservationListController {

	public static final String COMMAND = "/myReservationList.do";
	public static final String GETPAGE = "user/myInfo/myReservationList";
	
	@Autowired
	private ReservationDao reservationDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView eventListView(HttpServletRequest request, HttpSession session,
    								  @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//세션 아이디 얻어오기.
		UsersBean loginInfo = (UsersBean)session.getAttribute("loginInfo");
		String userId = loginInfo == null ? "" :  loginInfo.getId();
		
		//map.put("id", userId);
		map.put("id", "customer01");
		int totalCount = reservationDao.getMyReservationListTotalCnt(map);
	
		String pageUrl = request.getContextPath() + COMMAND; //페이지 URL
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<MyReservationBean> lists = reservationDao.getMyReservationList(pageInfo, map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		return mav;
	}
	
}
