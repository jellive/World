package com.webapp.controller;

import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.webapp.command.CityCommand;
import com.webapp.command.Code;
import com.webapp.mapper.CityMapper;
import com.webapp.mapper.CountryMapper;
import com.webapp.model.City;
import com.webapp.validator.CityCommandValidator;

@Controller
@RequestMapping("/city")
public class CityController {

	static Log log = LogFactory.getLog(CityController.class);

	@Autowired
	CountryMapper countryMapper;
	@Autowired
	CityMapper cityMapper;
	@Autowired
	CityCommandValidator validator;

	// 서블릿처럼...
	@RequestMapping("/district/{countrycode:[A-Z]{3}}")
	String getDistricts(@PathVariable String countrycode, Model model) {
		// 완전한 HTML이 아닌, 문서의 일부(나라를 고르면 행정구역을 정하는)를 넣는 메서드다.
		// Path에 있는 값을 넣어라!(?없이)
		log.info("getDistricts() ... countryCode : " + countrycode);

		List<String> districts = cityMapper.selectDistricts(countrycode);

		model.addAttribute("districts", districts);

		return "city/districts";
	}

	// Parameter방식(?처럼...)
	@RequestMapping()
	String listByParameter(String countrycode, Model model) {
		model.addAttribute("countrycode", countrycode);

		List<Code> list = countryMapper.selectCodes();

		for (Code c : list) {
			log.info("code = " + c.getCode() + " name= " + c.getName());

		}

		return "city/list";
	}

	@RequestMapping("/list")
	void listByServletRequest(HttpServletRequest request, Model model) {
		String countrycode = request.getParameter("countrycode");
		log.info("requestURI = " + request.getRequestURI());
		model.addAttribute("countrycode", countrycode);
	}

	@ModelAttribute("countryCode")
	// Model에 핸들러가 자동으로 넣어준다.....
	// 한번 고른 걸 자동으로 selected까지 해 줌!
	List<Code> getCountryCode() {
		// Map<String, String> countryCode = new HashMap<String, String>();
		// countryCode.put("KOR", "대한민국");
		// countryCode.put("USA", "쌀국");
		// countryCode.put("JPN", "쪽국");
		// countryCode.put("CHN", "긐긐국");
		List<Code> model = countryMapper.selectCodes();
		log.info("getCountryCode()... size = " + model.size());

		return model;
	}

	@ModelAttribute("districts")
	// district로 Request에 추가한당!
	List<String> getDistricts(String countryCode) {
		// List<District> list = new ArrayList<District>();

		// list.add(new District("Seoul", "서울"));
		// list.add(new District("Pusan", "부산"));
		// list.add(new District("Inchon", "인천"));
		// list.add(new District("Taegu", "대구"));
		// list.add(new District("Taejon", "대전"));
		// list.add(new District("Kwangju", "광주"));
		// list.add(new District("Kyongsangnam", "경상남도"));
		// list.add(new District("Kyonggi", "경기도"));
		// list.add(new District("Chollabuk", "전라북도"));
		// list.add(new District("Chungchongbuk", "충청북도"));
		// list.add(new District("Kyongsangbuk", "경상북도"));
		// list.add(new District("Chungchongnam", "충청남도"));
		// list.add(new District("Cheju", "제주도"));
		// list.add(new District("Chollanam", "전라남도"));
		// list.add(new District("Kang-won", "강원도"));

		List<String> model = cityMapper.selectDistricts(countryCode);

		log.info("getDistricts()... size = " + model.size());
		return model;
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	// String register(CityCommand command) {
	String registerForm(@ModelAttribute("city") CityCommand command) {
		// 자동으로 model객체에 add된당.
		// 그 일을 HandlerAdapter가 함..
		// model.addAttribute("cityCommand",command); // 요렇게..
		// 둘의 이름이 같으면, Query String에 적은 걸 객체에 자동으로 binding해준다.

		log.info("registerForm()...");
		return "city/registerForm";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	// String register(CityCommand command) {
	String register(@ModelAttribute("city") CityCommand command, Errors errors, Model model) {
		// city는 registerSuccess.jsp에서 다룰 것.
		log.info("/register() : POST");
		// 자동으로 model객체에 add된당.
		// 그 일을 HandlerAdapter가 함..
		// model.addAttribute("cityCommand",command); // 요렇게..
		// 둘의 이름이 같으면, Query String에 적은 걸 객체에 자동으로 binding해준다.

		/*
		 * CityCommand Validation
		 */

		validator.validate(command, errors);

		// 혹시 컴파일 에러가 난다면, 이걸로 찾는 방법도 있음.

		if (errors.hasFieldErrors("name")) {
			FieldError e = errors.getFieldError("name");

			String[] codes = e.getCodes();
			for (String s : codes)
				log.info("[" + s + "]");
		}

		if (errors.hasErrors()) {
			errors.reject("city.register", new Object[] { command.getName() }, "City global error"); // Global
			// Error
			// 각각 필드에 대해 에러가 있으면 reject되도록..(글로벌 에러)
			return "city/registerForm";
		}

		/*
		 * DB Register ==> Service를 사용해서 처리
		 */

		City city = command.getCity();
		cityMapper.insert(city);
		model.addAttribute("city", city);
		// model을 덮어씌움.(ID추가한 형태로)

		return "city/registerSuccess";
	}

	@RequestMapping("/modify")
	String modify(@ModelAttribute("city") CityCommand command, Errors errors) {
		// 자료형을 잘못 넣으면 400에러가 뜨면서 아예 이 쪽으로 들어오지도 않음.
		// 그래도 들어와야 할 경우가 있는데, 이럴 때에는 Errors를 선언하면 된다.
		// Errors는 항상 주된 객체 뒤에 선언 되어야 함.
		if (errors.hasFieldErrors()) {
			List<FieldError> fieldErrors = errors.getFieldErrors();
			for (FieldError fe : fieldErrors) {
				log.info("field = " + fe.getField()); // 틀린 곳
				log.info("objectName = " + fe.getObjectName()); // 틀린 객체
				log.info("code = " + Arrays.toString(fe.getCodes()));
				// 틀린 에러 코드
				log.info("rejectedVaslue = " + fe.getRejectedValue()); // 틀린 값

			}
		}
		return "city/modify";
	}
}
