package egovframework.let.tms.pg.service.impl;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.let.tms.pg.service.ProgramService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("programService")
public class ProgramServiceImpl extends EgovAbstractServiceImpl implements ProgramService{

private static final Logger LOGGER = LoggerFactory.getLogger(ProgramServiceImpl.class);
	
	/** ProgramDAO */
	
	// TODO ibatis 사용
	@Resource(name = "programDAO")
	private ProgramDAO programDAO;
	

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
}
