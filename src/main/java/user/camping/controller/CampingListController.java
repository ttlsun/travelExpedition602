package user.camping.controller;

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
import user.common.model.KeywordBean;
import user.common.model.KeywordDao;

@Controller
public class CampingListController {

	private static final String COMMAND = "/campingList.do";
	private static final String GETPAGE = "user/camping/campingList";
	
	@Autowired
	private CampingDao campingDao;
	
	@Autowired
	private KeywordDao keywordDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView campingList(ModelAndView mav, 
								  @RequestParam Map<String,String> map,
								  HttpServletRequest request) {
		//노출만 리스트업
		map.put("status", "01");
		
		map.put("orderBy", map.get("orderBy"));
		map.put("address1", map.get("address1"));
		map.put("address2", map.get("address2"));
		map.put("camptype", map.get("camptype"));
		map.put("themecode", map.get("themecode"));
		map.put("searchName", map.get("searchName"));
		map.put("regkeyword", map.get("regkeyword"));
		
		//keyword 리스트 불러오기
		String acode = "1";
		List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
    	mav.addObject("keywordLists", keywordLists);
    	
		//게시글 수
		int totalCount = campingDao.getTotalCount(map);
		
		System.out.println("totalCount:" + totalCount);
		
		String pageUrl = request.getContextPath()+ COMMAND;
		
		//캠핑장 리스트 불러오기
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<CampingBean> lists = campingDao.getCampingList(pageInfo,map);
		
		System.out.println("lists:" + lists.size());
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		mav.setViewName(GETPAGE);
		return mav;
	}
	
}
