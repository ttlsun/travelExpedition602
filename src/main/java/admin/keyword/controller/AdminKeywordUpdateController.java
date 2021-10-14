package admin.keyword.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

import admin.keyword.model.AdminKeywordDao;
import user.common.model.KeywordBean;

@Controller
public class AdminKeywordUpdateController {

	public static final String COMMAND = "/keywordUpdate.ad";
	public static final String GETPAGE = "admin/keyword/keywordUpdateForm";
	public static final String GOTOPAGE = "redirect:/keywordDetail.ad"; //상세로 이동
	//public static final String GOTOPAGE = "redirect:/keywordList.ad"; //리스트로이동
	
	@Autowired
	private AdminKeywordDao adminKeywordDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView keywordUpdateView(@RequestParam Map<String, Object> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		KeywordBean keyword = adminKeywordDao.getKeywordsDetail(map);
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("keyword", keyword); //키워드 상세
		
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public ModelAndView doActionPost(ModelAndView mav, HttpServletRequest request,
									@RequestParam(value = "pageNumber") String pageNumber,
									@ModelAttribute("keyword") @Valid KeywordBean bean,
									BindingResult result) {
		try {
			
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("num", bean.getNum()); 
			
			if(result.hasErrors())  {
				
				System.out.println("유효성 검사 오류 S: ----------------------------------------------");
				WebUtil.resultErrorConvert(result);
				System.out.println("유효성 검사 오류 E: ----------------------------------------------");
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			int cnt = -1;
			
			cnt = adminKeywordDao.updateData(bean);
			
			String msg = cnt < 0 ? "삽입 실패" : "삽입 성공";
			System.out.println(msg);
			
			if(cnt != -1) {
				mav.setViewName(GOTOPAGE);
				
			}else {
				mav.setViewName(GETPAGE);
				return mav;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName(GETPAGE);
			System.out.println("내부 오류");
		}
		
		return mav;
	}
	
}
