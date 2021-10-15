package admin.tour.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;
import user.tour.model.TourBean;
import user.tour.model.TourDao;

@Controller
public class AdminTourListController {

	private static final String COMMAND = "/tourList.ad";
	private static final String GETPAGE = "admin/tour/tourList";
	
	@Autowired
	private TourDao tourDao;
	
	@RequestMapping(value = COMMAND)
	public ModelAndView adminTourListView(HttpServletRequest request, @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		int totalCount = tourDao.getTotalCount(map);
		
		System.out.println("totalCount:"+totalCount);
		
		String pageUrl = request.getContextPath()+ COMMAND;
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<TourBean> lists = tourDao.getTourList(pageInfo, map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		return mav;
	}
}
