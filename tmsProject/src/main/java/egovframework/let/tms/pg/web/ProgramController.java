package egovframework.let.tms.pg.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import java.util.List;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
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
import egovframework.let.tms.pg.service.PgCurrentVO;
import egovframework.let.tms.pg.service.ProgramDefaultVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import egovframework.let.tms.pg.service.ProgramService;
import egovframework.let.tms.pg.service.ProgramVO;


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
	
	
	/**
	 * 글 목록을 조회한다. (pageing)
	 * @param searchVO - 조회할 정보가 담긴 DevPlanDefaultVO
	 * @param model
	 * @return "DevPlanList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/tms/pg/PgManage.do")
	public String selectPgList(@ModelAttribute("searchVO1") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		//System.out.println("여기까지옴ㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁㅁ");
		//System.out.println("searchVO1 =========================== "+ searchVO.getSearchByPgId());
		//System.out.println("--manage--");
		System.out.println(searchVO);
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

		return "tms/pg/PgManage";
	}
	
	@RequestMapping("/tms/pg/selectPgInf.do")
	public String selectTemplateInf(@ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {

		System.out.println("---");
		//VO.setCodeId("COM005");

		ProgramVO VO = ProgramService.selectProgramInf(programVO);
		
		model.addAttribute("programVO", VO);

		return "tms/pg/PgUpdate";
	}
	
	/**
	 * 글을 조회한다.
	 * @param sampleVO - 조회할 정보가 담긴 VO
	 * @param searchVO - 목록 조회조건 정보가 담긴 VO
	 * @param status
	 * @return @ModelAttribute("sampleVO") - 조회한 정보
	 * @exception Exception
	 */
	
	/*public ProgramVO selectDevPlan(ProgramVO devPlanVO, @ModelAttribute("searchVO") ProgramDefaultVO searchVO) throws Exception {
		return ProgramService.selectDevPlan(devPlanVO);
	}*/
	
	
	
	@RequestMapping(value = "/tms/pg/PgCurrent.do")
	public String selectDevResultList(@ModelAttribute("searchVO1") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
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

		List<?> PgList = ProgramService.selectPgCurrentList(searchVO);
		//List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tms/pg/PgCurrent";
	}
	
	@RequestMapping(value = "/tms/pg/PgInsert.do")
	public String registerPgList(@ModelAttribute("searchVO1") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
		
		
		
		return "tms/pg/PgInsert";
	}
	@RequestMapping(value = "/tms/pg/Pginsert.do")
	public String insertPgList(@ModelAttribute("searchVO1") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {

			programVO.setPJT_ID("PJT001");
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
	
	@RequestMapping(value = "/tms/pg/Pgupdate.do")
	public String insertPgUpdate(@ModelAttribute("searchVO1") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {

		
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
	
	@RequestMapping(value = "/tms/pg/deletePg.do")
	public String insertPgDelete(@RequestParam("del") String del, @ModelAttribute("searchVO1") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {
			System.out.println("---여기다!"+del);
		
			String[] strDelCodes = del.split(";");
			for (int i = 0; i < strDelCodes.length; i++) {
				ProgramVO vo = new ProgramVO();
				vo.setPG_ID(strDelCodes[i]);
				ProgramService.deletePg(vo);
				
				//authorManage.setAuthorCode(strAuthorCodes[i]);
				//egovAuthorManageService.deleteAuthor(authorManage);
			}
			
			ProgramService.deletePg(programVO);
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
	

	@RequestMapping(value = "/tms/pg/ExelWrite.do")
	public String ExelWrite(@ModelAttribute("searchVO1") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model) throws Exception {

		// 엑셀로 쓸 데이터 생성		
		List<PgCurrentVO> list = new ArrayList<PgCurrentVO>();
		
		// 엑셀 리스트 생성
		List<?> excelList = ProgramService.selectPgCurrentList(searchVO);
		
		// 엑셀 데이터에 엑셀 리스트 추가
		for(int i=0; i<excelList.size(); i++)
		{
			PgCurrentVO excel = (PgCurrentVO) excelList.get(i);
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

		List<?> PgList = ProgramService.selectPgCurrentList(searchVO);
		//List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "tms/pg/PgCurrent";
		
		
		
		
	}
	@RequestMapping(value = "/tms/pg/fileupload.do")
	public String upload(@ModelAttribute("searchVO1") ProgramDefaultVO searchVO, @ModelAttribute("programVO") ProgramVO programVO, ModelMap model, MultipartFile uploadfile) throws Exception{
		
	       
	    		  
		//MultipartFile uploadfile

		System.out.println("---");
		System.out.println("---1"+uploadfile.getContentType());
		System.out.println("---2"+uploadfile.getName());
		System.out.println("---3"+uploadfile.getOriginalFilename());
	    System.out.println("---4"+uploadfile.hashCode());
	    System.out.println("---5"+uploadfile.toString());
		/*
	    System.out.println(uploadfile.getContentType());
	    System.out.println(uploadfile.getName());
	    System.out.println(uploadfile.getOriginalFilename());
	    System.out.println(uploadfile.hashCode());
	    System.out.println(uploadfile.toString());
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

		List<?> PgList = ProgramService.selectPgCurrentList(searchVO);
		//List<?> PgList = ProgramService.selectPgList(searchVO);
		model.addAttribute("resultList", PgList);

		int totCnt = ProgramService.selectPgListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
	    
	    
	    return "tms/pg/PgCurrent";
	}
	
	
	
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
	
	public void xlsxWiter(List<PgCurrentVO> list) {
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
	
    @RequestMapping(value = "/tms/pg/requestupload.do")
    public String requestupload1(MultipartHttpServletRequest mtfRequest, @ModelAttribute("searchVO1") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
    	    	
        String src = mtfRequest.getParameter("src");
        System.out.println("src value : " + src);
        MultipartFile mf = mtfRequest.getFile("file");

        String path = "C:\\image\\";

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

	@RequestMapping(value = "/tms/pg/ExelRegister.do")
	public String ExelRegister(@ModelAttribute("searchVO1") ProgramDefaultVO searchVO, ModelMap model) throws Exception {
				
		//CustomerExcelReader excelReader = new CustomerExcelReader();
		List<ProgramVO> xlsxList = xlsxToCustomerVoList("C:\\image\\test.xlsx");
		
		ProgramVO vo;
		
		for (int i = 0; i < xlsxList.size(); i++) {
			vo = xlsxList.get(i);
			ProgramService.insertPg(vo);
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
										vo.setPJT_ID(value);										
										break;										
		
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
	 * XLSX 파일을 분석하여 List<CustomerVo> 객체로 반환
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
										vo.setPJT_ID(value);										
										break;										
		
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
