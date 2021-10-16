package user.tour.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.common.model.KeywordBean;
import user.common.model.KeywordDao;
import user.tour.model.TourBean;
import user.tour.model.TourDao;

@Controller
public class TourListController {

	private static final String COMMAND = "/tourList.do";
	private static final String GETPAGE = "user/tour/tourList";
	
	@Autowired
	private TourDao tourDao;

	@Autowired
	private KeywordDao keywordDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView tourListView(ModelAndView mav,
									@RequestParam Map<String,String> map,
									HttpServletRequest request) {
		
		//노출만 보여주기.
		map.put("status", "01");	
		
		String[] themecodeAddr = request.getParameterValues("themecode"); //테마
		String[] regkeywordAddr = request.getParameterValues("regkeyword"); //키워드
		
		//테마가 검색이 있을경우
		if(themecodeAddr != null) {
			String themecode = "";
			for(int i=0; i<themecodeAddr.length; i++){
				themecode += themecodeAddr[i] +"|"; //구분자(02|03) <<요런식으로 들어갈수 있게 넣는과정.
			}
			themecode = themecode.replaceAll(".$", "");
			
			map.put("themecode", themecode);
		}
		
		//키워드 검색이 있을경우
		if(regkeywordAddr != null) {
			String regkeyword = "";
			for(int i=0; i<regkeywordAddr.length; i++){
				regkeyword += regkeywordAddr[i] + ",";
			}
			regkeyword = regkeyword.replaceAll(".$", "");
			map.put("regkeyword", regkeyword);
		}

		//keyword 리스트 불러오기
		String acode = "2";
		List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
		mav.addObject("keywordLists", keywordLists);
		
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
	