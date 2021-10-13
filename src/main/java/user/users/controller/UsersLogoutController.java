package user.users.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.users.model.UsersDao;

@Controller
public class UsersLogoutController {
	private final String COMMAND = "/logout.do";
	private final String LOGINALREADY = "redirect:/login.do";
	private final String GOTOPAGE = "redirect:/main.do";
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView doAction(ModelAndView mav, HttpSession session, HttpServletRequest request) {
		System.out.println(this.getClass()); //추후 삭제 가능
		
		//session.removeAttribute("loginInfo");
		session.invalidate();

		//System.out.println(request.getParameter("channel"));
		if(request.getParameter("channel") != null) {
			mav.setViewName(LOGINALREADY);
		} else {
			mav.setViewName(GOTOPAGE);
		}
		
		return mav;
	}
}
