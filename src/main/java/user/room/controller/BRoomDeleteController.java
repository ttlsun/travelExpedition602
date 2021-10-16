package user.room.controller;

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
							@RequestParam("pageNumber") String pageNumber) {
		
		//campingDetail.do로 넘길 캠핑장 번호 파라미터값
		String cnum = roomDao.getCampingNum(num);
		
		int cnt = -1;
		
		//ROOM STATUS값 02(비노출)로 변경
		cnt = roomDao.updateRoomStatusBlind(num);
		
		if(cnt != -1) {
			System.out.println("room 비노출 변경 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("room 비노출 변경 실패");
			mav.setViewName("user/room/bRoomDetailView");
		}
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("cnum", cnum);
		
		return mav;
	}
}
