package egovframework.let.tms.pg.service;

import java.util.List;


public interface ProgramService {
	
	
	void insertPg(ProgramVO vo) throws Exception;

	void insertExcelPg(ProgramVO vo) throws Exception;
	
	void updatePg(ProgramVO vo) throws Exception;

	void deletePg(ProgramVO vo) throws Exception;

	void full_deletePg() throws Exception;
	
	ProgramVO selectPg(ProgramVO vo) throws Exception;

	List<?> selectPgList(ProgramDefaultVO searchVO) throws Exception;

	List<?> checkPgList(ProgramDefaultVO searchVO) throws Exception;
	
	ProgramVO selectProgramInf(ProgramVO vo) throws Exception;
	
	int selectPgListTotCnt(ProgramDefaultVO searchVO);
	
	int selectTotCntUseYn(ProgramDefaultVO searchVO);

	List<?> selectPgCurrentList(ProgramVO searchVO) throws Exception;
	
	List<?> selectPgCurrentExcelList(ProgramDefaultVO searchVO) throws Exception;
	
	int count1(String i) throws Exception;
	int count2(String i) throws Exception;
	int count3(String i) throws Exception;
}
