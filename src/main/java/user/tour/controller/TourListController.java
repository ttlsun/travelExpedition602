package user.tour.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.tour.model.TourDao;

@Controller
public class TourListController {

	private final String command = "/tourList.do";
	private final String getPage = "redirect:/user.";
	
	@RequestMapping(value=command, method=RequestMethod.GET)
	public ModelAndView tourList(@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber,
			HttpServletRequest request) {
		
		
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("whatColumn", whatColumn); 
		map.put("keyword", "%"+keyword+"%");
		int totalCount = TourDao.getTotalCount(map);
		String url = request.getContextPath() + command;
		
		
		Paging pageInfo = new Paging(pageNumber, null, totalCount, url, whatColumn, keyword, null);
		
		ModelAndView mav = new ModelAndView();
		
		return mav;
	}
}
