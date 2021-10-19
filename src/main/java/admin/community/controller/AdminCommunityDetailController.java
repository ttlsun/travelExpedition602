package admin.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;
import com.my.travelExpedition.utility.WebUtil;

import user.community.model.CommunityBean;
import user.community.model.CommunityDao;
import user.community.model.CommunityReplyBean;
import user.like.model.LikeDao;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.rating.model.RatingDao;

@Controller
public class AdminCommunityDetailController {

	public static final String COMMAND = "/communityDetail.ad";
	public static final String GETPAGE = "admin/community/communityDetailForm";
	public static final String GOTOPAGE = "redirect:/communityDetail.ad";
	public static final String GOTOPAGE_LIST = "redirect:/communityList.ad";
	
	@Autowired
	private ServletContext servletContext;
	
	@Autowired
	private CommunityDao communityDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private RatingDao ratingDao;
	
	@Autowired
	private LikeDao likeDao;
	
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
    public ModelAndView communityDetailView(HttpServletRequest request,
    										@RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		Map<String, Object> communityMap = new HashMap<String, Object>();
		communityMap.put("num", map.get("num"));
		CommunityBean community = communityDao.getCommunityDetail(communityMap);
		
		//여럿 파일 이미지들(이미지관리테이블) 조회
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "6"); //커뮤니티 구분자값
		imgMap.put("anum", map.get("num")); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		//System.out.println("lists:" + lists.toString());
		
		//댓글리스트 조회.
		map.put("reviewnum", map.get("num")); 
		int replyTotalCount = communityDao.getCommunityReplyListTotalCnt(map);
		String pageUrl = request.getContextPath() + COMMAND; //페이지 URL
		Paging replyPageInfo = new Paging(map, "10", replyTotalCount, pageUrl);
		List<CommunityReplyBean> replyLists = communityDao.getCommunityReplyList(replyPageInfo, map);
	
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("community", community); //후기 상세
		mav.addObject("imgList", imgList); //이미지리스트
		mav.addObject("replyLists", replyLists); //후기댓글 리스트
		mav.addObject("replyPageInfo", replyPageInfo); //후기댓글 페이징 정보
		mav.addObject("replyTotalCount", replyTotalCount); //후기댓글 총 갯수
		mav.addObject("replyPageNumber", map.get("replyPageNumber")); //후기댓글 페이지
		
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
    public ModelAndView communityDetailPost(ModelAndView mav,@RequestParam Map<String, Object> map) {
		
		System.out.println("map:" + map.get("num") + " ," + map.get("status") );
		
		try {
			//상태값이 00일경우 완전삭제(이미지들도 삭제) , 상태값이 01: 노출 , 02 :비노출로 변경.
			if(map.get("status").equals("00")) {
				
				System.out.println("map.get(\"status\")" + map.get("status"));
				
				//여럿 파일 이미지들(이미지관리테이블) 조회
				map.put("acode", "6"); //커뮤니티 구분자값
				map.put("anum", map.get("num")); 
				List<PostimgBean> postImglists = postimgDao.getPostimgList(map);
				System.out.println("DB 이미지 갯수 :" + postImglists.size());
				
				// 대표이미지 기존파일 삭제
				String imgurl = (String)map.get("imgurl");
				//System.out.println("imgurl:" + imgurl);
				WebUtil.deletefileUpload(servletContext, imgurl);
				
				// (이미지관리테이블 삭제) 기존파일 삭제를 위해 이름을 조회한다
				String[] arPostImgFileName = new String[postImglists.size()];
				for(int i = 0; i < postImglists.size(); i++) {
					arPostImgFileName[i] = postImglists.get(i).getImgname(); //이미지명
				}
				
				// 이미지 테이블에 기존이미지들 파일들 삭제
				WebUtil.deletefileUpload(servletContext, arPostImgFileName);
				
				// 기존파일 DB에서 삭제
				postimgDao.deletePostimgData(map);
				
				//캠핑 or 관광지 고유번호.
				//int revieNum = Integer.parseInt((String)map.get("reviewnum"));
				//int revieNum = 1;
				//System.out.println("revieNum:" + map.get("reviewnum"));
				
				//별등급 삭제.(01,02 일경우에만 등급 테이블 삭제.)
				if(!map.get("reviewtype").equals("03")) {
					map.put("reviewnum", map.get("num")); 
					map.put("reviewtype", map.get("reviewtype")); 
					map.put("regid", map.get("regid")); 
					ratingDao.deleteRatingData(map);
					
					//캠핑 or 관광지 리뷰수 삭제하기.
					map.put("reviewnum", map.get("reviewnum"));
					communityDao.deleteUpdateReviewCount(map);
					
					//캠핑 or 관광지 테이블에 추천 카운트 삭제하기
					communityDao.deleteUpdateRecommend(map);
					
				}
				
				//likes 테이블 삭제.
				map.put("anum", map.get("num")); 
				map.put("acode", "3"); //게시글 구분코드(1:캠핑/2:관광지/3:커뮤니티)
				likeDao.deleteLikesData(map);
				
				int num = Integer.parseInt((String)map.get("num"));
				//System.out.println("num::::" + num);
				
				//댓글 삭제
				communityDao.deleteAllCommunityReply(num);
				
				//후기 테이블 데이터 삭제
				communityDao.deleteData(num);
				
				mav.setViewName(GOTOPAGE_LIST);
				
				
			}else {
				communityDao.updateCommunityStatusChange(map);
				mav.setViewName(GOTOPAGE);
			}
			
			mav.addObject("pageNumber", map.get("pageNumber"));
			mav.addObject("num", map.get("num"));
			
		}catch (Exception e) {
			e.printStackTrace();
			System.out.println("내부오류");
			mav.setViewName(GOTOPAGE);
		}
		
		return mav;
	}
	
	
}
