package com.my.travelExpedition.utility;

import java.io.File;
import java.io.PrintWriter;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileUploadException;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.multipart.MultipartFile;

import net.sf.json.JSONObject;

public class WebUtil {
	
	private static final String UPLOADEDFILE = "/resources/images/uploaded_file"; //업로드파일위치.
	
	/**
	 * 파일 업로드
	 * @param servlet
	 * @param multipartFile
	 * @return
	 * @throws Exception
	 */
	public static String fileUpload(ServletContext servlet, MultipartFile multipartFile) throws Exception {
		return fileUpload(servlet, multipartFile, null);
	}
	
	
	public static String[] deletefileUpload(ServletContext servlet, String dbfileName) throws Exception {
		// 원본 파일 있으면 삭제
		if (dbfileName != null && !dbfileName.equals("")) {
			String uploadPath = servlet.getRealPath(UPLOADEDFILE);
			
			File dbFile = new File(uploadPath + "/" + dbfileName);
			dbFile.delete();
		}
		return null;
	}
	
	public static String[] deletefileUpload(ServletContext servlet, String[] dbfileName) throws Exception {
		// 원본 파일 있으면 삭제
		if (dbfileName != null && dbfileName.length > 0) {
			String uploadPath = servlet.getRealPath(UPLOADEDFILE);
			
			for (int i = 0; i < dbfileName.length; i++) {
				File dbFile = new File(uploadPath + "/" + dbfileName[i]);
				dbFile.delete();
			}
		}
		return null;
	}
	
	public static String[] fileUpload(ServletContext servlet, MultipartFile[] multipartFile, String[] dbfileName) throws Exception {
		// 원본 파일 있으면 삭제
		if (dbfileName != null && dbfileName.length > 0) {
			String uploadPath = servlet.getRealPath(UPLOADEDFILE);
			
			for (int i = 0; i < dbfileName.length; i++) {
				File dbFile = new File(uploadPath + "/" + dbfileName[i]);
				dbFile.delete();
			}
		}
		
		if (multipartFile == null) {
			System.out.println("multipartFile null");
			return new String[0];
		}
		
		System.out.println("multipartFile:::" + multipartFile.length);
		String[] fileNames = new String[multipartFile.length];
		
		for (int i = 0; i < multipartFile.length; i++) {
			System.out.println(i + ":" + multipartFile[i].getOriginalFilename());
			fileNames[i] = fileUpload(servlet, multipartFile[i], null);
		}
		return fileNames;
	}
	
	public static String fileUpload(ServletContext servlet, MultipartFile multipartFile, String dbfileName) throws Exception {
		// 수정화면에서 파일을 선택하지 않았을때 기존 파일명 리턴
		
		//System.out.println("multipartFile : " + multipartFile.getSize()) ;
		if (multipartFile == null || multipartFile.getSize() == 0)
			return dbfileName;
		
		try {
			
			String uploadPath = servlet.getRealPath(UPLOADEDFILE);
			System.out.println("uploadPath : " + uploadPath);

			File folder = new File(uploadPath);
			
			// 해당 디렉토리가 없을경우 디렉토리를 생성합니다.
			if (!folder.exists()) {
				folder.mkdir(); //폴더 생성합니다.
			}
			
			// 원본 파일 있으면 삭제
			if (dbfileName != null && !dbfileName.equals("")) {
				File dbFile = new File(uploadPath + "/" + dbfileName);
				dbFile.delete();
			}
			
			String fileName = multipartFile.getOriginalFilename();
			int pos = fileName.lastIndexOf(".");
			String exec = fileName.substring(pos + 1);
			fileName = fileName.substring(0, pos);
			
//			System.out.println("확장자:" + exec);
			switch (exec.toLowerCase()) {
				case "jpg": case "jpeg": case "gif": case "png": case "pdf":
					break;
				default:
					throw new FileUploadException("업로드할 수 없는 파일 형식 입니다");
			}
			
			//currentTimeMillis 
			fileName = System.currentTimeMillis() + "_" + fileName;
			// 최대 30-4(.확장자) byte 까지 짜르기
			fileName = StringUtil.substringByBytes(fileName, 0, 26) + "." + exec;
			
			File upload = new File(uploadPath+"\\"+ fileName);
			multipartFile.transferTo(upload);
			
			return fileName;
		} catch (Exception e) {
			throw e;
		}
	}
	
	/**
	 * 결과 데이터 전송
	 * @param json
	 * @param response
	 * @throws Exception
	 */
	public static void jsonSend(JSONObject json, HttpServletResponse response) throws Exception {
		PrintWriter print = response.getWriter();
		print.print(json.toString());
		print.flush();
	}
	
	/**
	 * Error 목록을 MessageSource 라이브러리를 사용하여 텍스트로 변형
	 * @param result
	 */
	public static void resultErrorConvert(BindingResult result) {
		System.out.println("----------- Error Start -----------");
		for (FieldError error : result.getFieldErrors()) {
			System.out.println(error.getField() + ":" + error.getCode() + ":" + ":" + error.getDefaultMessage());
//			result.rejectValue(error.getField(), error.getCode(), MessageUtils.getMessage(error));
//			result.rejectValue(error.getCode(), "aaa");
		}
		System.out.println("----------- Error End -----------");
	}
	
	/**
	 * Error 목록에서 특정 필드를 제외시킴 
	 * @param result
	 * @param fieldName
	 * @return true:모두제외 false:제외목록없음
	 */
	public static boolean isResultErrorIgnore(BindingResult result, String[] fieldName) {
		System.out.println("----------- Error Start -----------");
		for (FieldError error : result.getFieldErrors()) {
			System.out.println(error.getField() + ":" + error.getCode() + ":" + ":" + error.getDefaultMessage());
			
			boolean isIgnore = false;
			for (String field : fieldName) {
				if (field.equals(error.getField())) {
					isIgnore = true;
					break;
				}
			}
			
			if (isIgnore) {
				System.out.println(error.getField() + " 제외");
				continue;
			}
			
			return false;
		}
		System.out.println("----------- Error End -----------");
		
		return true;
	}
	
	
}
