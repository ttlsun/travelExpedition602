package user.qna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.WebUtil;

import user.common.model.KeywordBean;
import user.common.model.KeywordDao;
import user.postimg.model.PostimgDao;
import user.qna.model.QnaBean;
import user.qna.model.QnaDao;

@Controller
public class QnaRegisterController {
	
	public static final String COMMAND = "/qnaRegister.do";
	public static final String GETPAGE = "user/qna/qnaRegisterForm";
	public static final String GOTOPAGE = "redirect:/qnaList.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private KeywordDao keywordDao;

	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView qnaRegisterViews() {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		String acode = "4"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티,4:문의)
    	List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
    	//System.out.println("keywordLists:" + keywordLists.toString());
    	
    	mav.addObject("keywordLists", keywordLists);
    	
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public ModelAndView doActionPost(ModelAndView mav, HttpServletRequest request,
									@ModelAttribute("qna") @Valid QnaBean bean,
									BindingResult result) {
		try {
			
			String acode = "4"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티,4:문의)
	    	List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
	    	mav.addObject("keywordLists", keywordLists);
			
			//System.out.println("regkeyword:" + bean.getRegkeyword());
			
			//isResultErrorIgnore(Error 목록에서 특정 필드를 제외)
			if(result.hasErrors())  {
				System.out.println("유효성 검사 오류 S: ----------------------------------------------");
				WebUtil.resultErrorConvert(result);
				System.out.println("유효성 검사 오류 E: ----------------------------------------------");
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			int cnt = -1;
			
			//내 고유번호 최대값 구하기.
			int maxNum = qnaDao.getQnaMaxNum();
			//System.out.println("maxNum:::" + maxNum);
	
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("acode", "3"); //문의게시판 구분코드
			map.put("anum", maxNum);
			map.put("regid", bean.getId());
			
			//이미지테이블에 이미지들 저장.
			String[] uploadFileList = WebUtil.fileUpload(servletContext, bean.getMultipleUpdateFile(), null);
			
			//System.out.println("uploadFileList :" + uploadFileList);
			for (String str : uploadFileList) {
				System.out.println("file : " + str);
				
				//파일이 있을경우만, 이미지테이블에 데이터를 쌓는다.
				if(str != null) {
					map.put("imgname", str);
					cnt = postimgDao.insertPostimgData(map);
					bean.setImgname(str);
				}
			}
			
			bean.setNum(maxNum);
			bean.setRef(maxNum);
			bean.setStatus("01"); //01:답변대기 , 02:보류중 , 03:답변완료 , 그외 문의전화요망.
			cnt = qnaDao.insertData(bean);
			
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
