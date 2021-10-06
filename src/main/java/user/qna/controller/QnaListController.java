package user.qna.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.qna.model.QnaBean;
import user.qna.model.QnaDao;

@Controller
public class QnaListController {
	
	public static final String COMMAND = "/qnaList.do";
	public static final String GETPAGE = "user/qna/qnaList";
	
	@Autowired
	private QnaDao qnaDao;
	
	/**
	 * 문의 리스트
	 * @param request
	 * @param map
	 * @return
	 */
	@RequestMapping(value = COMMAND)
    public ModelAndView qnaListView(HttpServletRequest request, @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		int totalCount = qnaDao.getQnaListTotalCnt(map);
	
		String pageUrl = request.getContextPath()+ COMMAND; //페이지 URL
		
		Paging pageInfo = new Paging(map, "10", totalCount, pageUrl);
		List<QnaBean> lists = qnaDao.getQnaList(pageInfo, map);
		
		mav.addObject("pageInfo", pageInfo);
		mav.addObject("totalCount", totalCount);
		mav.addObject("lists", lists);
		
		return mav;
	}
	
}
