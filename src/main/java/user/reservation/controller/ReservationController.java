package user.reservation.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.reservation.model.ReservationDao;
import user.room.model.RoomBean;
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
								@RequestParam("num") String rnum,
								@RequestParam("pageNumber") String pageNumber,
								@RequestParam("cname") String cname,
								@RequestParam Map<String, String> map) {
		
		map.put("checkindate", map.get("checkindate"));
		map.put("checkoutdate", map.get("checkoutdate"));
		map.put("guests", map.get("guests"));
		
		//캠핑장 번호, 객실 번호/이름/타입, 주중/주말가격, 기준인원 가져옴
		RoomBean roombean = roomDao.getRoomReserveInfo(rnum); 
		
		//입,퇴실일 사이 숙박일수 구하기
		try{ 
			SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
	        
			// date1, date2 두 날짜를 parse()를 통해 Date형으로 변환합니다
			Date FirstDate = format.parse(map.get("checkindate"));
			Date SecondDate = format.parse(map.get("checkoutdate"));
	        
			// Date로 변환된 두 날짜를 계산한 뒤 그 리턴값으로 long type 변수를 초기화합니다
			long calDate = FirstDate.getTime() - SecondDate.getTime(); 
	        
			// Date.getTime() 은 해당날짜를 기준으로 몇 초가 흘렀는지를 반환해줍니다 
			// 이제 24*60*60*1000(각 시간값에 따른 차이점) 을 나눠주면 일수가 나옵니다
			long calDateDays = calDate / (24*60*60*1000); 
	 
			calDateDays = Math.abs(calDateDays);
	        
			System.out.println("숙박일수: "+calDateDays+" 일");
			
			//주중, 주말 나눠서 숙박일수 구하기
			int weekdayCount=0, weekendCount=0;
			//System.out.println("첫날 요일:"+FirstDate.getDay());
			
			for(int i=0; i<=calDateDays-1; i++) {
				if((FirstDate.getDay()+i) == 5 || (FirstDate.getDay()+i) == 6) {
					weekendCount += 1;
				}
				else {
					weekdayCount += 1;
				}
			}
			
			System.out.println("주중숙박일:"+weekdayCount);
			System.out.println("주말숙박일:"+weekendCount);
			
			//총 결제금액 구하기
			int totalprice = (weekdayCount*roombean.getWeekdayprice())+(weekendCount*roombean.getWeekendprice());
			
			mav.addObject("calDateDays", calDateDays);
			mav.addObject("weekdayCount", weekdayCount);
			mav.addObject("weekendCount", weekendCount);
			mav.addObject("totalprice", totalprice);
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		//사용자 아이디(ID) mav로 가져가기
		mav.addObject("loginId", "loginId");
		
		
		mav.addObject("map", map);
		mav.addObject("roombean", roombean);
		mav.addObject("cname", cname); //캠핑장 이름
		mav.addObject("rnum", rnum);
		mav.addObject("pageNumber", pageNumber);
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView reservationPost(ModelAndView mav,
								@RequestParam("num") String rnum,
								@RequestParam("pageNumber") String pageNumber) {
		
		
		
		
		mav.addObject("rnum", rnum);
		mav.addObject("pageNumber", pageNumber);
		mav.setViewName(GOTOPAGE);
		return mav;
	}
}