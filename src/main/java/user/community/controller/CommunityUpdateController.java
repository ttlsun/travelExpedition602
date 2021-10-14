package user.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

import user.community.model.CommunityBean;
import user.community.model.CommunityDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.rating.model.RatingDao;

@Controller
public class CommunityUpdateController {

	public static final String COMMAND = "/communityUpdate.do";
	public static final String GETPAGE = "user/community/communityUpdateForm";
	public static final String GOTOPAGE = "redirect:/communityDetail.do";
	
	//리스트로 가고 싶을 경우 사용
	//public static final String GOTOPAGE = "redirect:/communityList.do";
	//public static final String GOTOPAGE_REVIEW = "redirect:/reviewCommunityList.do";
	//public static final String GOTOPAGE_RESERVATION = "redirect:/reservationCommunityList.do";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private CommunityDao communityDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private RatingDao ratingDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
	public ModelAndView communityRegisterView(@RequestParam(value = "type") String type,
											  @RequestParam(value = "num") int num,
			  								  @RequestParam(value = "pageNumber") String pageNumber) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", num);
		map.put("status", "01");
		CommunityBean community = communityDao.getCommunityDetail(map);
		
		//파일 이미지 select
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "6"); //커뮤니티 구분자값
		imgMap.put("anum", num); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("imgList:" + imgList.toString());
		
		mav.addObject("type", type);
		mav.addObject("pageNumber", pageNumber);
		mav.addObject("community", community);
		mav.addObject("basicImgUrl", community.getImgurl());
		mav.addObject("lists", imgList);
		
		return mav;
	}

	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public ModelAndView doActionPost(ModelAndView mav, 
									@RequestParam(value = "type") String type,
									@RequestParam(value = "pageNumber") String pageNumber,
									@RequestParam(value = "basicImgUrl", required = true) String basicImgUrl,
									@ModelAttribute("community") @Valid CommunityBean bean,
									BindingResult result) {
		
		try {
			
			//이미지 파일 리스트 불러오기.
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("acode", "6"); //커뮤니티 구분자값
			map.put("anum", bean.getNum()); 
			List<PostimgBean> imgList = postimgDao.getPostimgList(map);
			
			mav.addObject("num", bean.getNum());
			mav.addObject("type", type);
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("basicImgUrl", basicImgUrl); //기존 대표이미지
			mav.addObject("lists", imgList);
			
			//불필요한 유효성검사 제외 후 기본적인 유효성검사.
			if(result.hasErrors()
					&& !WebUtil.isResultErrorIgnore(result, new String[] {
							"imgurl","imgname", "reviewtype","reservationnum"}))  {
				System.out.println("유효성 검사 오류 S: ----------------------------------------------");
				WebUtil.resultErrorConvert(result);
				System.out.println("유효성 검사 오류 E: ----------------------------------------------");
				mav.setViewName(GETPAGE);
				return mav;
			}
			
			int cnt = -1;
			
			if(bean.getUpdateFile() != null && !bean.getUpdateFile().getOriginalFilename().equals("")) {
				// 대표이미지 파일 업로드
				String uploadFile = WebUtil.fileUpload(servletContext, bean.getUpdateFile(), basicImgUrl);
				System.out.println("uploadFile:" + uploadFile);
				bean.setImgurl(uploadFile);
			}
			
			// 업로드할 파일이 있으면 기존파일 삭제 후 새로 저장
			if(bean.getMultipleUpdateFile() != null && bean.getMultipleUpdateFile().length > 0) {
				// 파일을 지정하지 않아도 기본 배열1개가 있다 그리고 파일명이 없어서 수정되지 않은거로 파악
				if(bean.getMultipleUpdateFile().length > 1 || !bean.getMultipleUpdateFile()[0].getOriginalFilename().equals("")) {
					// 이미지 파일 처리용 (유효성검사때문에 기존 이미지 리스트 데이터를 가져와야해서.. 위에서 이미설정해놨기때문에 필요 커뮤니티, 내고유번호는 또 따로 put할 필요없음.)
//					Map<String, Object> map = new HashMap<String, Object>();
//					map.put("acode", "6"); //커뮤니티. 
//					map.put("anum", bean.getNum());
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
					//후기관련 수정했을경우, 이미지에도 수정관련 업뎃.(파일수정시, 기존파일 삭제후 다시 생성 로직으로 구현하여, 파일 수정안했을경우에 수정관련 업뎃쌓아준다.)
					map.put("modid", bean.getModid()); //수정자아이디
					postimgDao.updatePostimgData(map);
				}
			}
			
			//타입이 커뮤니티 후기(03) 일경우만 빼고, 별수정 한거 업뎃.
			if(!bean.getReviewtype().equals("03")) {
				//등급별 테이블에 저장.
				map.put("reviewnum", bean.getNum());
				map.put("starranking", bean.getStarranking());
				map.put("modid", bean.getModid());
				ratingDao.updateRatingData(map);
			}
			
			//System.out.println("bean:" + bean.toString());
			
			//후기테이블 업뎃
			cnt = communityDao.updateData(bean);
			
			String msg = cnt < 0 ? "수정 실패" : "수정 성공";
			System.out.println(msg);
			
			if(cnt != -1) {				
				mav.setViewName(GOTOPAGE);
				//타입에 맞춰 상세로 이동한다.(1:모든후기 , 2:방문후기 , 3:내가 쓴 my 후기)
//				if(type.equals("3")) {
//					mav.setViewName(GOTOPAGE_RESERVATION);
//				}else if(type.equals("2")) {
//					mav.setViewName(GOTOPAGE_REVIEW);
//				}else {
//					mav.setViewName(GOTOPAGE);
//				}
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
