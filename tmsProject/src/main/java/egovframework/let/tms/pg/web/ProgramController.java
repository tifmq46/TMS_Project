package egovframework.let.tms.pg.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springmodules.validation.commons.DefaultBeanValidator;

import com.mysql.jdbc.exceptions.MySQLIntegrityConstraintViolationException;

import egovframework.let.tms.pg.service.PgCurrentVO;
import egovframework.let.tms.pg.service.ProgramDefaultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.let.tms.pg.service.ProgramService;
import egovframework.let.tms.pg.service.ProgramVO;
import egovframework.let.sym.prm.service.TmsProgrmManageService;

@Controller
public class ProgramController {

	/** DevPlanService */
	@Resource (name = "ProgramService")
	private ProgramService ProgramService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
	
	
	/** EgovProgrmManageService */
	@Resource(name = "TmsProgrmManageService")
	private TmsProgrmManageService TmsProgrmManageService;
	
	
	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 ProgramDefaultVO
	 * @param model
	 * @return "PgList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/pg/PgManage.do")
	public String selectPgList(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
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

		List<?> PgList = ProgramService.selectPgList(searchVO);
		//List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		
		System.out.println("current--"+totCnt);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 공통코드 부분 시작 -------------------------------	
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		System.out.println(searchVO.getSearchBySysGb());
		System.out.println(searchVO.getSearchByTaskGb());
		if(!searchVO.getSearchBySysGb().isEmpty()) {
			List<?> taskGbList2 = TmsProgrmManageService.selectTaskGb2(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		// 공통코드 끝 시작 -------------------------------	
		

		return "tms/pg/PgManage";
	}

	/**
	 * 글 상세정보을 조회한다. 
	 * @param searchVO - 조회할 정보가 담긴 ProgramDefaultVO
	 * @param model
	 * @return "programVO"
	 * @exception Exception
	 */
	@RequestMapping("/tms/pg/selectPgInf.do")
	public String selectTemplateInf(@ModelAttribute("programVO") ProgramVO searchVO, ModelMap model) throws Exception {

		//VO.setCodeId("COM005");

		ProgramVO VO = ProgramService.selectProgramInf(searchVO);
		
		model.addAttribute("programVO", VO);

		// 공통코드 부분 시작 -------------------------------	
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		System.out.println("here---"+searchVO.getPG_ID());
		
		List<?> taskGbList3 = TmsProgrmManageService.selectTaskGb3(searchVO);
		model.addAttribute("taskGb2", taskGbList3);
		
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		List<?> user_dev_List = TmsProgrmManageService.selectUserList();
		model.addAttribute("dev_List", user_dev_List);
		// 공통코드 끝 시작 -------------------------------	
		
		
		return "tms/pg/PgUpdate";
	}
	
	/**
	 * 프로그램 현황을 조회한다.
	 * @param ProgramDefaultVO - 조회할 정보가 담긴 VO
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/pg/PgCurrent.do")
	public String selectDevResultList(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
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

		List<?> PgList = ProgramService.selectPgList(searchVO);
		//List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		
		System.out.println("current--"+totCnt);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 공통코드 부분 시작 -------------------------------	
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		System.out.println("111-"+searchVO.getSearchBySysGb());
		System.out.println("222-"+searchVO.getSearchByTaskGb());
		if(!searchVO.getSearchBySysGb().isEmpty()) {
			List<?> taskGbList2 = TmsProgrmManageService.selectTaskGb2(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		// 공통코드 끝 시작 -------------------------------	
		

		return "tms/pg/PgCurrent";
	}
	
	/**
	 * 프로그램 정보를 등록한다.	 
	 */	
	@RequestMapping(value = "/tms/pg/PgInsert.do")
	public String registerPgList(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
		// 공통코드 부분 시작 -------------------------------	
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		List<?> user_dev_List = TmsProgrmManageService.selectUserList();
		model.addAttribute("dev_List", user_dev_List);
		
		System.out.println("111-"+searchVO.getSearchBySysGb());
		System.out.println("222-"+searchVO.getSearchByTaskGb());
		
		
				
		// 공통코드 끝 시작 -------------------------------
		
		return "tms/pg/PgInsert";
	}
	@RequestMapping(value = "/tms/pg/Pginsert.do")
	public String insertPgList(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {

			programVO.setPJT_ID("1");
			/*
			System.out.println(""+programVO.getPG_ID());
			System.out.println(""+programVO.getPG_NM());			
			System.out.println(""+programVO.getSYS_GB());
			System.out.println(""+programVO.getTASK_GB());
			System.out.println(""+programVO.getUSER_DEV_ID());
			System.out.println(""+programVO.getUSE_YN());
			System.out.println(""+programVO.getPJT_ID());
			*/
			ProgramService.insertPg(programVO);
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

			List<?> PgList = ProgramService.selectPgList(searchVO);
			model.addAttribute("resultList", PgList);

			int totCnt = ProgramService.selectPgListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			
			
			return "/tms/pg/PgManage";
		
	}
	
	/**
	 * 프로그램 정보를 수정한다.	 
	 */	
	@RequestMapping(value = "/tms/pg/Pgupdate.do")
	public String insertPgUpdate(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {

		
			ProgramService.updatePg(programVO);
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

			List<?> PgList = ProgramService.selectPgList(searchVO);
			model.addAttribute("resultList", PgList);

			int totCnt = ProgramService.selectPgListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			
			
			return "/tms/pg/PgManage";
		
	}
	
	/**
	 * 프로그램 사용여부를 수정한다.	 
	 */	
	@RequestMapping(value = "/tms/pg/deletePg.do")
	public String insertPgDelete(@RequestParam("del") String del, @ModelAttribute("searchVO") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {
			System.out.println("---여기다!"+del);
		
			String[] strDelCodes = del.split(";");
			for (int i = 0; i < strDelCodes.length; i++) {
				ProgramVO vo = new ProgramVO();
				vo.setPG_ID(strDelCodes[i]);
				ProgramService.deletePg(vo);
				
			}
			
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

			List<?> PgList = ProgramService.selectPgList(searchVO);
			model.addAttribute("resultList", PgList);

			int totCnt = ProgramService.selectPgListTotCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("paginationInfo", paginationInfo);
			
			
			return "/tms/pg/PgManage";
		
	}
	
	/**
	 * 프로그램 현황을 엑셀파일로 출력한다.	 
	 */	
	@RequestMapping(value = "/tms/pg/ExelWrite.do")
	public String ExelWrite(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {

		// 엑셀로 쓸 데이터 생성		
		List<ProgramVO> list = new ArrayList<ProgramVO>();
		
		// 엑셀 리스트 생성
		List<?> excelList = ProgramService.selectPgCurrentExcelList(searchVO);
		
		// 엑셀 데이터에 엑셀 리스트 추가
		for(int i=0; i<excelList.size(); i++)
		{
			ProgramVO excel = (ProgramVO) excelList.get(i);
			list.add(excel);
			
		}
		//xlsx 파일 쓰기
		xlsxWiter(list);	
		
		
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

		List<?> PgList = ProgramService.selectPgList(searchVO);
		//List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		
		System.out.println("current--"+totCnt);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 공통코드 부분 시작 -------------------------------	
		List<?> sysGbList = TmsProgrmManageService.selectSysGb();
		model.addAttribute("sysGb", sysGbList);
		
		System.out.println(searchVO.getSearchBySysGb());
		System.out.println(searchVO.getSearchByTaskGb());
		if(!searchVO.getSearchBySysGb().isEmpty()) {
			List<?> taskGbList2 = TmsProgrmManageService.selectTaskGb2(searchVO);
			model.addAttribute("taskGb2", taskGbList2);
		}
		List<?> taskGbList = TmsProgrmManageService.selectTaskGb();
		model.addAttribute("taskGb", taskGbList);
		
		// 공통코드 끝 시작 -------------------------------	
		
		return "tms/pg/PgCurrent";
		
		
		
		
	}
	
	/**
	 * 엑셀파일을 업로드한다.
	 * 	 */	
	@RequestMapping(value = "/tms/pg/fileupload.do")
	public String upload(@ModelAttribute("searchVO") PgCurrentVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model, MultipartFile uploadfile) throws Exception{
		
	       
	    		  
		//MultipartFile uploadfile
		/*
		System.out.println("---");
		System.out.println("---1"+uploadfile.getContentType());
		System.out.println("---2"+uploadfile.getName());
		System.out.println("---3"+uploadfile.getOriginalFilename());
	    System.out.println("---4"+uploadfile.hashCode());
	    System.out.println("---5"+uploadfile.toString());
		*/
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

		//List<?> PgList = ProgramService.selectPgCurrentList(searchVO);
		//List<?> PgList = ProgramService.selectPgList(searchVO);
		//model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
	    
	    
	    return "tms/pg/PgCurrent";
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
			cell.setCellValue(vo.getPG_ID());
			
			
			cell = row.createCell(1);
			cell.setCellValue(vo.getPG_NM());
			
			cell = row.createCell(2);
			cell.setCellValue(vo.getUSER_DEV_ID());
			
			cell = row.createCell(3);
			cell.setCellValue(vo.getDEV_END_DT());
			
			cell = row.createCell(4);
			cell.setCellValue(vo.getDEV_END_YN());
			
			cell = row.createCell(5);
			cell.setCellValue(vo.getSECOND_TEST_RESULT_YN());
			
			cell = row.createCell(6);
			cell.setCellValue(vo.getTHIRD_TEST_RESULT_YN());
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
	
	public void xlsxWiter(List<ProgramVO> list) {
		// 워크북 생성
		XSSFWorkbook workbook = new XSSFWorkbook();
		// 워크시트 생성
		XSSFSheet sheet = workbook.createSheet();
		// 행 생성
		XSSFRow row = sheet.createRow(0);
		// 쎌 생성
		XSSFCell cell;
		
		
		Font defaultFont = workbook.createFont();        
		defaultFont.setFontHeightInPoints((short) 11); 
		defaultFont.setFontName("맑은 고딕");

		//제목 스타일 
		CellStyle HeadStyle = workbook.createCellStyle(); 
		HeadStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); 
		HeadStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER); 
		HeadStyle.setFillForegroundColor(HSSFColor.LIGHT_YELLOW.index); 
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
		BodyStyle.setFont(defaultFont);   


		
		
		// 헤더 정보 구성
		cell = row.createCell(0);
		cell.setCellValue("화면ID");
		cell.setCellStyle(HeadStyle); // 제목스타일 

		cell = row.createCell(1);
		cell.setCellValue("화면명");
		cell.setCellStyle(HeadStyle); // 제목스타일 
		cell = row.createCell(2);
		cell.setCellValue("시스템구분");
		cell.setCellStyle(HeadStyle); // 제목스타일 
		cell = row.createCell(3);
		cell.setCellValue("업무구분");
		cell.setCellStyle(HeadStyle); // 제목스타일 
		cell = row.createCell(4);
		cell.setCellValue("개발자");
		cell.setCellStyle(HeadStyle); // 제목스타일 
		cell = row.createCell(5);
		cell.setCellValue("사용여부");
		cell.setCellStyle(HeadStyle); // 제목스타일 
		
		// 리스트의 size 만큼 row를 생성
		ProgramVO vo;
		for(int rowIdx=0; rowIdx < list.size(); rowIdx++) {
			vo = list.get(rowIdx);
			
			// 행 생성
			row = sheet.createRow(rowIdx+1);
			
			cell = row.createCell(0);
			cell.setCellValue(vo.getPG_ID());
			cell.setCellStyle(BodyStyle); // 본문스타일 

			cell = row.createCell(1);
			cell.setCellValue(vo.getPG_NM());
			cell.setCellStyle(BodyStyle); // 본문스타일 
			cell = row.createCell(2);
			cell.setCellValue(vo.getSYS_GB());
			cell.setCellStyle(BodyStyle); // 본문스타일 
			cell = row.createCell(3);
			cell.setCellValue(vo.getTASK_GB());
			cell.setCellStyle(BodyStyle); // 본문스타일 
			cell = row.createCell(4);
			cell.setCellValue(vo.getUSER_DEV_ID());
			cell.setCellStyle(BodyStyle); // 본문스타일 
			cell = row.createCell(5);
			cell.setCellValue(vo.getUSE_YN());
			cell.setCellStyle(BodyStyle); // 본문스타일 
		}
		/** 3. 컬럼 Width */ 
		for (int i = 0; i <  list.size(); i++){ 
			sheet.autoSizeColumn(i); 
			sheet.setColumnWidth(i, (sheet.getColumnWidth(i)) + 1000); 
		}

		
		
		
		
		// 입력된 내용 파일로 쓰기
		File folder = new File("C:\\TMS\\TMS_통계자료");
		
		File file = new File("C:\\TMS\\TMS_통계자료\\프로그램 현황.xlsx");
		
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
	}
	
	/**
	 * 업로드된 엑셀파일을 등록한다.
	 * 	 */	
    @RequestMapping(value = "/tms/pg/requestupload.do")
    public String requestupload1(MultipartHttpServletRequest mtfRequest, @ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
    	    	
    	//System.out.println("여기다!!!4");
        String src = mtfRequest.getParameter("src");
        System.out.println("src value : " + src);
        MultipartFile mf = mtfRequest.getFile("file");

        String path = "C:\\TMS_upload\\";

        File folder = new File(path);
        if(!folder.exists()){
            //디렉토리 생성 메서드
			folder.mkdirs();
		}        
        
        String originFileName = mf.getOriginalFilename(); // 원본 파일 명
        long fileSize = mf.getSize(); // 파일 사이즈

        System.out.println("originFileName : " + originFileName);
        System.out.println("fileSize : " + fileSize);

        String safeFile = path + originFileName;

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
		//CustomerExcelReader excelReader = new CustomerExcelReader();
		List<ProgramVO> xlsxList = xlsxToCustomerVoList(safeFile);
		
		ProgramVO vo;
		
		int j = 0;
		int error = 0;
		
		List<String> error_list = new ArrayList<String>();
		List<String> error_message = new ArrayList<String>();
		ArrayList <HashMap<String, String>> error_hash = new ArrayList <HashMap<String, String>>();
		
		
		for (int i = 0; i < xlsxList.size(); i++) {
			
			j=i;
			
			
			try {
				vo = xlsxList.get(i);
				
				if(!vo.getUSE_YN().equals("Y") || vo.getUSE_YN().equals("N"))
				{
					HashMap<String, String> hash = new HashMap<String, String>();
					
					hash.put("problem", (j+1)+"행을 등록시키지 못했습니다!");
					hash.put("reason", "컬럼 'USE YN' 형식 불일치");
					error_hash.add(hash);
					
					continue;
				}
				
				ProgramService.insertPg(vo);
				
				
				
				model.addAttribute("result", "true");
				model.addAttribute("result2", "true");
			}catch(Exception e) {
				HashMap<String, String> hash = new HashMap<String, String>();
				
				error = 1;
				
				
				
				String[] array = e.toString().split(":");
				
				
				
				String last = array[array.length-1];
				last = last.replace("Column", "컬럼");
				last = last.replace("Duplicate entry", "컬럼");
				last = last.replace("cannot be nul", "형식 불일치");
				last = last.replace("for key 'PRIMARY'", "중복");
				last = last.replace("for key 'PRIMARY'", "중복");
				
				if(last.contains("a foreign key"))
				{
					String[] array2 = last.split("\\(");
					last = array2[3];
					String[] array3 = last.split("\\)");
					last = "컬럼 "+array3[0]+" 외래키";
					//System.out.println(last);
				}
				
				
				
				error_list.add((j+1)+"행을 등록시키지 못했습니다!"+last);
				error_message.add(last);
				
				hash.put("problem", (j+1)+"행을 등록시키지 못했습니다!");
				hash.put("reason", last);
				error_hash.add(hash);
				
				model.addAttribute("result", (j+1)+": false");
				model.addAttribute("result2", (j+1)+": false");
				continue;
			}
			
		}  
		model.addAttribute("error_lists", error_list);
		model.addAttribute("error_messages", error_message);
		model.addAttribute("error_hashs", error_hash);
		
		//System.out.println(error_hash.get(2));
		
		/*
		try {
			for (int i = 0; i < xlsxList.size(); i++) {
				
				j=i;
				
				vo = xlsxList.get(i);
				ProgramService.insertPg(vo);
				
				model.addAttribute("result", "true");
				model.addAttribute("result2", "true");
			}       			
		}catch(Exception e) {
			model.addAttribute("result", (j+1)+": false");
			model.addAttribute("result2", (j+1)+": false");
			
			System.out.println("상황1");
		}*/
        

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

		List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
	
		
		return "/tms/pg/ExcelFileNmSearch";
    }
    
	@RequestMapping(value = "/tms/pg/ExcelFileListSearch.do")
	public String selectExcelFileListSearch(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
		//System.out.println("여기다!333");

		return "/tms/pg/ExcelFileNmSearch";

	}

	@RequestMapping(value = "/tms/pg/ExelRegister.do")
	public String ExelRegister(@ModelAttribute("searchVO") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
				
		//CustomerExcelReader excelReader = new CustomerExcelReader();
		List<ProgramVO> xlsxList = xlsxToCustomerVoList("C:\\image\\test.xlsx");
		
		ProgramVO vo;
		/*
		for (int i = 0; i < xlsxList.size(); i++) {
			vo = xlsxList.get(i);
			ProgramService.insertPg(vo);
		}*/
		
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

		List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		
		return "/tms/pg/PgManage";
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
										vo.setPG_ID(value);
										break;
										
									case 1: // 프로그램 명
										vo.setPG_NM(value);
										break;
										
									case 2: // 개발자 ID
										vo.setUSER_DEV_ID(value);
										break;
										
									case 3: // 시스템구분
										vo.setSYS_GB(value);
										break;
										
									case 4: // 업무구분
										vo.setTASK_GB(value);
										
										break;
									case 5: // 사용여부
										vo.setUSE_YN(value);										
										break;
										
									case 6: // 프로젝트 id			
										if(value.contains("."))
										{
											String[] str = value.split("\\.");
											vo.setPJT_ID(""+str[0]);										
											break;
										}else {
											vo.setPJT_ID(""+value);										
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
										vo.setPG_ID(value);
										break;
										
									case 1: // 프로그램 명
										vo.setPG_NM(value);
										break;
										
									case 2: // 개발자 ID
										vo.setUSER_DEV_ID(value);
										break;
										
									case 3: // 시스템구분
										vo.setSYS_GB(value);
										break;
										
									case 4: // 업무구분
										vo.setTASK_GB(value);
										
										break;
									case 5: // 사용여부
										vo.setUSE_YN(value);										
										break;
										
									case 6: // 프로젝트 id
										if(value.contains("."))
										{
											System.out.println("프로젝트1-"+value);
											String[] txtArr = value.split("\\.");
											System.out.println("프로젝트2-"+txtArr[0]);
											vo.setPJT_ID(txtArr[0]);										
											break;										
										}else {
											vo.setPJT_ID(value);	
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
