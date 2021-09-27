package com.my.travelExpedition.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("myAjaxApiAddrDao")
public class AddrDao {

	private static final String NAMESPACE = "com.my.travelExpedition.model.AddrBean";
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	public List<AddrBean> getSidoGugun(String addrType, String addrCode) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("addrType", addrType);
		map.put("addrCode", addrCode);
		
		List<AddrBean> lists = sqlSessionTemplate.selectList(NAMESPACE + ".getSidoGugun", map);
		
		System.out.println("list::" + lists.size());
		
		return new ArrayList<>();
	}
	
}
