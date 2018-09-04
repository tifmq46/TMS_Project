package egovframework.let.tms.test.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.let.tms.test.service.TestService;
import egovframework.rte.fdl.property.EgovPropertyService;

@Controller
public class TestController {

	/** TestService */
	@Resource (name = "testService")
	private TestService testService;
	
	/** EgovPropertyService */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/** Validator */
	@Resource(name = "beanValidator")
	protected DefaultBeanValidator beanValidator;
}
