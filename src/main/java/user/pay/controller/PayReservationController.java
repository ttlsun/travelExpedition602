package user.pay.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingDao;
import user.pay.model.PayDao;

@Controller
public class PayReservationController {
	private static final String COMMAND = "/payReservation.do";
	private static final String COMMAND2 = "/payReservation2.do";
	private static final String GETPAGE = "user/pay/payReservationForm";
	
	@Autowired
	private PayDao payDao;
	
	@Autowired
	private CampingDao campingDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView doGet(ModelAndView mav, HttpServletRequest request) {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		//cname, totalprice, calDateDays, weekdayCount, weekendCount
		//map.checkindate, map.checkoutdate, map.guests
		//roombean.weekdayprice, roombean.weekendprice, roombean.regid
		String cname = request.getParameter("cname");
		int totalprice = Integer.parseInt(request.getParameter("totalprice"));
		String calDateDays = request.getParameter("calDateDays");
		int weekdayCount = Integer.parseInt(request.getParameter("weekdayCount"));
		int weekendCount = Integer.parseInt(request.getParameter("weekendCount"));
		//System.out.println(cname+" "+totalprice+" "+calDateDays+" "+weekdayCount+" "+weekendCount);
		
		String checkindate = request.getParameter("checkindate");
		String checkoutdate = request.getParameter("checkoutdate");
		int guests = Integer.parseInt(request.getParameter("guests"));
		//System.out.println(checkindate+" "+checkoutdate+" "+guests);
		
		int weekdayprice = Integer.parseInt(request.getParameter("weekdayprice"));
		int weekendprice = Integer.parseInt(request.getParameter("weekendprice"));
		int cnum = Integer.parseInt(request.getParameter("cnum")); //camping으로 접근해서 regid 가져옴
		//System.out.println(weekdayprice+" "+weekendprice+" "+cnum);
		
		String campingRegid = campingDao.getCampingRegid(cnum);
		if(campingRegid.substring(campingRegid.length()-2,campingRegid.length()).equals("id")) {
			campingRegid = campingRegid.replace("id", "");
		}
		
		//name, phone, email, requested, paycode
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String requested = request.getParameter("requested");
		String paycode = request.getParameter("paycode"); //계좌이체, 무통장입금, 카드결제, 휴대폰결제
		System.out.println(name+" "+phone+" "+email+" "+requested+" "+paycode);
		
		if(paycode.equals("계좌이체")) {
			//계좌이체 선택시 form에서 로그인한 사용자의 계좌 선택 후 결제하기
		} else if(paycode.equals("무통장입금")) {
			//무통장입금 선택시 선택한 캠핑장 등록한 사업자의 id로 무통장입금 계좌 선택 후
			//입금시간 안내(현재시간+12시간, 만약 당일이나 익일 예약건이면 +2시간) 후 결제하기 버튼
		} else if(paycode.equals("카드결제")) {
			//카드결제 선택시 form에서 로그인한 사용자의 카드 선택 후 결제하기'
		} else if(paycode.equals("휴대폰결제")) {
			//휴대폰결제 선택시 form으로 가지 않고 바로 post로 넘어감
		}
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND2, method=RequestMethod.POST)
	public void doPost() {
		return;
	}
}
