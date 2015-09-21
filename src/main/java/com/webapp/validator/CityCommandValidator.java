package com.webapp.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.webapp.command.CityCommand;

public class CityCommandValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		// validation을 하는 객체 타입을 외부에서 확인할 때 씀. 개발자가 호출할 일은 거의 음슴.
		return CityCommand.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		// 검사!
		CityCommand city = (CityCommand) target;

		/*
		 * validation. 그냥 reject는 global error, rejectValue는 field error임.
		 */
		// 비었는지 확인할 때에는 ValidationUtils에 있는 rejectIfEmptyOrWhitespace를 쓰면 이롭다.
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name", "required");
		// city.getName()은 안줘도 댐. 자동으로 name으로 인식하고 있음.개쩜ㅋ
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "countryCode", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "district", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "population", "required");

		if (city.getName().length() > 35) {
			errors.rejectValue("name", "length", new Object[] { 35 }, "도시 이름 길이는 35자까지!!");
		}

		if (city.getPopulation() < 0) {
			errors.rejectValue("population", "minus");
		}

		// errors.rejectValue("name", "error");
		// errors.rejectValue("countryCode", "error");
		// errors.rejectValue("district", "error");
		// errors.rejectValue("population", "error");

	}

}
