package com.webapp.command;

import com.webapp.model.City;
import com.webapp.model.Country;

public class CityCommand {

	// Model이 아님. Command 객체임. 바인딩하기 위한 목적.
	// 웰 브라우저에서 올라오는 파라미터를 담기 위한 커맨드 객체!
	// 증거로 ID가 없당!

	String name;
	String countryCode;
	String district;
	int population;

	public City getCity() {
		City city = new City();
		city.setName(name);

		Country c = new Country();
		c.setCode(countryCode);

		city.setCountry(c);
		city.setDistrict(district);
		city.setPopulation(population);
		return city;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCountryCode() {
		return countryCode;
	}

	public void setCountryCode(String countryCode) {
		this.countryCode = countryCode;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public int getPopulation() {
		return population;
	}

	public void setPopulation(int population) {
		this.population = population;
	}

}
