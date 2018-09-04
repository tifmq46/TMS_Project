package egovframework.let.tms.defect.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.let.tms.defect.service.DefectService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

@Service("defectService")
public class DefectServiceImpl extends EgovAbstractServiceImpl implements DefectService{

	/** DefectDAO */
	
	// TODO ibatis 사용
	@Resource(name = "defectDAO")
	private DefectDAO defectDAO;
	

	/** ID Generation */
	@Resource(name = "egovIdGnrService")
	private EgovIdGnrService egovIdGnrService;
}
