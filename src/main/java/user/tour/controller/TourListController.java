package user.tour.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.tour.model.TourBean;
import user.tour.model.TourDao;

@Controller
public class TourListController {

	private static final String COMMAND = "/tourList.do";
	private static final String GETPAGE = "user/tour/tourList";
	
	
	@Autowired
	private TourDao tourDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView tourListView(ModelAndView mav,
									@RequestParam Map<String,String> map,
									@RequestParam(value="pageNumber", required=false) String pageNumber,
									HttpServletRequest request) {
		
		map.put("status", "01");
		
		
		int totalCount = tourDao.getTotalCount(map);
		String pageUrl = request.getContextPath() + COMMAND;
		
		Paging pageInfo = new Paging(map,"10",totalCount, pageUrl);
		
		
		List<TourBean> lists = tourDao.getTourList(pageInfo,map);
		
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		mav.setViewName(GETPAGE);
		return mav;
	}
}
	

