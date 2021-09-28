package com.my.travelExpedition.model;

import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class SampleFileUploadBean {

	private MultipartFile imgFile; // 파일업로드 1개 (대표이미지명)
	private MultipartFile[] multipleImgFile; // 파일업로드 여러개

	public SampleFileUploadBean() {
	}

	public MultipartFile getImgFile() {
		return imgFile;
	}

	public void setImgFile(MultipartFile imgFile) {
		this.imgFile = imgFile;
	}

	public MultipartFile[] getMultipleImgFile() {
		
		return multipleImgFile;
	}
	
	public void setMultipleImgFile(MultipartFile[] multipleImgFile) {
		this.multipleImgFile = multipleImgFile;
		//System.out.println("imgMultipartFile size : " + multipleImgFile.length);
	}

	@Override
	public String toString() {
		return "CommunityBean [imgFile=" + imgFile + ", imgMultipartFile=" + Arrays.toString(multipleImgFile) + "]";
	}

}
