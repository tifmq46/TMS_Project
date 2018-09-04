package egovframework.let.tms.pg.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.tms.pg.service.ProgramService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class ProgramController {

	/** ProgramService */
	@Resource (name = "programService")
	private ProgramService programService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
}
