package user.pay.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingDao;
import user.pay.model.PayBean;
import user.pay.model.PayDao;
import user.users.model.UsersBean;

@Controller
public class PayReservationController {
	private static final String COMMAND = "/payReservation.do";
	private static final String SECONDCOMMAND = "/payReservationSecond.do";
	private static final String GETPAGE = "user/pay/payReserveForm"; //계좌이체, 카드결제, 휴대폰결제, 무통장입금
	private static final String GETPAGEELSE = "redirect:/main.do";
	
	@Autowired
	private PayDao payDao;
	
	@Autowired
	private CampingDao campingDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView doGet(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
		
		if(temp.getUcode().equals("customer")) {
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
			//System.out.println(campingRegid);
			if(campingRegid.substring(campingRegid.length()-2,campingRegid.length()).equals("id")) {
				campingRegid = campingRegid.substring(0, campingRegid.length()-2);
			}
			//System.out.println(campingRegid);
			
			//name, phone, email, requested, paycode
			String name = request.getParameter("name");
			String phone = request.getParameter("phone");
			String email = request.getParameter("email");
			String requested = request.getParameter("requested");
			String paycode = request.getParameter("paycode"); //계좌이체, 무통장입금, 카드결제, 휴대폰결제
			//System.out.println(name+" "+phone+" "+email+" "+requested+" "+paycode);
			
			Map<String, String> map = new HashMap<String, String>();
			map.put("cname", cname);
			map.put("totalprice", Integer.toString(totalprice));
			map.put("calDateDays", calDateDays);
			map.put("weekdayCount", Integer.toString(weekdayCount));
			map.put("weekendCout", Integer.toString(weekendCount));
			map.put("checkindate", checkindate);
			map.put("checkoutdate", checkoutdate);
			map.put("guests", Integer.toString(guests));
			map.put("weekdayprice", Integer.toString(weekdayprice));
			map.put("weekendprice", Integer.toString(weekendprice));
			map.put("cnum", Integer.toString(cnum));
			map.put("campingRegid", campingRegid);
			map.put("name", name);
			map.put("phone", phone);
			map.put("email", email);
			map.put("requested", requested);
			map.put("paycode", paycode);
			
			Map<String, String> forPaging = new HashMap<String, String>();
			forPaging.put("whatColumn", "paycode");
			forPaging.put("keyword", "%"+paycode+"%");
			
			if(paycode.equals("무통장입금")) {
				forPaging.put("id", campingRegid);
			} else {
				forPaging.put("id", temp.getId());
			}
			int totalCount = payDao.getTotalCount(forPaging);
			List<PayBean> lists = payDao.getListForReserve(forPaging);
			
			mav.addObject("map", map);
			mav.addObject("totalCount", totalCount);
			mav.addObject("lists", lists);
			mav.setViewName(GETPAGE);
		} else {
			mav.setViewName(GETPAGEELSE);
		}
		return mav;
	}
	
	@RequestMapping(value=SECONDCOMMAND, method=RequestMethod.POST)
	public void doPost(PrintWriter pw, HttpServletResponse response) throws IOException {
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		pw.println("<script>alert('결제 완료 ^^'); location.replace('main.do');</script>");
		pw.flush();
		
		return;
	}
}
