package user.pay.controller;

import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.my.travelExpedition.utility.WebUtil;

import net.sf.json.JSONObject;
import user.pay.model.PayBean;
import user.pay.model.PayDao;
import user.users.model.UsersBean;

@Controller
public class PayDupCheckController {
	private static final String PAYCHECK = "/payDubCheck.do";
	
	@Autowired
	PayDao payDao;
	
	@RequestMapping(value=PAYCHECK, produces="application/text; charset=utf8")
	public void payCheck(HttpSession session, HttpServletResponse reponse, @RequestBody String paramData) throws Exception {
		System.out.println(this.getClass());
	
		UsersBean temp = (UsersBean) session.getAttribute("loginInfo");
		
		JSONObject json = new JSONObject();

		String selectVal = paramData.trim(); //한글은 unicode로 들어옴
		System.out.println(selectVal); //%uD734%uB300%uD3F0%uACB0%uC81C = 휴대폰결제
		
		//unicode to korean
		StringBuffer sb = new StringBuffer();
		for(int i=0; i<selectVal.length(); i++) {
			if('%' == selectVal.charAt(i) && 'u' == selectVal.charAt(i+1)) { //조합이 %u로 시작되면 6글자 변환 %uxxxx 
				Character r = (char) Integer.parseInt(selectVal.substring(i+2, i+6), 16);
				sb.append(r);
				
				i+=5;
			} else {
				sb.append(selectVal.charAt(i)); //ascii코드면 그대로 버퍼에 넣음
			}
		}
		selectVal = sb.toString();
		System.out.println(selectVal);
		
		//selectVal = selectVal.replace("=", "");
		//System.out.println(selectVal);
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("selectVal", selectVal);
		map.put("id", temp.getId());
		
		PayBean payBean = payDao.paycodeCheck(map);
		
		if(payBean != null) {
			json.put("resultCode", "-1");
		} else {
			json.put("resultCode", "0");
		}
		
		WebUtil.jsonSend(json, reponse);
	}
}
