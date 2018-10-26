package egovframework.let.tms.pg.service;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
// import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

public class ProgramValidator implements Validator {

	@Override
	public boolean supports(Class<?> arg0) {
		return ProgramVO.class.isAssignableFrom(arg0);
	}

	@Override
	public void validate(Object obj, Errors errors) {
		ProgramVO member = (ProgramVO) obj;
		//ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pgNm", "required", "필수입력 사항입니다.");
		//ValidationUtils.rejectIfEmptyOrWhitespace(errors, "pgId", "required", "필수입력 사항입니다.");
		
//		이름 유효성 체크)
		String mName = member.getPgNm();
		if(mName == null || mName.trim().isEmpty()) {
			errors.rejectValue("pgNm", "공백오류", "화면명을 입력하세요");
			
		}
//		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "공백오류");
		
//		아이디 유효성 체크)		
		String mId = member.getPgId();
		if(mId == null || mId.trim().isEmpty()) {
			errors.rejectValue("pgId", "공백오류", "화면ID를 입력하세요");
			
		}
		String mId2 = member.getPgId();
		if(mId2.contains(";") || mId2.contains("#") || mId2.contains("$") || mId2.contains("^") || mId2.contains("*") || mId2.contains("{") || mId2.contains("}") ) {
			errors.rejectValue("pgId", "공백오류", "특수문자( ;, # )는 입력할 수 없습니다");
			
		}
//		시스템구분 유효성 체크)		
		String sysGb = member.getSysGb();
		if(sysGb == null || sysGb.trim().isEmpty()) {
			errors.rejectValue("sysGb", "공백오류", "시스템구분을 선택하세요");
			
		}		
//		업무구분 유효성 체크)		
		String taskGb = member.getTaskGb();
		if(taskGb == null || taskGb.trim().isEmpty()) {
			errors.rejectValue("taskGb", "공백오류", "업무구분을 선택하세요");
			
		}		
//		업무구분 유효성 체크)		
		String userDevId = member.getUserDevId();
		if(userDevId == null || userDevId.trim().isEmpty()) {
			errors.rejectValue("userDevId", "공백오류", "개발자를 선택하세요");
			
		}			
		
	}
}
