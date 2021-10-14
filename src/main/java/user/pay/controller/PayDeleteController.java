package user.pay.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import user.pay.model.PayDao;

@Controller
public class PayDeleteController {
	private static final String COMMAND = "/payDelete.do";
	
	@Autowired
	private PayDao payDao;
	
	@RequestMapping(value=COMMAND)
	public void doAction(PrintWriter pw, HttpServletResponse response, HttpServletRequest request) throws IOException{
		System.out.println(this.getClass()+" "+request.getMethod()); //추후 삭제 가능
		
		pw = response.getWriter();
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		int num = Integer.parseInt(request.getParameter("num"));
		int cnt = -1;
		cnt = payDao.deletePay(num);
		
		if(cnt != -1) {
			pw.println("<script>alert('선택한 결제수단을 삭제했습니다'); location.replace('payList.do');</script>");
		} else{
			pw.println("<script>alert('선택한 결제수단을 삭제하지 못했습니다'); history.go(-1);</script>");
		}
		pw.flush();
		
		return;
	}
}
