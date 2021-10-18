package admin.users.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import user.users.model.UsersDao;

@Controller
public class AdminUsersDeleteController {
	private static final String COMMAND = "/usersDelete.ad";
	
	@Autowired
	private UsersDao usersDao;
	
	@RequestMapping(value=COMMAND)
	public void doPost(PrintWriter pw, HttpServletResponse response, HttpServletRequest request) throws IOException {
		System.out.println(this.getClass()+" "+request.getMethod());
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int num = Integer.parseInt(request.getParameter("num"));
		
		int cnt = -1;
		cnt = usersDao.deleteUsers(num);
		
		if(cnt != -1) {
			pw.println("<script>alert('회원 정보 삭제가 완료되었습니다'); location.replace('usersList.ad');</script>");
		} else {
			pw.println("<script>alert('회원 정보 삭제에 실패했습니다'); history.go(-1);</script>");
		}
		pw.flush();
		
		return;
	}
}
