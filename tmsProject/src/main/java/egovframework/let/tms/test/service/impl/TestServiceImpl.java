package egovframework.let.tms.test.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.tms.test.service.TestService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("testService")
public class TestServiceImpl extends EgovAbstractServiceImpl implements TestService{

	/** TestDAO */
	
	// TODO ibatis 사용
	@Resource(name = "testDAO")
	private TestDAO testDAO;
	

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
	
}
