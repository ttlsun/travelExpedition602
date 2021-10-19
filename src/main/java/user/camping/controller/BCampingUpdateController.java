package user.camping.controller;

import java.util.List;

import javax.servlet.ServletContext;
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

import user.camping.model.CampingBean;
import user.camping.model.CampingDao;
import user.common.model.KeywordBean;
import user.common.model.KeywordDao;

@Controller
public class BCampingUpdateController {
	
	private static final String COMMAND = "/bCampingUpdate.do";
	private static final String GETPAGE = "user/camping/bCampingUpdateForm";
	private static final String GOTOPAGE = "redirect:/bCampingDetail.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private CampingDao campingDao;

	@Autowired
	private KeywordDao keywordDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView campingUpdateGet(ModelAndView mav,
								@RequestParam("num") String num,
								@RequestParam("pageNumber") String pageNumber) {
		
		CampingBean camping = campingDao.getCampingDetail(num);
		
		//keyword 리스트 불러오기
		String acode = "1";
		List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
		mav.addObject("keywordLists", keywordLists);
		
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("camping", camping);
		mav.addObject("originImgUrl", camping.getImgurl());
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView campingUpdatePost(ModelAndView mav,
								@RequestParam(value = "pageNumber") String pageNumber,
								@RequestParam(value = "originImgUrl") String originImgUrl,
								@ModelAttribute("camping") @Valid CampingBean campbean,
								BindingResult result) {
		System.out.println("campbean:"+campbean.toString());
		try {
		
		//keyword 리스트 불러오기
		String acode = "1";
		List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
		mav.addObject("keywordLists", keywordLists);	
			
		mav.addObject("num", campbean.getNum());
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("originImgUrl", originImgUrl);
		
		//isResultErrorIgnore(Error 목록에서 특정 필드를 제외)
		if(result.hasErrors()
				&& !WebUtil.isResultErrorIgnore(result, new String[] {"imgurl"}))  {
			
			System.out.println("유효성 검사 오류 S: ----------------------------------------------");
			WebUtil.resultErrorConvert(result);
			System.out.println("유효성 검사 오류 E: ----------------------------------------------");
			mav.setViewName(GETPAGE);
			return mav;
		}
		
		int cnt = -1;
		
		if(campbean.getUpdateFile() != null && !campbean.getUpdateFile().getOriginalFilename().equals("")) {
			// 대표이미지 파일 업로드
			String uploadFile = WebUtil.fileUpload(servletContext, campbean.getUpdateFile(), originImgUrl);
			System.out.println("uploadFile:" + uploadFile);
			campbean.setImgurl(uploadFile);
		}
		
		//로그인 세션에 저장되어 있는 id값 넣기
		campbean.setModid(campbean.getModid());
				
		cnt = campingDao.updateData(campbean);
		
		if(cnt != -1) {
			System.out.println("camping 수정 성공");
			mav.setViewName(GOTOPAGE);
		}
		else {
			System.out.println("camping 수정 실패");
			mav.setViewName(GETPAGE);
		}
		
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName(GETPAGE);
			System.out.println("campingUpdate 오류");
		}
		
		return mav;
	}
}
