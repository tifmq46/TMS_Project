package egovframework.let.tms.defect.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.tms.defect.service.DefectService;
import egovframework.rte.fdl.property.EgovPropertyService;

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
}
