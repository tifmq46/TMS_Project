package egovframework.let.tms.defect.service;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

public class DefectFileVO {
	
	private MultipartFile fileImg;
	
	private int fileIdSq = 0;
	
	private int defectIdSq;
	
	private String fileNm;
	
	private int fileSize;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date fileEnrollDt;

	public int getFileIdSq() {
		return fileIdSq;
	}

	public void setFileIdSq(int fileIdSq) {
		this.fileIdSq = fileIdSq;
	}

	public int getDefectIdSq() {
		return defectIdSq;
	}

	public void setDefectIdSq(int defectIdSq) {
		this.defectIdSq = defectIdSq;
	}

	public String getFileNm() {
		return fileNm;
	}

	public void setFileNm(String fileNm) {
		this.fileNm = fileNm;
	}

	public int getFileSize() {
		return fileSize;
	}

	public void setFileSize(int fileSize) {
		this.fileSize = fileSize;
	}

	public Date getFileEnrollDt() {
		return fileEnrollDt;
	}

	public void setFileEnrollDt(Date fileEnrollDt) {
		this.fileEnrollDt = fileEnrollDt;
	}

	public MultipartFile getFileImg() {
		return fileImg;
	}

	public void setFileImg(MultipartFile fileImg) {
		this.fileImg = fileImg;
	}

	@Override
	public String toString() {
		return "DefectFileVO [fileIdSq=" + fileIdSq + ", defectIdSq=" + defectIdSq + ", fileNm=" + fileNm
				+ ", fileSize=" + fileSize + ", fileEnrollDt=" + fileEnrollDt + "]";
	}
	
	
}
