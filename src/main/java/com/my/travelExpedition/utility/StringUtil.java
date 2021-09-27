package com.my.travelExpedition.utility;

import java.io.UnsupportedEncodingException;

public class StringUtil {

	/**
	 * 문자열을 바이트 단위로 substring하기
	 *
	 * new String(str.getBytes(), 0, endBytes) 코드를 사용하면
	 * 한글 바이트에 딱 맞춰 자르지 않는 경우 깨지는 문제가 있어서 따로 메서드를 만들었다.
	 *
	 * UTF-8 기준 한글은 3바이트, 알파벳 대소문자나 숫자 및 띄어쓰기는 1바이트로 계산된다.
	 *
	 * @param str
	 * @param beginBytes
	 * @param endBytes
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public static String substringByBytes(String str, int beginBytes, int endBytes) throws UnsupportedEncodingException {
	    if (str == null || str.length() == 0) {
	        return "";
	    }

	    if (beginBytes < 0) {
	        beginBytes = 0;
	    }

	    if (endBytes < 1) {
	        return "";
	    }

	    int len = str.length();

	    int beginIndex = -1;
	    int endIndex = 0;

	    int curBytes = 0;
	    String ch = null;
	    for (int i = 0; i < len; i++) {
	        ch = str.substring(i, i + 1);
	        curBytes += ch.getBytes("UTF-8").length;
	 

	        if (beginIndex == -1 && curBytes >= beginBytes) {
	            beginIndex = i;
	        }

	        if (curBytes > endBytes) {
	            break;
	        } else {
	            endIndex = i + 1;
	        }
	    }
	 
	    return str.substring(beginIndex, endIndex);
	}
}
