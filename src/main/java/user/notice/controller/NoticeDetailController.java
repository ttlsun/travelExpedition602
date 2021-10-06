package user.notice.controller;

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

import admin.notice.model.AdminNoticeBean;
import admin.notice.model.AdminNoticeDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;

@Controller
public class NoticeDetailController {
	
	public static final String COMMAND = "/noticeDetail.do";
	public static final String GETPAGE = "user/notice/noticeDetailForm";
	
	@Autowired
	private AdminNoticeDao adminNoticeDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView noticeDetailView(HttpServletRequest request,
    										@RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		Map<String, Object> noticeMap = new HashMap<String, Object>();
		noticeMap.put("num", map.get("num"));
		AdminNoticeBean notice = adminNoticeDao.getNoticeDetail(noticeMap);
		
		//여럿 파일 이미지들(이미지관리테이블) 조회
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "1"); //공지사항 구분자값
		imgMap.put("anum", map.get("num")); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("lists:" + lists.toString());
		
		//조회수 올리기.
		adminNoticeDao.updateNoticeUpcount(noticeMap);
		
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("notice", notice); //이벤트 상세
		mav.addObject("imgList", imgList); //이미지리스트
		
		return mav;
	}
	
}
