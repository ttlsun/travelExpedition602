package user.tour.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import user.tour.model.TourDao;

@Controller
public class TourDeleteController {

	private static final String COMMAND = "/tourDelete.do";
	private static final String GOTOPAGE = "redirect:/tourList.do";
	
	@Autowired
	private TourDao tourdao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView tourDelete(ModelAndView mav,
			@RequestParam("num") String num,
			@RequestParam("pageNumber") String pageNumber) {
		
		int cnt = -1;
		
		cnt = tourdao.updateTourStatusBlind(num);
		
		if(cnt != -1) {
			System.out.println("tour 비노출 변경 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("tour 비노출 변경 실패");
			mav.setViewName("user/tour/tourDetailView");
		}
		
		mav.addObject("num",num);
		mav.addObject("pageNumber",pageNumber);
		
		return mav;
	}
}