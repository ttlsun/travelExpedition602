package user.room.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.room.model.RoomDao;

@Controller
public class BRoomDeleteController {

	private static final String COMMAND = "/bRoomDelete.do";
	private static final String GOTOPAGE = "redirect:/bCampingDetail.do";
	
	@Autowired
	private RoomDao roomDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView roomDelete(ModelAndView mav,
								@RequestParam("num") String num,
								@RequestParam("cnum") String cnum,
								@RequestParam("pageNumber") String pageNumber) {
		
		System.out.println("num:" + num + "cnum:" + cnum);
		
		int cnt = -1;
		
		//ROOM STATUS값 02(비노출)로 변경 (cnum이 따로 들가면 안되서 map 따로 생성.)
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("status","02");
		map.put("num",num);
		cnt = roomDao.updateRoomStatus(map);
		
		if(cnt != -1) {
			System.out.println("room 비노출 변경 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("room 비노출 변경 실패");
			mav.setViewName("user/room/bRoomDetailView");
		}
		
		mav.addObject("pageNumber", pageNumber); //캠핑 상세페이지갈때 pageNumber 넘기기.
		mav.addObject("num", cnum); //캠핑 상세페이지갈때 캠핑num 넘기기.
		
		return mav;
	}
}
