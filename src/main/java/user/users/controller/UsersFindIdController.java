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
public class UsersFindIdController {
	private final String COMMAND = "/usersFindId.do";
	private final String GETPAGE = "common/findIdForm"; //views/common/findIdForm.jsp
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
		
		//name, email
		if(result.hasErrors()) {
			mav.setViewName(GETPAGE);
			pw.println("<script>alert('아이디 찾기에 실패했습니다');</script>");
		} else {
			UsersBean usersBean = usersDao.findId(users);
			
			if(usersBean != null) {
				String name = users.getName();
				String id = usersBean.getId();
				
				mav.setViewName(GOTOPAGE);
				pw.println("<script>alert('아이디 찾기에 성공했습니다');</script>");
				pw.println("<script>alert('"+name+" 님의 아이디는 "+id+" 입니다.');</script>");
			} else {
				mav.setViewName(GETPAGE);
				pw.println("<script>alert('아이디 찾기에 실패했습니다');</script>");
			}
		}
		pw.flush();
		
		return mav;
	}
}
