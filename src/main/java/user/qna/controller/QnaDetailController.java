package user.qna.controller;

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

import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.qna.model.QnaBean;
import user.qna.model.QnaDao;

@Controller
public class QnaDetailController {
	
	public static final String COMMAND = "/qnaDetail.do";
	public static final String GETPAGE = "user/qna/qnaDetailForm";
	public static final String GOTOPAGE =  "redirect:/qnaList.do";
	
	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView qnaDetailView(HttpServletRequest request,
    								  @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		Map<String, Object> qnaMap = new HashMap<String, Object>();
		qnaMap.put("num", map.get("num"));
		QnaBean qna = qnaDao.getQnaDetail(qnaMap);
		
		//여럿 파일 이미지들(이미지관리테이블) 조회
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "3"); //문의 구분자값
		imgMap.put("anum", map.get("num")); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("lists:" + lists.toString());
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("qna", qna); //문의 상세
		mav.addObject("imgList", imgList); //이미지리스트
		
		return mav;
	}
	
}
