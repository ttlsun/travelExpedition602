package user.tour.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.tour.model.TourDao;

@Controller
public class BTourDeleteController {

	private static final String COMMAND = "/bTourDelete.do";
	private static final String GOTOPAGE = "redirect:/bTourList.do";
	
	@Autowired
	private TourDao tourdao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView tourDelete(ModelAndView mav,
			@RequestParam Map<String, Object> map) {
		
		int cnt = -1;
		
		map.put("status", "02");
		cnt = tourdao.updateTourStatus(map);
		
		if(cnt != -1) {
			System.out.println("tour 비노출 변경 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("tour 비노출 변경 실패");
			mav.setViewName("user/tour/tourDetailView");
		}
		
		mav.addObject("num",map.get("num"));
		mav.addObject("pageNumber",map.get("pageNumber"));
		
		return mav;
	}
}