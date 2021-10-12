package user.users.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import user.users.model.UsersDao;

@Controller
public class UsersLogoutController {
	private final String COMMAND = "/logout.do";
	private final String GOTOPAGE = "redirect:/main.do";
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value=COMMAND)
	public ModelAndView doAction(ModelAndView mav, HttpSession session) {
		System.out.println(this.getClass()); //추후 삭제 가능
		
		//session.removeAttribute("loginInfo");
		session.invalidate();
		
		mav.setViewName(GOTOPAGE);
		return mav;
	}
}
