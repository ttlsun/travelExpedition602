package user.users.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class UsersFindPwController {
	private final String COMMAND = "/usersFindPw.do";
	private final String GETPAGE = "common/findPwForm"; //views/common/findPwForm.jsp
	private final String GOTOPAGE = "login.do"; //redirect?
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value = COMMAND, method = RequestMethod.GET)
	public ModelAndView doGet(ModelAndView mav) {
		System.out.println(this.getClass()); //추후 삭제 가능
		mav.setViewName(GETPAGE);
		return mav;
	}
	
	@RequestMapping(value = COMMAND, method = RequestMethod.POST)
	public ModelAndView doPost(@Valid UsersBean users, BindingResult result, ModelAndView mav,
							   PrintWriter pw, HttpServletResponse response) throws IOException {
		System.out.println(this.getClass()); //추후 삭제 가능
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//id, email
		if(result.hasErrors()) {
			mav.setViewName(GETPAGE);
			pw.println("<script>alert('비밀번호 찾기에 실패했습니다');</script>");
		} else {
			UsersBean usersBean = usersDao.findPw(users);
			
			if(usersBean != null) {
				String name = users.getName();
				String dbpw = usersBean.getPw();
				
				mav.setViewName(GOTOPAGE);
				pw.println("<script>alert('비밀번호 찾기에 성공했습니다');</script>");
				pw.println("<script>alert('"+name+" 님의 비밀번호는 "+dbpw+" 입니다.');</script>");
			} else {
				mav.setViewName(GETPAGE);
				pw.println("<script>alert('비밀번호 찾기에 실패했습니다');</script>");
			}
		}
		pw.flush();
		
		return mav;
	}
}
