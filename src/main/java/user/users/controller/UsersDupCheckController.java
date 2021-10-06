package user.users.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class UsersDupCheckController {
	private final String IDCHECK = "/idDupCheck.do";
	private final String EMAILCHECK = "/emailDupCheck.do";
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value=IDCHECK, produces="text/plane")
	public String idCheck(@RequestBody String paramData) {
		System.out.println(this.getClass()); //추후 삭제 가능
		String id = paramData.trim();
		UsersBean usersBean = usersDao.idCheck(id);
		
		if(usersBean != null) {
			return "-1";
		} else {
			return "0";
		}
	}
	
	@RequestMapping(value=EMAILCHECK, produces="text/plane")
	public String emailCheck(@RequestBody String paramData) {
		System.out.println(this.getClass()); //추후 삭제 가능
		String email = paramData.trim();
		UsersBean usersBean = usersDao.emailCheck(email);
		
		if(usersBean != null) {
			return "-1";
		} else {
			return "0";
		}
	}
}

