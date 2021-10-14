package user.community.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;
import com.my.travelExpedition.utility.WebUtil;

import net.sf.json.JSONObject;
import user.community.model.CommunityBean;
import user.community.model.CommunityDao;
import user.community.model.CommunityReplyBean;
import user.postimg.model.PostimgBean;
import user.postimg.model.PostimgDao;
import user.rating.model.RatingDao;

@Controller
public class CommunityDetailController {

	public static final String COMMAND = "/communityDetail.do";
	public static final String GETPAGE = "user/community/communityDetailForm";
	
	public static final String COMMAND_UPDATE_STATUS = "/communityUpdateStatus.do";
	public static final String COMMAND_REPLY_REGISTER = "/communityReplyRegister.do";
	public static final String COMMAND_REPLY_DELETE = "/communityReplyDelete.do";
	
	public static final String COMMAND_RATING_REGISTER = "/communityRatingRegister.do";
	public static final String COMMAND_RATING_DELETE = "/communityRatingDelete.do";
	
	@Autowired
	private CommunityDao communityDao;
	
	@Autowired
	private PostimgDao postimgDao;
	
	@Autowired
	private RatingDao ratingDao;
	
	@RequestMapping(value = COMMAND)
    public ModelAndView communityListView(HttpServletRequest request,
    									  @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		//후기 상세페이지 조회.
		Map<String, Object> communityMap = new HashMap<String, Object>();
		communityMap.put("num", map.get("num"));
		communityMap.put("status", "01");
		CommunityBean community = communityDao.getCommunityDetail(communityMap);
		
		//파일 이미지 테이블 조회.
		Map<String, Object> imgMap = new HashMap<String, Object>();
		imgMap.put("acode", "6"); //커뮤니티 구분자값
		imgMap.put("anum", map.get("num")); 
		List<PostimgBean> imgList = postimgDao.getPostimgList(imgMap);
		System.out.println("imgList:" + imgList.toString());
		
		//댓글리스트 조회.
		map.put("reviewnum", map.get("num")); 
		int replyTotalCount = communityDao.getCommunityReplyListTotalCnt(map);
		String pageUrl = request.getContextPath() + COMMAND; //페이지 URL
		Paging replyPageInfo = new Paging(map, "10", replyTotalCount, pageUrl);
		List<CommunityReplyBean> replyLists = communityDao.getCommunityReplyList(replyPageInfo, map);
		
		//조회수 업데이트.
		//int num = Integer.parseInt(map.get("num").toString());
		//System.out.println("num::::" + num);
		communityMap.put("readcount","readcount"); //조회수
		communityDao.updateCommunityUpcount(communityMap);
		
		//추천 리스트 뿌리기. (01:캠핑으로 올시, 관광지 추천으로 보여주고, 02:관광지로 올시, 캠핑 추천으로 보여준다. 03:모든후기 올시, 추천X)
		String recommendType = "";
		String reviewType = community.getReviewtype();
		if(reviewType.equals("01")) {
			recommendType = "02";
		}else if(reviewType.equals("02")) {
			recommendType = "01";
		}
		
		map.put("recommendType", recommendType);
		List<CommunityBean> recommendList = communityDao.getRecommendList(map);
		
		mav.addObject("type", map.get("type"));
		mav.addObject("pageNumber", map.get("pageNumber"));
		mav.addObject("regid", map.get("regid"));
		mav.addObject("community", community); //후기테이블 상세
		mav.addObject("imgList", imgList); //이미지테이블 리스트
		mav.addObject("replyLists", replyLists); //후기댓글 리스트
		mav.addObject("replyPageInfo", replyPageInfo); //후기댓글 페이징 정보
		mav.addObject("replyTotalCount", replyTotalCount); //후기댓글 총 갯수
		//(지금은 수정에서 상세로올때 이것도 같이 보내고있지않지만..추후 필요할수 있으니.. 넣어놈.)
		mav.addObject("communityPageNumber", map.get("communityPageNumber")); //후기댓글 페이지
		mav.addObject("recommendList", recommendList); //추천 리스트
		
		System.out.println("recommendList:" + recommendList.size());
		
		return mav;
	}
	
	//후기 삭제버튼 클릭시, 비노출 상태값으로 변경(회원은 삭제 못하게 함.) 
	@RequestMapping(value = COMMAND_UPDATE_STATUS)
	public void doJsonUpdateStatus(HttpServletResponse response,
									@RequestParam Map<String, Object> map) throws Exception {
		
		JSONObject json = new JSONObject();
		
		try {
			
			map.put("num", map.get("num"));
			map.put("status", "02");
			communityDao.updateCommunityStatusChange(map);

			json.put("resultCode", "OK");
			json.put("resultMsg", "성공");
			
		} catch (Exception e) {
			json.put("resultCode", "ERROR");
			json.put("resultMsg", e.getMessage());
		}
		
		WebUtil.jsonSend(json, response);
	}
	
	//별, 좋아요 등록 JSONObject 로 처리.
	@RequestMapping(value = COMMAND_RATING_REGISTER)
	public void doJsonRatingRegister(HttpServletResponse response,@RequestParam Map<String, Object> map) throws Exception {
		
		JSONObject json = new JSONObject();
		
		try {
			
			//캠핑 or 관광지 고유번호.
			int revieNum = Integer.parseInt((String)map.get("reviewnum"));
			System.out.println("revieNum : " + revieNum);
			
			//등급별 테이블에 저장.
			map.put("reviewnum", map.get("num"));
			map.put("starranking", "0");
			ratingDao.insertRatingData(map);
			
			String ratingtype = (String)map.get("ratingtype");
			System.out.println("ratingtype : " + ratingtype);

			//찜,좋아요, 별등급 카운트 올리기.
			if(ratingtype.equals("01")) {
				map.put("recommend","01");
				
				//후기 상세 update
				communityDao.updateCommunityUpcount(map);
				
				//캠핑 or 관광지 테이블에 추천 카운트 올려주기.
				//System.out.println("revieNum:" + revieNum);
				if(revieNum != 0) {
					map.put("reviewnum", revieNum);
					communityDao.updateRecommend(map);
				}
				
			}else {
				map.put("steamed","02");
				communityDao.updateCommunityUpcount(map);
			}
		
			json.put("resultCode", "OK");
			json.put("resultMsg", "성공");
			
		} catch (Exception e) {
			json.put("resultCode", "ERROR");
			json.put("resultMsg", e.getMessage());
		}
		
		WebUtil.jsonSend(json, response);
	}
	
	//댓글 등록 JSONObject 로 처리.
	@RequestMapping(value = COMMAND_REPLY_REGISTER)
	public void doJsonReplyRegisert(HttpServletResponse response,
										CommunityReplyBean bean) throws Exception {
		
		JSONObject json = new JSONObject();
		
		try {
			
			if (bean.getContents() == null || bean.getContents().equals("")) {
				throw new Exception("댓글 입력하세요");
			}
			
			communityDao.insertCommunityReply(bean);

			json.put("resultCode", "OK");
			json.put("resultMsg", "성공");
			
		} catch (Exception e) {
			json.put("resultCode", "ERROR");
			json.put("resultMsg", e.getMessage());
		}
		
		WebUtil.jsonSend(json, response);
	}
	
	//댓글 삭제 JSONObject 로 처리.
	@RequestMapping(value = COMMAND_REPLY_DELETE)
	public void doJsonReplyDeletes(HttpServletResponse response,
								@RequestParam(value = "num") int num) throws Exception {
		
		JSONObject json = new JSONObject();
		
		try {
			
			communityDao.deleteCommunityReply(num);

			json.put("resultCode", "OK");
			json.put("resultMsg", "성공");
			
		} catch (Exception e) {
			json.put("resultCode", "ERROR");
			json.put("resultMsg", e.getMessage());
		}
		
		WebUtil.jsonSend(json, response);
	}
}
