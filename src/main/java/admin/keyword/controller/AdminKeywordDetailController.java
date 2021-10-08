package admin.keyword.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import admin.keyword.model.AdminKeywordDao;
import user.common.model.KeywordBean;

@Controller
public class AdminKeywordDetailController {

	public static final String COMMAND = "/keywordDetail.ad";
	public static final String GETPAGE = "admin/keyword/keywordDetailForm";
	public static final String GOTOPAGE = "redirect:/keywordList.ad";
	
	@Autowired
	private AdminKeywordDao adminKeywordDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView keywordDetailView(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		KeywordBean keyword = adminKeywordDao.getKeywordsDetail(map);
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("keyword", keyword); //키워드 상세
		
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
    public ModelAndView doActionPost(ModelAndView mav,
    								 @RequestParam (value = "num") int num,
    								 @RequestParam (value = "pageNumber") String pageNumber) {
		
		try {
			
			adminKeywordDao.deleteData(num);
			
			mav.setViewName(GOTOPAGE);
			mav.addObject("pageNumber", pageNumber);
			
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("내부오류");
		}
		
		return mav;
	}
	
}
