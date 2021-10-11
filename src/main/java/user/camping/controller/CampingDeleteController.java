package user.camping.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.camping.model.CampingDao;

@Controller
public class CampingDeleteController {

	private static final String COMMAND = "/campingDelete.do";
	private static final String GOTOPAGE = "redirect:/campingList.do";
	
	@Autowired
	private CampingDao campingDao;
		
	@RequestMapping(value=COMMAND)
	public ModelAndView campingDelete(ModelAndView mav,
							@RequestParam("num") String num,
							@RequestParam("pageNumber") String pageNumber) {
		
		//아이디 맞는지 확인, 비밀번호 입력 체크 후 상태 02:비노출로 변경
		int cnt = -1;
		
		cnt = campingDao.updateCampingStatusBlind(num);
		
		if(cnt != -1) {
			System.out.println("camping 비노출 변경 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("camping 비노출 변경 실패");
			mav.setViewName("user/camping/campingDetailView");
		}
		
		mav.addObject("num", num);
		mav.addObject("pageNumber", pageNumber);
		
		return mav;
	}
}
