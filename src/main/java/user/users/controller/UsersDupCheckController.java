package user.users.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.my.travelExpedition.utility.WebUtil;

import net.sf.json.JSONObject;
import user.users.model.UsersBean;
import user.users.model.UsersDao;

@Controller
public class UsersDupCheckController {
	private final String IDCHECK = "/idDupCheck.do";
	private final String EMAILCHECK = "/emailDupCheck.do";
	
	@Autowired
	UsersDao usersDao;
	
	@RequestMapping(value=IDCHECK, method=RequestMethod.POST)
	public void idCheck(HttpServletResponse reponse, @RequestBody String paramData) throws Exception {
		System.out.println(this.getClass()); //추후 삭제 가능
		
		JSONObject json = new JSONObject();	
		
		//System.out.println(paramData);
		String id = paramData.trim();
		//System.out.println("id: "+id);
		id = id.replace("=", "");
		//System.out.println("id: "+id);
		
		UsersBean usersBean = usersDao.idCheck(id);
		
		if(usersBean != null) {
			//System.out.println("usersBean id: "+usersBean.getId());
			json.put("resultCode", "-1");
		} else {
			//System.out.println("usersBean null");
			json.put("resultCode", "0");
		}
		
		WebUtil.jsonSend(json, reponse);
	}
	
	@RequestMapping(value=EMAILCHECK, method=RequestMethod.POST)
	public void emailCheck(HttpServletResponse reponse, @RequestBody String paramData) throws Exception {
		System.out.println(this.getClass()); //추후 삭제 가능
		
		JSONObject json = new JSONObject();	
		
		//System.out.println(paramData);
		String email = paramData.trim();
		//System.out.println(email);
		email = email.replace("=", "");
		email = email.replace("%40", "@");
		//System.out.println(email);
		UsersBean usersBean = usersDao.emailCheck(email);
		
		if(usersBean != null) {
			//System.out.println("usersBean email: "+usersBean.getEmail());
			json.put("resultCode", "-1");
		} else {
			//System.out.println("usersBean null");
			json.put("resultCode", "0");
		}
		
		WebUtil.jsonSend(json, reponse);
	}
}

