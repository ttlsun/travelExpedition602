package user.camping.controller;

import java.util.HashMap;
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

import user.camping.model.CampingBean;
import user.camping.model.CampingDao;

@Controller
public class CampingListController {

	private static final String COMMAND = "/campingList.do";
	private static final String GETPAGE = "user/camping/campingList";
	
	@Autowired
	private CampingDao campingDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView campingList(ModelAndView mav, 
								  @RequestParam Map<String,String> map,
								  HttpServletRequest request) {
				
		map.put("orderBy", map.get("orderBy"));
		map.put("address1", map.get("address1"));
		map.put("address2", map.get("address2"));
		map.put("camp_type", map.get("camp_type"));
		map.put("themecode", map.get("themecode"));
		map.put("searchName", map.get("searchName"));
		map.put("searchKeyword", map.get("searchKeyword"));
		
		int totalCount = campingDao.getTotalCount(map);
		
		System.out.println("totalCount:" + totalCount);
		
		String pageUrl = request.getContextPath()+ COMMAND;
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<CampingBean> lists = campingDao.getCampingList(pageInfo,map);
		
		System.out.println("lists:" + lists.size());
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	
	@RequestMapping(value="listsssss.do")
	public ModelAndView campingList(ModelAndView mav,
								@RequestParam(value="orderBy", required=false) String orderBy,
								@RequestParam(value="pageNumber", required=false) String pageNumber,
								@RequestParam(value="address1", required=false) String address1,
								@RequestParam(value="address2", required=false) String address2,
								@RequestParam(value="camp_type", required=false) String camp_type,
								@RequestParam(value="themecode", required=false) String themecode,
								@RequestParam(value="searchName", required=false) String searchName,
								@RequestParam(value="searchKeyword", required=false) String searchKeyword,
								HttpServletRequest request) {
		
		System.out.println(orderBy+"/"+pageNumber+"/"+address1+"/"+address2+"/"+camp_type+"/"+themecode+"/"+searchName+"/"+searchKeyword);
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("orderBy", orderBy);
		map.put("address1", address1);
		map.put("address2", address2);
		map.put("camp_type", camp_type);
		map.put("themecode", themecode);
		map.put("searchName", "%"+searchName+"%");
		map.put("searchKeyword", searchKeyword);
		
		int totalCount = campingDao.getTotalCount(map);
		
		String pageUrl = request.getContextPath()+ COMMAND;
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<CampingBean> lists = campingDao.getCampingList(pageInfo,map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		mav.setViewName(GETPAGE);
		return mav;
	}
	
}
