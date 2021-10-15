package admin.camping.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.camping.model.CampingBean;
import user.camping.model.CampingDao;

@Controller
public class AdminCampingListController {

	private static final String COMMAND = "/campingList.ad";
	private static final String GETPAGE = "admin/camping/campingList";

	@Autowired
	private CampingDao campingDao;

	@RequestMapping(value=COMMAND)
	public ModelAndView campingList(ModelAndView mav, 
								  @RequestParam Map<String, String> map,
								  HttpServletRequest request) {
		System.out.println("ad컨트롤러");
		
		map.put("address1", map.get("address1"));
		map.put("address2", map.get("address2"));
		map.put("status", map.get("status"));
		
		//게시글 수
		int totalCount = campingDao.getTotalCount(map);
				
		System.out.println("totalCount:" + totalCount);
		
		String pageUrl = request.getContextPath()+ COMMAND;
		
		//캠핑장 리스트 불러오기
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<CampingBean> lists = campingDao.getCampingList(pageInfo,map);
		
		System.out.println("lists:" + lists.size());
		
		mav.addObject("status", map.get("status"));
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		mav.setViewName(GETPAGE);
		return mav;
	}
}
