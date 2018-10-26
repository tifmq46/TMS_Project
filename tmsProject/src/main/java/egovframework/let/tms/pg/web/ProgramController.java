package egovframework.let.tms.pg.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;
import egovframework.let.tms.defect.service.DefectService;
import egovframework.let.sym.prm.service.TmsProgrmManageService;
import egovframework.let.tms.pg.service.PgCurrentVO;
import egovframework.let.tms.pg.service.ProgramDefaultVO;
import egovframework.let.tms.pg.service.ProgramService;
import egovframework.let.tms.pg.service.ProgramVO;
import egovframework.let.tms.pg.service.ProgramValidator;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class ProgramController {

	/** DevPlanService */
	@Resource (name = "ProgramService")
	private ProgramService ProgramService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** DefectService */
	@Resource (name = "defectService")
	private DefectService defectService;
	
	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	
	/** EgovProgrmManageService */
	@Resource(name = "TmsProgrmManageService")
	private TmsProgrmManageService TmsProgrmManageService;
	
	
	/**
	 * 글 목록을 조회한다. (pageing)
	 */
	@RequestMapping(value = "/tms/pg/PgManage.do")
	public String selectPgList(@RequestParam(value="cnt", defaultValue = "") String cnt, @ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
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

		
		if(cnt.equals("")) { 
			searchVO.setSearchUseYn("Y"); 
		}
		
		//화면 리스트
		List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);
		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 공통코드 부분 시작 -------------------------------	
		List<String> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		if(!searchVO.getSearchBySysGb().isEmpty()) {
			List<String> taskGbList2 = TmsProgrmManageService.selectTaskGb2(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		List<String> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		List<String> useYnList = TmsProgrmManageService.selectUseYn();
		model.addAttribute("useYnList", useYnList);
		// 공통코드 끝 시작 -------------------------------	
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);

		return "tms/pg/PgManage";
	}

	/**
	 * 글 상세정보을 조회 및 수정한다. 
	 * @param searchVO - 조회할 정보가 담긴 ProgramDefaultVO
	 * @param model
	 * @return "programVO"
	 * @exception Exception
	 */
	@RequestMapping("/tms/pg/selectPgInf.do")
	public String selectPgInf(@ModelAttribute("programVO") ProgramVO searchVO, ModelMap model) throws Exception {

		ProgramVO VO = ProgramService.selectProgramInf(searchVO);		
		model.addAttribute("programVO", VO);

		// 공통코드 부분 시작 -------------------------------	
		List<String> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		List<String> taskGbList3 = TmsProgrmManageService.selectTaskGb3(searchVO);
		model.addAttribute("taskGb2", taskGbList3);
		
		List<String> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		List<?> user_dev_List = TmsProgrmManageService.selectUserList();
		model.addAttribute("dev_List", user_dev_List);
		// 공통코드 끝 시작 -------------------------------	
		
		
		return "tms/pg/PgUpdate";
	}
	
	/**
	 * 글 상세정보를 조회한다. (pageing)
	 */
	@RequestMapping("/tms/pg/selectPgCheck.do")
	public String selectPgCheck(@ModelAttribute("programVO") ProgramVO searchVO, ModelMap model) throws Exception {

		ProgramVO VO = ProgramService.selectProgramInf(searchVO);		
		model.addAttribute("programVO", VO);

		// 공통코드 부분 시작 -------------------------------	
		List<String> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		System.out.println("here---"+searchVO.getPgId());
		
		List<String> taskGbList3 = TmsProgrmManageService.selectTaskGb3(searchVO);
		model.addAttribute("taskGb2", taskGbList3);
		
		List<String> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		List<?> user_dev_List = TmsProgrmManageService.selectUserList();
		model.addAttribute("dev_List", user_dev_List);
		// 공통코드 끝 시작 -------------------------------	
		
		
		return "tms/pg/PgCheck";
	}
	
	/**
	 * 프로그램 현황을 조회한다.
	 */
	@RequestMapping(value = "/tms/pg/PgCurrent.do")
	public String selectPgCurrenList(@RequestParam(value="cnt", defaultValue = "") String cnt, @ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
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
		
		if(cnt.equals("")) { 
			searchVO.setSearchUseYn("Y"); 
		}		
		
		//프로그램 현황
		List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);
		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		model.addAttribute("TotCnt", totCnt);
		
		if(cnt.equals("")) { searchVO.setSearchUseYn("Y"); }
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 공통코드 부분 시작 -------------------------------	
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		if(!searchVO.getSearchBySysGb().isEmpty()) {
			List<?> taskGbList2 = TmsProgrmManageService.selectTaskGb2(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		List<String> useYnList = TmsProgrmManageService.selectUseYn();
		model.addAttribute("useYnList", useYnList);
		
		List<?> userList = defectService.selectUser();
		model.addAttribute("userList", userList);
		
		int use_y = ProgramService.selectTotCntUseYn(searchVO);
		model.addAttribute("USE_Y", use_y);
		model.addAttribute("USE_N", totCnt-use_y);
		// 공통코드 끝 시작 -------------------------------	
		

		return "tms/pg/PgCurrent";
	}
	
	/**
	 * 프로그램 정보를 등록한다.	 
	 */	
	@RequestMapping(value = "/tms/pg/PgInsert.do")
	public String registPgList(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
		// 공통코드 부분 시작 -------------------------------	
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		List<?> user_dev_List = TmsProgrmManageService.selectUserList();
		model.addAttribute("dev_List", user_dev_List);
		// 공통코드 끝 시작 -------------------------------
		
		
		return "tms/pg/PgInsert";
		
	}
	@RequestMapping(value = "/tms/pg/Pginsert.do")
	public String insertPgList(@ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {

		programVO.setPjtId("1");
		ProgramService.insertPg(programVO);
			
		return "redirect:/tms/pg/PgManage.do";
		
	}
	
	/**
	 * 프로그램 정보를 수정한다.	 
	 */	
	@RequestMapping(value = "/tms/pg/Pgupdate.do")
	public String updatePgList(@ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {

		
		ProgramService.updatePg(programVO);
			
		return "redirect:/tms/pg/PgManage.do";
		//return "redirect:/tms/pg/selectPgInf.do?pgId="+programVO.getPgId();
		
	}
	
	
	
	/**
	 * 프로그램 삭제목록을 확인한다.
	 */
	@RequestMapping(value = "/tms/pg/deletePgList.do")
	public String deletePgList(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, @RequestParam String result, ModelMap model) throws Exception {
			
			ArrayList <HashMap<String, String>> result_hash = new ArrayList <HashMap<String, String>>();
			
			String count1 = null;
			String count2 = null;
			String count3 = null;
			
			String[] strDelCodes = result.split(";");
			for (int i = 0; i < strDelCodes.length; i++) {
				
				HashMap<String, String> hash = new HashMap<String, String>();
				
				count1 = ""+ProgramService.count1(strDelCodes[i]);
				count2 = ""+ProgramService.count2(strDelCodes[i]);
				count3 = ""+ProgramService.count3(strDelCodes[i]);
				
				hash.put("PG_ID", strDelCodes[i]);
				hash.put("dev", count1);
				hash.put("test", count2);
				hash.put("defect", count3);
				
				result_hash.add(hash);
				
			}
			
			model.addAttribute("Pg_Relation_List", result_hash);
			model.addAttribute("returnValue", result);

			model.addAttribute("status", 0);
			
			return "/tms/pg/PgDeleteSearch";
		
	}
	
	/**
	 * 프로그램을 삭제한다.
	 */
	@RequestMapping(value = "/tms/pg/deleteListAction.do")
	@ResponseBody
	public List<?> deleteListAction(@RequestParam("returnValue") String returnValue, String searchData,ModelMap model) throws Exception {
		
		List<String> selectTaskGbSearch = TmsProgrmManageService.selectTaskGbSearch(searchData);
		model.addAttribute("selectTaskGbSearch", selectTaskGbSearch);
		
		String[] strDelCodes = returnValue.split(";");
		for (int i = 0; i < strDelCodes.length; i++) {
			ProgramVO vo = new ProgramVO();
			vo.setPgId(strDelCodes[i]);
			ProgramService.deletePg(vo);
			
		}
		
		/** 프로그램 삭제시 결함 시퀀스 초기화 */
		defectService.updateDefectIdSq();
		
		return selectTaskGbSearch;

	}
	
	
	/**
	 * 프로그램 현황을 엑셀파일로 출력한다.	 
	 */	
	@RequestMapping(value = "/tms/pg/ExelWrite.do")
	public String ExelWrite(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model,HttpServletRequest request, HttpServletResponse response, ServletResponse ServletResponse) throws Exception {

		// 엑셀로 쓸 데이터 생성		
		List<ProgramVO> list = new ArrayList<ProgramVO>();
					
		// 엑셀 리스트 생성
		List<?> excelList = ProgramService.selectPgCurrentExcelList(searchVO);
					
		// 엑셀 데이터에 엑셀 리스트 추가
		for(int i=0; i<excelList.size(); i++) {
			
			ProgramVO excel = (ProgramVO) excelList.get(i);
			list.add(excel);
		}
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
		cell = row.createCell(0);
		cell.setCellValue("화면ID");
		cell.setCellStyle(HeadStyle); // 제목스타일 

		cell = row.createCell(1);
		cell.setCellValue("화면명");
		cell.setCellStyle(HeadStyle); // 제목스타일 
							
		cell = row.createCell(2);
		cell.setCellValue("개발자");
		cell.setCellStyle(HeadStyle); // 제목스타일 
							
		cell = row.createCell(3);
		cell.setCellValue("시스템구분");
		cell.setCellStyle(HeadStyle); // 제목스타일 
							
		cell = row.createCell(4);
		cell.setCellValue("업무구분");
		cell.setCellStyle(HeadStyle); // 제목스타일 
							
		cell = row.createCell(5);
		cell.setCellValue("사용여부");
		cell.setCellStyle(HeadStyle); // 제목스타일 
							
		cell = row.createCell(6);
		cell.setCellValue("프로젝트 ID");
		cell.setCellStyle(HeadStyle); // 제목스타일 
							
		// 리스트의 size 만큼 row를 생성
		ProgramVO vo;
		for(int rowIdx=0; rowIdx < list.size(); rowIdx++) {
			vo = list.get(rowIdx);
								
			// 행 생성
			row = sheet.createRow(rowIdx+1);
								
			cell = row.createCell(0);
			cell.setCellValue(vo.getPgId());
			cell.setCellStyle(BodyStyle); // 본문스타일 

			cell = row.createCell(1);
			cell.setCellValue(vo.getPgNm());
			cell.setCellStyle(BodyStyle); // 본문스타일 
								
			cell = row.createCell(2);
			cell.setCellValue(vo.getUserDevId());
			cell.setCellStyle(BodyStyle); // 본문스타일 
								
			cell = row.createCell(3);
			cell.setCellValue(vo.getSysGb());
			cell.setCellStyle(BodyStyle); // 본문스타일 
								
			cell = row.createCell(4);
			cell.setCellValue(vo.getTaskGb());
			cell.setCellStyle(BodyStyle); // 본문스타일 
								
			cell = row.createCell(5);
			cell.setCellValue(vo.getUseYn());
			cell.setCellStyle(BodyStyle); // 본문스타일 
								
			cell = row.createCell(6);
			cell.setCellValue(vo.getPjtId());
			cell.setCellStyle(BodyStyle); // 본문스타일 
		}
		/** 3. 컬럼 Width */ 
		for (int i = 0; i <  list.size(); i++){ 
			sheet.autoSizeColumn(i); 
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 100); 
		}
							
		// 입력된 내용 파일로 쓰기
		File folder = new File("C:\\TMS\\TMS_통계자료");
		File file = new File("C:\\TMS\\TMS_통계자료\\프로그램현황.xlsx");
							
		if(!folder.exists()){
			//디렉토리 생성 메서드
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
		
			return "redirect:/tms/pg/PgCurrent.do";
		
	}
	
	
	
	/**
	 * 엑셀파일 출력메소드
	 * 	 */	
	public void xlsWiter(List<PgCurrentVO> list) {
		// 워크북 생성
		HSSFWorkbook workbook = new HSSFWorkbook();
		// 워크시트 생성
		HSSFSheet sheet = workbook.createSheet();
		// 행 생성
		HSSFRow row = sheet.createRow(0);
		// 쎌 생성
		HSSFCell cell;
		
		
		// 헤더 정보 구성
		cell = row.createCell(0);
		cell.setCellValue("프로그램ID");

		cell = row.createCell(1);
		cell.setCellValue("프로그램명");
		cell = row.createCell(2);
		cell.setCellValue("개발자");
		cell = row.createCell(3);
		cell.setCellValue("개발완료일자");
		cell = row.createCell(4);
		cell.setCellValue("개발여부");
		cell = row.createCell(5);
		cell.setCellValue("PL확인");
		cell = row.createCell(6);
		cell.setCellValue("단위테스트");
		
		// 리스트의 size 만큼 row를 생성
		PgCurrentVO vo;
		for(int rowIdx=0; rowIdx < list.size(); rowIdx++) {
			vo = list.get(rowIdx);
			
			
			
			// 행 생성
			row = sheet.createRow(rowIdx+1);
			
			
			cell = row.createCell(0);
			cell.setCellValue(vo.getPgId());
			
			
			cell = row.createCell(1);
			cell.setCellValue(vo.getPgNm());
			
			cell = row.createCell(2);
			cell.setCellValue(vo.getUserDevId());
			
			cell = row.createCell(3);
			cell.setCellValue(vo.getDevEndDt());
			
			cell = row.createCell(4);
			cell.setCellValue(vo.getDevEndYn());
			
			cell = row.createCell(5);
			cell.setCellValue(vo.getSecondTestResultYn());
			
			cell = row.createCell(6);
			cell.setCellValue(vo.getThirdTestResultYn());
		}
		
		// 입력된 내용 파일로 쓰기
		File file = new File("C:\\excel\\testWrite3.xls");
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
	}
	
	
	
	/**
	 * 업로드된 엑셀파일을 등록한다.
	 * 	 */	
    @RequestMapping(value = "/tms/pg/requestupload.do")
    public String requestupload1(MultipartHttpServletRequest mtfRequest, @ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
    	    	
    	String src = mtfRequest.getParameter("src");
        System.out.println("value : " + src);
        
        MultipartFile mf = mtfRequest.getFile("file");

        String path = "C:\\TMS_upload\\";

        File folder = new File(path);
		if(!folder.isDirectory()){
			//디렉토리 생성 메서드
			folder.mkdirs();
		}
        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
        long fileSize = mf.getSize(); // 파일 사이즈

        System.out.println("originFileName : " + originFileName);
        System.out.println("fileSize : " + fileSize);

        String safeFile = path + "ex_" + originFileName;
        try {
            mf.transferTo(new File(safeFile));
        } catch (IllegalStateException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        
        
        //엑셀파일 등록
		List<ProgramVO> xlsxList = xlsxToCustomerVoList(safeFile);
		//CustomerExcelReader excelReader = new CustomerExcelReader();
		
		ProgramVO vo;
		
		int j = 0;
		int result_cnt = 1;
		
		ArrayList <HashMap<String, String>> error_hash = new ArrayList <HashMap<String, String>>();
		
		
		for (int i = 0; i < xlsxList.size(); i++) {
			
			j=i;
			
			vo = xlsxList.get(i);
			
			try {
				
				
				ProgramService.insertPg(vo);
				ProgramService.deletePg(vo);
				
				model.addAttribute("result", "true");
				model.addAttribute("result2", "true");
			}catch(Exception e) {
				
				HashMap<String, String> hash = new HashMap<String, String>();
				
				result_cnt = 0;
				String[] array = e.toString().split(":");
				
				String last = array[array.length-1];
				last = last.replace("'USER_DEV_ID'", "개발자 이름,");
				last = last.replace("'SYS_GB'", "시스템구분,");
				last = last.replace("'TASK_GB'", "업무구분,");
				last = last.replace("Column", "");
				last = last.replace("Duplicate entry", "");
				last = last.replace("cannot be null", "불일치");
				
				if(last.contains("a foreign key")) {				
					String[] array2 = last.split("\\(");
					last = array2[3];
					String[] array3 = last.split("\\)");
					last = ""+array3[0]+" 불일치";
				}
				
				if(last.contains("Data too")) {
					
					if(last.contains("PG_ID")) {
						last = "화면ID, 길이초과";
					}else if(last.contains("PG_NM")) {
						last = "화면명, 길이초과";
					}
				}
				
				if(last.contains("for key 'PRIMARY'")) {
					last = "화면ID, 중복";
				}
				last = last.replace("`PJT_ID`", "프로젝트ID,");
				
				
				hash.put("problem", (j+1)+"행 등록 실패");
				hash.put("reason", last);
				error_hash.add(hash);
				continue;
			}
			
			if(!(vo.getUseYn().equals("Y") || vo.getUseYn().equals("N")))
			{
				HashMap<String, String> hash = new HashMap<String, String>();
				
				hash.put("problem", (j+1)+"행 등록 실패");
				hash.put("reason", "사용여부, 불일치");
				error_hash.add(hash);
				
				result_cnt = 0;
			}
			
		}  
		model.addAttribute("error_hashs", error_hash);
		model.addAttribute("result", result_cnt);
		
		if(result_cnt == 1)
		{
			for (int i = 0; i < xlsxList.size(); i++) {
				vo = xlsxList.get(i);
				ProgramService.insertPg(vo);
			}
		}
		
		return "/tms/pg/ExcelFileNmSearch";
    }
    
	@RequestMapping(value = "/tms/pg/ExcelFileListSearch.do")
	public String selectExcelFileListSearch() throws Exception {
		
		return "/tms/pg/ExcelFileNmSearch";

	}
    
    /**
	 * XLS 파일을 분석하여 List<CustomerVo> 객체로 반환
	 * @param filePath
	 * @return
	 */
	@SuppressWarnings("resource")
	public List<ProgramVO> xlsToCustomerVoList(String filePath) {
		
		// 반환할 객체를 생성
		List<ProgramVO> list = new ArrayList<ProgramVO>();
		
		FileInputStream fis = null;
		HSSFWorkbook workbook = null;
		
		try {
			
			fis= new FileInputStream(filePath);
			// HSSFWorkbook은 엑셀파일 전체 내용을 담고 있는 객체
			workbook = new HSSFWorkbook(fis);
			
			// 탐색에 사용할 Sheet, Row, Cell 객체
			HSSFSheet curSheet;
			HSSFRow   curRow;
			HSSFCell  curCell;
			ProgramVO vo;
			
			// Sheet 탐색 for문
			for(int sheetIndex = 0 ; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 Sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for(int rowIndex=0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if(rowIndex != 0) {
						// 현재 row 반환
						curRow = curSheet.getRow(rowIndex);
						vo = new ProgramVO();
						String value;
						
						// row의 첫번째 cell값이 비어있지 않은 경우 만 cell탐색
						if(!"".equals(curRow.getCell(0).getStringCellValue())) {
							
							// cell 탐색 for 문
							for(int cellIndex=0;cellIndex<curRow.getPhysicalNumberOfCells(); cellIndex++) {
								curCell = curRow.getCell(cellIndex);
								
								if(true) {
									value = "";
									// cell 스타일이 다르더라도 String으로 반환 받음
									switch (curCell.getCellType()){
					                case HSSFCell.CELL_TYPE_FORMULA:
					                	value = curCell.getCellFormula();
					                    break;
					                case HSSFCell.CELL_TYPE_NUMERIC:
					                	value = curCell.getNumericCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_STRING:
					                    value = curCell.getStringCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_BLANK:
					                    value = curCell.getBooleanCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_ERROR:
					                    value = curCell.getErrorCellValue()+"";
					                    break;
					                default:
					                	value = new String();
										break;
					                }
									
									// 현재 column index에 따라서 vo에 입력
									switch (cellIndex) {
									case 0: // 프로그램 id
										vo.setPgId(value);
										break;
										
									case 1: // 프로그램 명
										vo.setPgNm(value);
										break;
										
									case 2: // 개발자 ID
										vo.setUserDevId(value);
										break;
										
									case 3: // 시스템구분
										vo.setSysGb(value);
										break;
										
									case 4: // 업무구분
										vo.setTaskGb(value);
										
										break;
									case 5: // 사용여부
										vo.setUseYn(value);										
										break;
										
									case 6: // 프로젝트 id			
										if(value.contains("."))
										{
											String[] str = value.split("\\.");
											vo.setPjtId(""+str[0]);										
											break;
										}else {
											vo.setPjtId(""+value);										
											break;
										}			
		
									default:
										break;
									}
								}
							}
							// cell 탐색 이후 vo 추가
							list.add(vo);
						}
					}
				}
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} finally {
			try {
				// 사용한 자원은 finally에서 해제
				if( workbook!= null) //workbook.close();
				if( fis!= null) fis.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
	/**
	 * XLSX 파일을 분석하여 List<ProgramVO> 객체로 반환
	 * @param filePath
	 * @return
	 */
	public List<ProgramVO> xlsxToCustomerVoList(String filePath) {
		// 반환할 객체를 생성
		List<ProgramVO> list = new ArrayList<ProgramVO>();
		
		FileInputStream fis = null;
		XSSFWorkbook workbook = null;
		
		try {
			
			fis= new FileInputStream(filePath);
			// HSSFWorkbook은 엑셀파일 전체 내용을 담고 있는 객체
			workbook = new XSSFWorkbook(fis);
			
			// 탐색에 사용할 Sheet, Row, Cell 객체
			XSSFSheet curSheet;
			XSSFRow   curRow;
			XSSFCell  curCell;
			ProgramVO vo;
			
			// Sheet 탐색 for문
			for(int sheetIndex = 0 ; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 Sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for(int rowIndex=0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if(rowIndex != 0) {
						// 현재 row 반환
						curRow = curSheet.getRow(rowIndex);
						vo = new ProgramVO();
						String value;
						
						// row의 첫번째 cell값이 비어있지 않은 경우 만 cell탐색
						if(!"".equals(curRow.getCell(0).getStringCellValue())) {
							
							// cell 탐색 for 문
							for(int cellIndex=0;cellIndex<curRow.getPhysicalNumberOfCells(); cellIndex++) {
								curCell = curRow.getCell(cellIndex);
								
								if(true) {
									value = "";
									// cell 스타일이 다르더라도 String으로 반환 받음
									switch (curCell.getCellType()){
					                case HSSFCell.CELL_TYPE_FORMULA:
					                	value = curCell.getCellFormula();
					                    break;
					                case HSSFCell.CELL_TYPE_NUMERIC:
					                	value = curCell.getNumericCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_STRING:
					                    value = curCell.getStringCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_BLANK:
					                    value = curCell.getBooleanCellValue()+"";
					                    break;
					                case HSSFCell.CELL_TYPE_ERROR:
					                    value = curCell.getErrorCellValue()+"";
					                    break;
					                default:
					                	value = new String();
										break;
					                }
									
									// 현재 column index에 따라서 vo에 입력
									switch (cellIndex) {
									case 0: // 프로그램 id
										vo.setPgId(value);
										break;
										
									case 1: // 프로그램 명
										vo.setPgNm(value);
										break;
										
									case 2: // 개발자 ID
										vo.setUserDevId(value);
										break;
										
									case 3: // 시스템구분
										vo.setSysGb(value);
										break;
										
									case 4: // 업무구분
										vo.setTaskGb(value);
										
										break;
									case 5: // 사용여부
										vo.setUseYn(value);										
										break;
										
									case 6: // 프로젝트 id
										if(value.contains("."))
										{
											System.out.println("프로젝트1-"+value);
											String[] txtArr = value.split("\\.");
											System.out.println("프로젝트2-"+txtArr[0]);
											vo.setPjtId(txtArr[0]);										
											break;										
										}else {
											vo.setPjtId(value);	
										}
									default:
										break;
									}
								}
							}
							// cell 탐색 이후 vo 추가
							list.add(vo);
						}
					}
				}
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			
		} finally {
			try {
				// 사용한 자원은 finally에서 해제
				if( workbook!= null) //workbook.close();
				if( fis!= null) fis.close();
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}
	
}
