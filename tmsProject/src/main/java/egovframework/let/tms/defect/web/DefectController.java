package egovframework.let.tms.defect.web;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collection;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.mysql.jdbc.Blob;

import egovframework.let.tms.defect.service.DefectDefaultVO;
import egovframework.let.tms.defect.service.DefectFileVO;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.let.tms.defect.service.DefectVO;
import egovframework.let.tms.pg.service.PgCurrentVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import net.sf.json.JSONArray;

@Controller
public class DefectController {

	/** DefectService */
	@Resource (name = "defectService")
	private DefectService defectService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	/**
	 * 전체 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 DefectDefaultVO
	 * @param model
	 * @return "DefectList"
	 * @exception Exception
	 */
	@RequestMapping("/tms/defect/selectDefect.do")
	public String selectDefect(@ModelAttribute("searchVO") DefectDefaultVO searchVO, ModelMap model) throws Exception {
	
		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");

		if(searchVO.getSearchByStartDt() != null) {
			String ST_date=formatter.format(searchVO.getSearchByStartDt());
			model.addAttribute("ST_date", ST_date);
		}
		
		if(searchVO.getSearchByEndDt() != null) {
			String EN_date=formatter.format(searchVO.getSearchByEndDt());
			model.addAttribute("EN_date", EN_date);			
		}
		
		List<?> list = defectService.selectDefect(searchVO);
		model.addAttribute("defectList", list);
		
		int totCnt = defectService.selectDefectTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> taskGbList = defectService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> actionStList = defectService.selectActionSt();
		model.addAttribute("actionSt", actionStList);
		
		return "tms/defect/defectList";
	}
	
	
	/** 결함 등록 페이지로 이동 */
	@RequestMapping("/tms/defect/insertDefect.do")
	public String insertDefect(ModelMap model){
		int defectIdSq = defectService.selectDefectIdSq();
		defectIdSq = defectIdSq + 1;
		model.addAttribute("defectIdSq", defectIdSq);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		return "tms/defect/defectRegist";
	}
	
	/** 결함 등록 
	 * @throws IOException */
	@RequestMapping("/tms/defect/insertDefectImpl.do")
	public String insertDefectImpl(MultipartHttpServletRequest mtpRequest,@ModelAttribute("defectVO") DefectVO defectVO) throws IOException {
		MultipartFile defectFileImg = mtpRequest.getFile("fileImg");
		if(defectFileImg.getOriginalFilename() == "") {
			defectService.insertDefect(defectVO);
		} else { // 파일 이미지를 등록했을 경우
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("FILE_IMG", defectFileImg.getBytes());
			hmap.put("FILE_SIZE",defectFileImg.getSize());
			hmap.put("FILE_NM", defectFileImg.getOriginalFilename());
			hmap.put("DEFECT_ID_SQ", defectVO.getDefectIdSq());
			hmap.put("DEFECT_TITLE", defectVO.getDefectTitle());
			hmap.put("DEFECT_CONTENT", defectVO.getDefectContent());
			hmap.put("PG_ID", defectVO.getPgId());
			hmap.put("USER_TEST_ID", defectVO.getUserTestId());
			hmap.put("DEFECT_GB", defectVO.getDefectGb());
			hmap.put("ENROLL_DT", defectVO.getEnrollDt());
			hmap.put("ACTION_CONTENT", defectVO.getActionContent());
			hmap.put("ACTION_ST", defectVO.getActionSt());
			hmap.put("ACTION_DT", defectVO.getActionDt());
			hmap.put("status", 0);
			defectService.insertDefectImageMap(hmap);
			
		}	
		return "redirect:/tms/defect/selectDefect.do";
	}
	
	/** 결함 상세 조회*/
	@RequestMapping("/tms/defect/selectDefectInfo.do")
	public String selectDefectInfo(@ModelAttribute("defectVO") DefectVO defectVO, ModelMap model) throws Exception {
		List<?> list = defectService.selectOneDefect(defectVO);
		model.addAttribute("defectOne", list);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		List<?> actionStList = defectService.selectActionSt();
		model.addAttribute("actionSt", actionStList);
		
		DefectFileVO defectImgOne = defectService.selectDefectImgOne(defectVO.getDefectIdSq());
		model.addAttribute("defectImgOne", defectImgOne);
		
		
		return "tms/defect/defectListOne";
	}
	
	/** 결함조치 수정*/
	@RequestMapping("/tms/defect/updateDefect.do")
	public String updateDefect(HttpServletRequest request,@ModelAttribute("defectVO") DefectVO defectVO, ModelMap model) throws Exception{
		int result = defectService.updateDefect(defectVO);
		MultipartHttpServletRequest mtpRequest = (MultipartHttpServletRequest) request;
		MultipartFile defectFileImg = mtpRequest.getFile("fileImg");
		
		if(defectService.selectDefectIdSqToFileTb(defectVO.getDefectIdSq()) == 0 && defectFileImg.getSize() != 0) {
			Map<String, Object> hmap = new HashMap<String, Object>();
			hmap.put("FILE_IMG", defectFileImg.getBytes());
			hmap.put("FILE_SIZE",defectFileImg.getSize());
			hmap.put("FILE_NM", defectFileImg.getOriginalFilename());
			hmap.put("DEFECT_ID_SQ", defectVO.getDefectIdSq());
			hmap.put("status", 1);
			defectService.insertDefectImageMap(hmap);
		}

		List<?> list = defectService.selectOneDefect(defectVO);
		model.addAttribute("defectOne", list);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		List<?> actionStList = defectService.selectActionSt();
		model.addAttribute("actionSt", actionStList);
		
		DefectFileVO defectImgOne = defectService.selectDefectImgOne(defectVO.getDefectIdSq());
		model.addAttribute("defectImgOne", defectImgOne);
		
		return "tms/defect/defectListOne";
	}	
	
	/** 결함조치 삭제 */
	@RequestMapping("/tms/defect/deleteDefect.do")
	public String deleteDefect(@ModelAttribute("defectVO") DefectVO defectVO, ModelMap model) {
		int result = defectService.deleteDefect(defectVO);
		return "redirect:/tms/defect/selectDefect.do";
	}
	
	/**  결함처리 현황 */
	@RequestMapping("/tms/defect/selectDefectCurrent.do")
	public String selectDefectCurrent(@ModelAttribute("searchVO") DefectDefaultVO searchVO, ModelMap model) throws Exception {

		/** EgovPropertyService.sample */
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing setting */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		SimpleDateFormat formatter=new SimpleDateFormat("yyyy-MM-dd");
		
		if(searchVO.getSearchByStartDt() != null) {
			String ST_date=formatter.format(searchVO.getSearchByStartDt());
			model.addAttribute("ST_date", ST_date);
		}
		
		if(searchVO.getSearchByEndDt() != null) {
			String EN_date=formatter.format(searchVO.getSearchByEndDt());
			model.addAttribute("EN_date", EN_date);			
		}
		
		List<?> list = defectService.selectDefect(searchVO);
		model.addAttribute("defectList", list);
		
		int totCnt = defectService.selectDefectTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> taskGbList = defectService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> actionStList = defectService.selectActionSt();
		model.addAttribute("actionSt", actionStList);
		
		int actionComplete = defectService.selectActionComplete(searchVO);
		model.addAttribute("actionTotCnt",totCnt);
		model.addAttribute("actionComplete",actionComplete);
		
		return "tms/defect/defectListCurrent";
	}
	
	/** 결함 파일 보여주기
	 * @throws IOException */
	@RequestMapping("/tms/defect/selectDefectImg.do")
	public ResponseEntity<byte[]> selectDefectImg(HttpServletRequest request){
		String defectIdSq = request.getParameter("defectIdSq");
		Map<String, Object> map = defectService.selectDefectImg(defectIdSq);
		byte[] imageContent = (byte[])map.get("FILE_IMG");
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_JPEG);
		return new ResponseEntity<byte[]>(imageContent, headers, HttpStatus.OK);
		
	}
	
	/** 결함 파일 다운로드 */
	@RequestMapping("/tms/defect/downloadDefectImg.do")
	public void downloadDefectImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String defectIdSq = request.getParameter("defectIdSq");
		Map<String, Object> map = defectService.downloadDefectImg(defectIdSq);
		String fileNm = (String)map.get("FILE_NM");
		SerialBlob blob = new javax.sql.rowset.serial.SerialBlob((byte[]) map.get("FILE_IMG"));
		InputStream inStream = blob.getBinaryStream();
		response.setContentType("application/octet-stream");
		ServletOutputStream outStream = response.getOutputStream();
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(fileNm,"UTF-8")+"\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		try{
			byte buffer[] = new byte[204800];
			int bytesRead =0;
			while((bytesRead = inStream.read(buffer)) != -1) {
				outStream.write(buffer,0,bytesRead);
			}
			inStream.close();
		}catch (IOException e) {
			System.out.println(e.toString());
		}
	     
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	}
	
	/** 파일 이미지 삭제
	 * @throws Exception */
	@RequestMapping("/tms/defect/deleteDefectImg.do")
	public String deleteDefectImg(@ModelAttribute ("defectVO") DefectVO defectVO, ModelMap model ) throws Exception {
		defectService.deleteDefectImg(defectVO.getDefectIdSq());
		List<?> list = defectService.selectOneDefect(defectVO);
		model.addAttribute("defectOne", list);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		List<?> actionStList = defectService.selectActionSt();
		model.addAttribute("actionSt", actionStList);
		
		DefectFileVO defectImgOne = defectService.selectDefectImgOne(defectVO.getDefectIdSq());
		model.addAttribute("defectImgOne", defectImgOne);
		return "tms/defect/defectListOne";
	}
	
	/** 결함처리통계(그래프) */
	@RequestMapping("/tms/defect/selectDefectStats.do")
	public String selectDefectStats(ModelMap model) throws Exception {
		
		HashMap<String, Object> map = defectService.selectDefectStats();
		model.addAttribute("defectStats",map);
		
		// 일자별 결함 등록 건수, 조치건수
		List<?> dayByDefectCnt = defectService.selectDayByDefectCnt();
		model.addAttribute("dayByDefectCnt", dayByDefectCnt);
		
		// 월별 결함 등록건수, 조치건수
		List<?> monthByDefectCnt = defectService.selectMonthByDefectCnt();
		model.addAttribute("monthByDefectCnt", monthByDefectCnt);
		
		// 업무별 조치율
		List<?> taskByActionProgression = defectService.selectTaskByActionProgression();
//		model.addAttribute("taskByActionProgression", taskByActionProgression);
		model.addAttribute("taskByActionProgression", JSONArray.fromObject(taskByActionProgression));
		
		// 업무별 상태별 결함건수
		List<?> taskByActionStCnt = defectService.selectTaskByActionStCnt();
		model.addAttribute("taskByActionStCnt", JSONArray.fromObject(taskByActionStCnt));
		
		// 업무별 유형별 결함 건수
		List<?> taskByDefectGbCnt = defectService.selectTaskByDefectGbCnt();
		model.addAttribute("taskByDefectGbCnt", taskByDefectGbCnt);
		
		return "tms/defect/defectStats";
	}
	
	@RequestMapping("/tms/defect/selectDefectStatsList.do")
	public String selectDefectStatsList(ModelMap model){
		List<String> taskGbList = defectService.selectTaskGbByDefect();
		List<HashMap<String,String>> taskGbByStats = new ArrayList<HashMap<String,String>>();
		for(int i=0; i<taskGbList.size(); i++) {
			taskGbByStats.addAll(defectService.selectTaskByStats(taskGbList.get(i).toString()));
		}
		
		List<String> pgIdList = defectService.selectPgIdByDefect();
		List<HashMap<String,String>> pgIdByStats = new ArrayList<HashMap<String,String>>();
		for (int i=0; i<pgIdList.size(); i++) {
			pgIdByStats.addAll(defectService.selectPgByStats(pgIdList.get(i).toString()));
		}

		List<String> userTestList = defectService.selectUserTestIdByDefect();
		List<HashMap<String,String>> userTestByStats = new ArrayList<HashMap<String,String>>();
		for (int i=0; i<userTestList.size(); i++) {
			userTestByStats.addAll(defectService.selectUserTestByStats(userTestList.get(i).toString()));
		}

		List<String> userDevList = defectService.selectUserDevIdByDefect();
		List<HashMap<String,String>> userDevByStats = new ArrayList<HashMap<String,String>>();
		for (int i=0; i<userDevList.size(); i++) {
			userDevByStats.addAll(defectService.selectUserDevByStats(userDevList.get(i).toString()));
		}
		
		model.addAttribute("taskGbByStats",taskGbByStats);
		model.addAttribute("pgIdByStats",pgIdByStats);
		model.addAttribute("userTestByStats",userTestByStats);
		model.addAttribute("userDevByStats",userDevByStats);
		return "tms/defect/defectStatsList";
	}
	
	/** 통계 엑셀 다운로드 기능 */
	@RequestMapping(value = "/tms/defect/StatsToExcel.do")
	public String StatsToExcel(@RequestParam("statsGb") String statsGb, ModelMap model) {
		
		List<String> taskGbList = defectService.selectTaskGbByDefect();
		List<HashMap<String,String>> taskGbByStats = new ArrayList<HashMap<String,String>>();
		for(int i=0; i<taskGbList.size(); i++) {
			taskGbByStats.addAll(defectService.selectTaskByStats(taskGbList.get(i).toString()));
		}

		List<String> pgIdList = defectService.selectPgIdByDefect();
		List<HashMap<String,String>> pgIdByStats = new ArrayList<HashMap<String,String>>();
		for (int i=0; i<pgIdList.size(); i++) {
			pgIdByStats.addAll(defectService.selectPgByStats(pgIdList.get(i).toString()));
		}
		
		List<String> userTestList = defectService.selectUserTestIdByDefect();
		List<HashMap<String,String>> userTestByStats = new ArrayList<HashMap<String,String>>();
		for (int i=0; i<userTestList.size(); i++) {
			userTestByStats.addAll(defectService.selectUserTestByStats(userTestList.get(i).toString()));
		}
		
		List<String> userDevList = defectService.selectUserDevIdByDefect();
		List<HashMap<String,String>> userDevByStats = new ArrayList<HashMap<String,String>>();
		for (int i=0; i<userDevList.size(); i++) {
			userDevByStats.addAll(defectService.selectUserDevByStats(userDevList.get(i).toString()));
		}
		
		if(statsGb.equals("task")) {
			System.out.println("############################1");
			xlsxWiter(taskGbByStats, statsGb);
			System.out.println("############################end");
		} else if(statsGb.equals("pg")) {
			xlsxWiter(pgIdByStats, statsGb);
		} else if(statsGb.equals("userTest")) {
			xlsxWiter(userTestByStats, statsGb);
		} else {
			xlsxWiter(userDevByStats, statsGb);
		}
		
		model.addAttribute("taskGbByStats",taskGbByStats);
		model.addAttribute("pgIdByStats",pgIdByStats);
		model.addAttribute("userTestByStats",userTestByStats);
		model.addAttribute("userDevByStats",userDevByStats);
		return "tms/defect/defectStatsList";
	}
	
	public void xlsxWiter(List<HashMap<String,String>> list, String statsGb) {
		System.out.println("############################2");
		// 워크북 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// 워크시트 생성
		XSSFSheet sheet = workbook.createSheet();
		// 행 생성
		XSSFRow row = sheet.createRow(0);
		// 쎌 생성
		XSSFCell cell;
		
		// 헤더 정보 구성
		cell = row.createCell(0);
		cell.setCellValue("구분");
		
		cell = row.createCell(1);
		cell.setCellValue("상태/유형별");
		
		cell = row.createCell(2);
		cell.setCellValue("오류");
		
		cell = row.createCell(3);
		cell.setCellValue("개선");
		
		cell = row.createCell(4);
		cell.setCellValue("문의");
		
		cell = row.createCell(5);
		cell.setCellValue("기타");
		
		cell = row.createCell(6);
		cell.setCellValue("합계");
		System.out.println("############################3");
		// 리스트의 size 만큼 row를 생성
		System.out.println("###########################"+list.toString());
		
		
		for(int i=0; i < list.size(); i++) {
			System.out.println("############################4");
			System.out.println("############################"+list.get(i));
			
			// 행 생성
//			row = sheet.createRow(i+1);
//			
//			cell = row.createCell(0);
//			cell.setCellValue(list.get(i).get("taskNm"));
//			System.out.println("######################"+list.get(i).get("taskNm"));
//			cell = row.createCell(1);
//			cell.setCellValue(list.get(i).get("actionNm"));
//			
//			cell = row.createCell(2);
//			cell.setCellValue(list.get(i).get("defectGbD1"));
//			
//			cell = row.createCell(3);
//			cell.setCellValue(list.get(i).get("defectGbD2"));
//			
//			cell = row.createCell(4);
//			cell.setCellValue(list.get(i).get("defectGbD3"));
//			
//			cell = row.createCell(5);
//			cell.setCellValue(list.get(i).get("defectGbD4"));
//			
//			cell = row.createCell(6);
//			cell.setCellValue(list.get(i).get("rowSum"));
			
		}
//		
//		// 입력된 내용 파일로 쓰기
//		File folder = new File("C:\\TMS\\TMS_통계자료");
//		
//		File file = new File("C:\\TMS\\TMS_통계자료\\프로그램 현황.xlsx");
//		
//		if(!folder.exists()){
//            //디렉토리 생성 메서드
//			folder.mkdirs();
//		}
//		
//		FileOutputStream fos = null;
//		
//		try {
//			fos = new FileOutputStream(file);
//			workbook.write(fos);
//		} catch (FileNotFoundException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if(workbook!=null) //workbook.close();
//				if(fos!=null) fos.close();
//				
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			}
//		}
	}
	
}
