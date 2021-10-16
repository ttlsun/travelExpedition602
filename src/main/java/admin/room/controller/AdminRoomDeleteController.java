package admin.room.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.room.model.RoomDao;

@Controller
public class AdminRoomDeleteController {

	private static final String COMMAND = "/roomDelete.ad";
	private static final String GOTOPAGE = "redirect:/roomDetail.ad";
	
	@Autowired
	private RoomDao roomDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView roomDelete(ModelAndView mav,
								   @RequestParam Map<String, Object> map) {
		
		System.out.println("num:" + map.get("num") + " ,status : " + map.get("status") );
		
		int cnt = -1;
		
		//ROOM STATUS값 01(노출) / 02(비노출)로 변경
		map.put("status", map.get("status"));
		cnt = roomDao.updateRoomStatus(map);
		
		if(cnt != -1) {
			System.out.println("room 비노출 변경 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("room 비노출 변경 실패");
			mav.setViewName("admin/room/roomDetailView");
		}
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("num", map.get("num"));
		
		return mav;
	}
}
