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
public class CampingRegisterController {
	
	private static final String COMMAND = "/campingRegister.do";
	private static final String GETPAGE = "user/camping/campingRegisterForm";
	private static final String GOTOPAGE = "redirect:/campingList.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private CampingDao campingDao;

	@Autowired
	private KeywordDao keywordDao;
	
	@RequestMapping(value=COMMAND, method=RequestMethod.GET)
	public ModelAndView campingRegisterGet(ModelAndView mav) {
		
		//keyword 리스트 불러오기
		String acode = "1";
		List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
		mav.addObject("keywordLists", keywordLists);
		    	
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value=COMMAND, method=RequestMethod.POST)
	public ModelAndView campingRegisterPost(ModelAndView mav,
									@ModelAttribute("camping") @Valid CampingBean campbean, 
									BindingResult result
									) {
			try {
			
			if(result.hasErrors()) {
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			
			int cnt = -1;
			
			//대표이미지 파일 업로드
			String uploadFile;
			
			uploadFile = WebUtil.fileUpload(servletContext, campbean.getUpdateFile(), null);
		
			System.out.println("uploadFile:" + uploadFile);
			campbean.setImgurl(uploadFile);
		
			//이미지 넣지 않은 경우
			if(campbean.getImgurl() == null || campbean.getImgurl().equals("")) {
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			//로그인 세션에 저장되어 있는 id값 넣기
			campbean.setRegid(campbean.getRegid()+"id");
						
			System.out.println(campbean.toString());
			
			//캠핑장 레코드 insert
			cnt = campingDao.insertData(campbean);
			
			if(cnt != -1) {
				System.out.println("camping 등록 성공");
				mav.setViewName(GOTOPAGE);
			}
			else {
				System.out.println("camping 등록 실패");
				mav.setViewName(GETPAGE);
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			mav.setViewName(GETPAGE);
			System.out.println("campingRegister 오류");
		}
		
		return mav;
	}
}

