package user.pay.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.my.travelExpedition.utility.Paging;

import user.pay.model.PayBean;
import user.pay.model.PayDao;
import user.users.model.UsersBean;

@Controller
public class PayListController {
	private static final String COMMAND = "/payList.do";
	private static final String GETPAGE = "user/pay/payList";
	private static final String GETPAGEBUSINESS = "user/pay/payBusinessList";
	private static final String GETPAGEELSE = "redirect:/main.do";
	
	@Autowired
	private PayDao payDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView doAction(ModelAndView mav, HttpServletRequest request, HttpSession session,
			@RequestParam(value="whatColumn", required=false) String whatColumn,
			@RequestParam(value="keyword", required=false) String keyword,
			@RequestParam(value="pageNumber", required=false) String pageNumber) {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
		if(temp.getUcode().equals("admin") || temp.getUcode() == null) {
			//admin이 접근시도할 경우 접근 불가
			mav.setViewName(GETPAGEELSE);
		} else {
			Map<String, String> map = new HashMap<String, String>();
			map.put("whatColumn", whatColumn);
			map.put("keyword", "%"+keyword+"%");
			map.put("id", temp.getId());
			int totalCount = payDao.getTotalCount(map);
			String url = request.getContextPath()+COMMAND;
			
			Paging pageInfo = new Paging(pageNumber, "10", totalCount, url, whatColumn, keyword);
			List<PayBean> lists = payDao.getList(pageInfo, map);
			
			mav.addObject("pageNumber", pageNumber);
			mav.addObject("totalCount", totalCount);
			mav.addObject("pageInfo", pageInfo);
			mav.addObject("lists", lists);
			
			if(temp.getUcode().equals("business")){
				//business가 접근시도할 경우
				mav.setViewName(GETPAGEBUSINESS);
			} else {
				//customer가 접근시도할 경우
				mav.setViewName(GETPAGE);
			}
		}
		return mav;
	}
}
