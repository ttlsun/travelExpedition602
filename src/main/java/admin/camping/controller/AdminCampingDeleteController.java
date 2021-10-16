package admin.camping.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingDao;
import user.room.model.RoomDao;

@Controller
public class AdminCampingDeleteController {

	private static final String COMMAND = "/campingDelete.ad";
	private static final String GOTOPAGE = "redirect:/campingDetail.ad";
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private RoomDao roomDao;
		
	@RequestMapping(value=COMMAND)
	public ModelAndView campingDelete(ModelAndView mav,
									 @RequestParam Map<String, Object> map) {
		
		System.out.println("num:" + map.get("num") + " ,status : " + map.get("status") );
		
		//01:노출/ 02:비노출로 변경 (00삭제는 신중해야되서 일단 보류.)
		int cnt = -1;
		
		//캠핑 상태값 변경.
		cnt = campingDao.updateCampingStatus(map);
		
		//객실 상태값 변경.
		map.put("cnum", map.get("num"));
		roomDao.updateRoomStatus(map);
		
		if(cnt != -1) {
			System.out.println("camping 비노출 변경 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("camping 비노출 변경 실패");
			mav.setViewName("admin/camping/campingDetailView");
		}
		
		mav.addObject("num", map.get("num"));
		mav.addObject("pageNumber", map.get("pageNumber"));
		
		return mav;
	}
}
