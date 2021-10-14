package user.qna.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import net.sf.json.JSONObject;
import user.common.model.KeywordBean;
import user.common.model.KeywordDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.qna.model.QnaBean;
import user.qna.model.QnaDao;

@Controller
public class QnaUpdateController {
	
	public static final String COMMAND = "/qnaUpdate.do";
	public static final String GETPAGE = "user/qna/qnaUpdateForm";
	public static final String COMMAND_PWCHK = "/pwChk.do";
	
	public static final String GOTOPAGE = "redirect:/qnaDetail.do";
	//public static final String GOTOPAGE = "redirect:/qnaList.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private QnaDao qnaDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private KeywordDao keywordDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView qnaUpdateView(HttpServletRequest request,
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
		
		//키워드 태그 (키워드 테이블)조회
		String acode = "4"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티,4:문의)
    	List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
    	//System.out.println("keywordLists:" + keywordLists.toString());
    	
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("qna", qna); //문의 상세
		mav.addObject("imgList", imgList); //이미지리스트
		mav.addObject("keywordLists", keywordLists); //키워드태그 리스트
		
		return mav;
	}
	
	
	@RequestMapping(value = COMMAND_PWCHK)
	public void doJsonPwChk(HttpServletResponse response,
									@RequestParam(value = "num") int num,
									@RequestParam(value = "pw") String pw ) throws Exception {

		JSONObject json = new JSONObject();
		
		try {
			
			//System.out.println("pw:" + pw);
			
			if (pw == null || pw.equals("")) {
				throw new Exception("비밀번호를 입력하세요");
			}
			
			String pwChk = qnaDao.getPwData(num);
			//System.out.println("pwChk: " + pwChk);
			
			if (!pwChk.equals(pw)) {
				throw new Exception("비밀번호가 일치하지 않습니다.");
			}

			json.put("resultCode", "OK");
			json.put("resultMsg", "성공");
			
		} catch (Exception e) {
			json.put("resultCode", "ERROR");
			json.put("resultMsg", e.getMessage());
		}
		
		WebUtil.jsonSend(json, response);
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public ModelAndView doActionPost(ModelAndView mav,
									@RequestParam(value = "pageNumber") String pageNumber,
									@ModelAttribute("qna") @Valid QnaBean bean,
									BindingResult result) {
		
		try {
			
			//키워드 리스트 불러오기
			String acode = "4"; //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티,4:문의)
	    	List<KeywordBean> keywordLists = keywordDao.getKeywordList(acode); 
	    	mav.addObject("keywordLists", keywordLists);
			
			//이미지 파일 리스트 불러오기.
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("acode", "3"); //문의 구분자값
			map.put("anum", bean.getNum()); 
			List<PostimgBean> imgList = postimgDao.getPostimgList(map);
			
			mav.addObject("num", bean.getNum());
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("imgList", imgList);
			
			//불필요한 유효성검사 제외 후 기본적인 유효성검사.
			if(result.hasErrors()
					&& !WebUtil.isResultErrorIgnore(result, new String[] {"imgname"}))  {
				System.out.println("유효성 검사 오류 S: ----------------------------------------------");
				WebUtil.resultErrorConvert(result);
				System.out.println("유효성 검사 오류 E: ----------------------------------------------");
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			int cnt = -1;
			
			// 업로드할 파일이 있으면 기존파일 삭제 후 새로 저장
			if(bean.getMultipleUpdateFile() != null && bean.getMultipleUpdateFile().length > 0) {
				// 파일을 지정하지 않아도 기본 배열1개가 있다 그리고 파일명이 없어서 수정되지 않은거로 파악
				if(bean.getMultipleUpdateFile().length > 1 || !bean.getMultipleUpdateFile()[0].getOriginalFilename().equals("")) {
					map.put("regid", bean.getModid()); //아이디
//					
					// 기존파일 삭제를 위해 이미지테이블을 조회한다.
					List<PostimgBean> postImglists = postimgDao.getPostimgList(map);
					String[] arPostImgFileName = new String[postImglists.size()];
					
					for(int i = 0; i < postImglists.size(); i++) {
						arPostImgFileName[i] = postImglists.get(i).getImgname(); //이미지명
					}
					
					// 기존파일 삭제 및 추가파일 업로드
					String[] uploadFileList = WebUtil.fileUpload(servletContext, bean.getMultipleUpdateFile(), arPostImgFileName);
					// 기존파일 DB에서 삭제
					postimgDao.deletePostimgData(map);
					
					for(String tmp : uploadFileList) {
						System.out.println("업로드파일명 : " + tmp);
						//여기에 이미지 테이블 업뎃
						map.put("imgname", tmp);
						postimgDao.insertPostimgData(map);
					}
				}else {
					//파일 수정을 안했을경우, 수정 내역 업뎃.
					map.put("modid", bean.getModid()); //수정자아이디
					postimgDao.updatePostimgData(map);
				}
			}
			
			//문의 테이블 업뎃
			cnt = qnaDao.updateData(bean);
			
			String msg = cnt < 0 ? "수정 실패" : "수정 성공";
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
