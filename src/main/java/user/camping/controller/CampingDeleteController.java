package user.camping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingDao;
import user.room.model.RoomDao;

@Controller
public class CampingDeleteController {

	private static final String COMMAND = "/campingDelete.do";
	private static final String GOTOPAGE = "redirect:/campingList.do";
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private RoomDao roomDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView campingDelete(ModelAndView mav) {
		
		//삭제는 아이디 맞는지 확인, 비밀번호 입력 체크 후 상태 02:비노출로 변경
		
		
		mav.setViewName(GOTOPAGE);
		return mav;
	}
}
