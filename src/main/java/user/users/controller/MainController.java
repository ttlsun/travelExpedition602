package user.users.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class MainController {

	public static final String COMMAND = "/main.do";
	public static final String GETPAGE = "user/main";
	
	@RequestMapping(value = COMMAND)
    public ModelAndView adminCommunityListView(HttpServletRequest request, @RequestParam Map<String, String> map) {
		
		ModelAndView mav = new ModelAndView(GETPAGE);
		
		return mav;
	}
	
}
