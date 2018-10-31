package egovframework.let.tms.defect.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialBlob;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.util.CellRangeAddress;
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
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.com.cmm.LoginVO;
import egovframework.let.tms.defect.service.DefectDefaultVO;
import egovframework.let.tms.defect.service.DefectFileVO;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.let.tms.defect.service.DefectVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.fdl.security.userdetails.util.EgovUserDetailsHelper;
import egovframework.rte.psl.dataaccess.util.EgovMap;
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
		LoginVO user = (LoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		searchVO.setSessionId(user.getName());
		searchVO.setUniqId(user.getUniqId());
		
		
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
		
		List<?> list = defectService.selectDefect(searchVO,0);
		model.addAttribute("defectList", list);
		
		int totCnt = defectService.selectDefectTotCnt(searchVO,0);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
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
	public String insertDefect(HttpServletRequest request,ModelMap model){
		int defectIdSq = defectService.selectDefectIdSq();
		defectIdSq = defectIdSq + 1;
		model.addAttribute("defectIdSq", defectIdSq);
		
		String testscenarioId = request.getParameter("testscenarioId");
		model.addAttribute("testscenarioId", testscenarioId);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		return "tms/defect/defectRegist";
	}
	
	/** 결함 등록 
	 * @throws IOException */
	@RequestMapping("/tms/defect/insertDefectImpl.do")
	public String insertDefectImpl(MultipartHttpServletRequest mtpRequest,@ModelAttribute("defectVO") DefectVO defectVO, BindingResult errors) throws IOException {
		beanValidator.validate(defectVO, errors);
		if(errors.hasErrors()){
			return "redirect:/tms/defect/selectDefect.do"; 
		} else {
			MultipartFile defectFileImg = mtpRequest.getFile("fileImg");
			String userTestId = defectService.selectUserNm(defectVO.getUserNm());
			if(defectFileImg.getOriginalFilename() == "") {
				defectVO.setUserTestId(userTestId);
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
				hmap.put("USER_TEST_ID", userTestId);
				hmap.put("DEFECT_GB", defectVO.getDefectGb());
				hmap.put("ENROLL_DT", defectVO.getEnrollDt());
				hmap.put("ACTION_CONTENT", defectVO.getActionContent());
				hmap.put("ACTION_ST", defectVO.getActionSt());
				hmap.put("ACTION_DT", defectVO.getActionDt());
				hmap.put("TESTSCENARIO_ID", defectVO.getTestscenarioId());
				hmap.put("status", 0);
				defectService.insertDefectImageMap(hmap);
				  
			}	
			return "redirect:/tms/defect/selectDefect.do";
		}
		
	}
	
	/** 결함 상세 조회*/
	@RequestMapping("/tms/defect/selectDefectInfo.do")
	public String selectDefectInfo(@ModelAttribute("defectVO") DefectVO defectVO,ModelMap model) throws Exception {
		
		model.addAttribute("boardNo", defectVO.getBoardNo());
		
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
		String userTestId = defectService.selectUserNm(defectVO.getUserNm());
		defectVO.setUserTestId(userTestId);
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
		model.addAttribute("boardNo", defectVO.getBoardNo());
		
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
		
		List<?> list = defectService.selectDefect(searchVO,1);
		model.addAttribute("defectList", list);
		
		int totCnt = defectService.selectDefectTotCnt(searchVO,1);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		List<?> taskGbList = defectService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<?> defectGbList = defectService.selectDefectGb();
		model.addAttribute("defectGb", defectGbList);
		
		List<?> actionStList = defectService.selectActionSt();
		model.addAttribute("actionSt", actionStList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		int actionComplete = defectService.selectActionComplete(searchVO);
		model.addAttribute("actionTotCnt",totCnt);
		model.addAttribute("actionComplete",actionComplete);
		
		return "tms/defect/defectListCurrent";
	}
	
	/** 결함 파일 창으로 이동 */
	@RequestMapping("/tms/defect/selectListOneDetail.do")
	public String selectDefectImgAlert(HttpServletRequest request, ModelMap model){
		String defectIdSq = request.getParameter("defectIdSq");
		model.addAttribute("defectIdSq", defectIdSq);
		return "tms/defect/defectListOneDetail";
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
		
		model.addAttribute("boardNo", defectVO.getBoardNo());
		
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
	
	/** 결함처리통계(그래프) - 대시보드1 */
	@RequestMapping("/tms/defect/selectDefectStats.do")
	public String selectDefectStats(ModelMap model) throws Exception {
		
		HashMap<String, Object> map = defectService.selectDefectStats();
		model.addAttribute("defectStats",map);
		
		// 일자별 결함 등록 건수, 조치건수
		List<?> dayByDefectCnt = defectService.selectDayByDefectCnt();
		model.addAttribute("dayByDefectCnt", JSONArray.fromObject(dayByDefectCnt));
		
		// 사용자별 결함건수
		List<?> userByDefectCnt = defectService.selectUserByDefectCnt();
		model.addAttribute("userByDefectCnt", JSONArray.fromObject(userByDefectCnt));
				
		return "tms/defect/defectStats";
	}
	
	/** 결함처리통계(그래프) - 대시보드2 */
	@RequestMapping("/tms/defect/selectDefectStatsByDefectCnt.do")
	public String selectDefectStatsByDefectCnt(ModelMap model) throws Exception {
		
		String sysNm = "전체";
		List<EgovMap> egovList = new ArrayList<EgovMap>();
		List<EgovMap> sysByDefectCntAll = defectService.selectSysByDefectCntAll();
		egovList.addAll(sysByDefectCntAll);
		
		// 시스템별 결함 건수
		List<EgovMap> sysByDefectCntPart = defectService.selectSysByDefectCnt();
		egovList.addAll(sysByDefectCntPart);
		model.addAttribute("sysByDefectCnt", JSONArray.fromObject(egovList));
		
		// 업무별 결함건수 
		List<?> taskByDefectCnt = defectService.selectTaskByDefectCnt(sysNm);
		model.addAttribute("taskByDefectCnt", JSONArray.fromObject(taskByDefectCnt));
		
		return "tms/defect/defectStatsByDefectCnt";
	}
	
	/** 결함처리통계(그래프) - 대시보드2(비동기처리) */
	@RequestMapping("/tms/defect/selectDefectStatsByDefectCntAsyn.do")
	@ResponseBody
	public List<?> selectDefectStatsByDefectCntAsyn(String sysNm) throws Exception {
		
		List<?> taskByDefectCnt = defectService.selectTaskByDefectCnt(sysNm);
		
		return taskByDefectCnt;
	}
	
	/** 결함처리통계(그래프) - 대시보드3 */
	@RequestMapping("/tms/defect/selectDefectStatsByAction.do")
	public String selectDefectStatsByAction(ModelMap model) throws Exception {
		
		// 시스템별 전체 조치율
		HashMap<String, Object> sysAllByActionCnt = defectService.selectSysAllByActionCnt();
		model.addAttribute("sysAllByActionCnt", sysAllByActionCnt);
		
		// 시스템별 조치율
		List<EgovMap> sysByActionCnt = defectService.selectSysByActionCnt();
		model.addAttribute("sysByActionCnt", JSONArray.fromObject(sysByActionCnt));
		
		// 업무별 조치율 (
		List<?> taskByActionCnt = defectService.selectTaskByActionCnt();
		model.addAttribute("taskByActionCnt", JSONArray.fromObject(taskByActionCnt));
		
		
		return "tms/defect/defectStatsByAction";
	}
	
	/** 결함처리통계(그래프) - 대시보드3(비동기처리) */
	@RequestMapping("/tms/defect/selectDefectStatsByActionAsyn.do")
	@ResponseBody
	public List<?> selectDefectStatsByActionAsyn(String sysGb) throws Exception {
		List<?> taskByActionCnt;
		if(sysGb.equals("sysGb")){
			taskByActionCnt = defectService.selectTaskByActionCnt();
		} else {
			taskByActionCnt = defectService.selectTaskByActionCntForSysGb(sysGb);
		}
		
		return taskByActionCnt;
	}
	
	/** 통계표 */
	@RequestMapping("/tms/defect/selectDefectStatsTable.do")
	public String selectDefectStatsTable(ModelMap model){
		
		List<EgovMap> userDevPgIdByStats = defectService.selectUserDevPgIdByStats();
		model.addAttribute("userDevPgIdByStats",userDevPgIdByStats);
		
		List<EgovMap> sysGbByStats = defectService.selectSysGbByStats();
		model.addAttribute("sysGbByStats",sysGbByStats);
		
		
		return "tms/defect/defectStatsList";
	}
	
	/** 통계 엑셀 다운로드 기능 
	 * @throws Exception */
	@RequestMapping(value = "/tms/defect/StatsToExcel.do")
	public String StatsToExcel(@RequestParam("statsGb") String statsGb, ModelMap model, HttpServletResponse response) throws Exception {

		List<EgovMap> sysGbByStats = defectService.selectSysGbByStats();
		List<EgovMap> userDevPgIdByStats = defectService.selectUserDevPgIdByStats();
		
		if(statsGb.equals("sys")) {
			xlsxWiter(sysGbByStats, statsGb, response);
		} else {
			xlsxWiter(userDevPgIdByStats, statsGb, response);
		}
		
		model.addAttribute("sysGbByStats",sysGbByStats);
		model.addAttribute("userDevPgIdByStats",userDevPgIdByStats);

		return "tms/defect/defectStatsList";
	}
	
	public void xlsxWiter(List<EgovMap> list,String statsGb, HttpServletResponse response) throws Exception {
		// 워크북 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// 워크시트 생성
		XSSFSheet sheet = workbook.createSheet();
		// 행 생성
		XSSFRow row = sheet.createRow(0);
		// 쎌 생성
		XSSFCell cell;
		
		Font defaultFont = workbook.createFont();        
		defaultFont.setColor(HSSFColor.WHITE.index);
		defaultFont.setBoldweight(Font.BOLDWEIGHT_BOLD); 
		defaultFont.setFontHeightInPoints((short) 11); 
		defaultFont.setFontName("맑은 고딕");

		Font contentFont = workbook.createFont();      
		contentFont.setFontHeightInPoints((short) 11); 
		contentFont.setFontName("맑은 고딕");
		
		//제목 스타일 
		CellStyle HeadStyle = workbook.createCellStyle(); 
		HeadStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		HeadStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 
		HeadStyle.setFillForegroundColor(HSSFColor.LIGHT_BLUE.index); 
		HeadStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
		HeadStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
		HeadStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 
		HeadStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		HeadStyle.setFillPattern(CellStyle.SOLID_FOREGROUND); 
		HeadStyle.setFont(defaultFont);
		
		CellStyle TitleStyle = workbook.createCellStyle(); 
		TitleStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		TitleStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 
		TitleStyle.setFillForegroundColor(HSSFColor.AQUA.index); 
		TitleStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
		TitleStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
		TitleStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 
		TitleStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		TitleStyle.setFillPattern(CellStyle.SOLID_FOREGROUND); 
		TitleStyle.setFont(defaultFont);
		
		//본문 스타일 
		CellStyle BodyStyle = workbook.createCellStyle(); 
		BodyStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		BodyStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		BodyStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderRight(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setBorderTop(HSSFCellStyle.BORDER_THIN); 
		BodyStyle.setFont(contentFont);   
		
		// 헤더 정보 구성
		if(statsGb.equals("sys")) {
			cell = row.createCell(0);
			cell.setCellValue("시스템구분");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(1);
			cell.setCellValue("업무구분");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));
			cell.setCellStyle(HeadStyle); // 제목스타일 

			cell = row.createCell(2);
			cell.setCellValue("결함건수");
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 2, 5));
			cell.setCellStyle(HeadStyle); // 제목스타일 

			cell = row.createCell(6);
			cell.setCellValue("조치건수");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 6, 6));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(7);
			cell.setCellValue("미조치건수");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 7, 7));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(8);
			cell.setCellValue("조치율(%)");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 8, 8));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			row = sheet.createRow(1);
			
			cell = row.createCell(0);
			cell.setCellValue("시스템구분");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(1);
			cell.setCellValue("업무구분");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(2);
			cell.setCellValue("오류");
			cell.setCellStyle(TitleStyle); // 제목스타일 
			
			cell = row.createCell(3);
			cell.setCellValue("개선");
			cell.setCellStyle(TitleStyle); // 제목스타일 
			
			cell = row.createCell(4);
			cell.setCellValue("문의");
			cell.setCellStyle(TitleStyle); // 제목스타일 
			
			cell = row.createCell(5);
			cell.setCellValue("기타");
			cell.setCellStyle(TitleStyle); // 제목스타일 
			
			cell = row.createCell(6);
			cell.setCellValue("조치건수");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(7);
			cell.setCellValue("미조치건수");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(8);
			cell.setCellValue("조치율(%)");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			for(int i=0; i < list.size(); i++) {
				row = sheet.createRow(i+2);
				
				cell = row.createCell(0);
				cell.setCellValue(String.valueOf(list.get(i).get("sysNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(1);
				cell.setCellValue(String.valueOf(list.get(i).get("taskNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(2);
				cell.setCellValue(String.valueOf(list.get(i).get("defectGbD1")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(3);
				cell.setCellValue(String.valueOf(list.get(i).get("defectGbD2")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(4);
				cell.setCellValue(String.valueOf(list.get(i).get("defectGbD3")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(5);
				cell.setCellValue(String.valueOf(list.get(i).get("defectGbD4")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(6);
				cell.setCellValue(String.valueOf(list.get(i).get("actionStA3")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(7);
				cell.setCellValue(String.valueOf(list.get(i).get("actionStA3Not")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(8);
				cell.setCellValue(String.valueOf(list.get(i).get("actionPer")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				
			}
			
			/** 3. 컬럼 Width */ 
			for (int i = 0; i <  list.size(); i++){ 
				sheet.autoSizeColumn(i); 
				sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000); 
			}
			sheet.setColumnWidth(0, "시스템구분".length()*500 + 1000);
			sheet.setColumnWidth(1, "업무구분".length()*500 + 1000);
			sheet.setColumnWidth(6, "조치건수".length()*500 + 1000);
			sheet.setColumnWidth(7, "미조치건수".length()*500 + 1000);
			sheet.setColumnWidth(8, "조치율(%)".length()*500 + 1000);
			
		} else {
			cell = row.createCell(0);
			cell.setCellValue("개발자");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(1);
			cell.setCellValue("화면ID");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1));
			cell.setCellStyle(HeadStyle); // 제목스타일 

			cell = row.createCell(2);
			cell.setCellValue("화면명");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(3);
			cell.setCellValue("결함건수");
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 3, 6));
			cell.setCellStyle(HeadStyle); // 제목스타일 

			cell = row.createCell(7);
			cell.setCellValue("조치건수");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 7, 7));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(8);
			cell.setCellValue("미조치건수");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 8, 8));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(9);
			cell.setCellValue("조치율(%)");
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 9, 9));
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			row = sheet.createRow(1);
			
			cell = row.createCell(0);
			cell.setCellValue("개발자");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(1);
			cell.setCellValue("화면ID");
			cell.setCellStyle(HeadStyle); // 제목스타일 

			cell = row.createCell(2);
			cell.setCellValue("화면명");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(3);
			cell.setCellValue("결함건수");
			cell.setCellStyle(HeadStyle); // 제목스타일 

			cell = row.createCell(3);
			cell.setCellValue("오류");
			cell.setCellStyle(TitleStyle); // 제목스타일 
			
			cell = row.createCell(4);
			cell.setCellValue("개선");
			cell.setCellStyle(TitleStyle); // 제목스타일 
			
			cell = row.createCell(5);
			cell.setCellValue("문의");
			cell.setCellStyle(TitleStyle); // 제목스타일 
			
			cell = row.createCell(6);
			cell.setCellValue("기타");
			cell.setCellStyle(TitleStyle); // 제목스타일 
			
			cell = row.createCell(7);
			cell.setCellValue("조치건수");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(8);
			cell.setCellValue("미조치건수");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			cell = row.createCell(9);
			cell.setCellValue("조치율(%)");
			cell.setCellStyle(HeadStyle); // 제목스타일 
			
			for(int i=0; i<list.size(); i++) {
				row = sheet.createRow(i+2);
				
				cell = row.createCell(0);
				cell.setCellValue(String.valueOf(list.get(i).get("userNm")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				if((list.get(i).get("pgId")).toString().equals("소계")) {
					cell = row.createCell(1);
					sheet.addMergedRegion(new CellRangeAddress(i+2,i+2,1, 2));
					cell.setCellValue(String.valueOf(list.get(i).get("pgId")));
					cell.setCellStyle(BodyStyle); // 본문스타일 
					
					cell = row.createCell(2);
					cell.setCellValue(String.valueOf(list.get(i).get("pgNm")));
					cell.setCellStyle(BodyStyle); // 본문스타일 
					
				} else {
					cell = row.createCell(1);
					cell.setCellValue(String.valueOf(list.get(i).get("pgId")));
					cell.setCellStyle(BodyStyle); // 본문스타일 
					
					cell = row.createCell(2);
					cell.setCellValue(String.valueOf(list.get(i).get("pgNm")));
					cell.setCellStyle(BodyStyle); // 본문스타일 
				}
				
				cell = row.createCell(3);
				cell.setCellValue(String.valueOf(list.get(i).get("defectGbD1")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(4);
				cell.setCellValue(String.valueOf(list.get(i).get("defectGbD2")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(5);
				cell.setCellValue(String.valueOf(list.get(i).get("defectGbD3")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(6);
				cell.setCellValue(String.valueOf(list.get(i).get("defectGbD4")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(7);
				cell.setCellValue(String.valueOf(list.get(i).get("actionStA3")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
				
				cell = row.createCell(8);
				cell.setCellValue(String.valueOf(list.get(i).get("actionStA3Not")));
				cell.setCellStyle(BodyStyle); // 본문스타일
				
				cell = row.createCell(9);
				cell.setCellValue(String.valueOf(list.get(i).get("actionPer")));
				cell.setCellStyle(BodyStyle); // 본문스타일 
			}
			
			/** 3. 컬럼 Width */ 
			for (int i = 0; i <  list.size(); i++){ 
				sheet.autoSizeColumn(i); 
				sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000); 
			}
			sheet.setColumnWidth(0, "개발자".length()*500 + 1000);
			sheet.setColumnWidth(7, "조치건수".length()*500 + 1000);
			sheet.setColumnWidth(8, "미조치건수".length()*500 + 1000);
			sheet.setColumnWidth(9, "조치율(%)".length()*500 + 1000);
		}
		
		// 입력된 내용 파일로 쓰기
		File folder = new File("C:\\TMS\\TMS_통계자료");
		
		File file = new File("C:\\TMS\\TMS_통계자료\\프로그램현황.xlsx");
		
		//디렉토리 생성 메서드
		if(!folder.exists()){
			folder.mkdirs();
		}
		
		FileOutputStream fos = null;
		
		try {
			fos = new FileOutputStream(file);
			workbook.write(fos);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if(workbook!=null) //workbook.close();
				if(fos!=null) fos.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		/** 경로 다운로드 */
		 String path = "C:/TMS/TMS_통계자료/";  // Link의 자바파일에서 excel 파일이 생성된 경로
         String realFileNm = "프로그램현황.xlsx";
         
         File uFile = new File(path,realFileNm);
         int fSize = (int) uFile.length();
         if (fSize > 0) {  //파일 사이즈가 0보다 클 경우 다운로드
          String mimetype = "application/x-msdownload";  //minetype은 파일확장자에 맞게 설정
  		  response.setHeader("Content-Disposition", "attachment; filename=\"TMS.xlsx\"");
          response.setContentType(mimetype);
          response.setContentLength(fSize);
          BufferedInputStream in = null;
          BufferedOutputStream out = null;
          
          try {
          
           in = new BufferedInputStream(new FileInputStream(uFile));
           out = new BufferedOutputStream(response.getOutputStream());
           FileCopyUtils.copy(in, out);
           out.flush();
          } catch (Exception ex) {
          } finally {
             String path1 = "C:/TMS/TMS_통계자료/프로그램현황.xlsx";
             File deleteFolder = new File(path1);
             deleteFolder.delete();
             String path2 = "C:/TMS/TMS_통계자료";
             File deleteFolder2 = new File(path2);
             deleteFolder2.delete();
             String path3 = "C:/TMS";
             File deleteFolder3 = new File(path3);
             deleteFolder3.delete();
           if (in != null) in.close();
           if (out != null) out.close();
          }
         } else {
          response.setContentType("application/x-msdownload");
        
          PrintWriter printwriter = response.getWriter();
          printwriter.println("<html>");
          printwriter.println("<br><br><br><h2>Could not get file name:<br>" + realFileNm + "</h2>");
          printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
          printwriter.println("<br><br><br>&copy; webAccess");
          printwriter.println("</html>");
          printwriter.flush();
          printwriter.close();
         }
		
	}
	
}
