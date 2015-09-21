package com.webapp.regex;

import java.util.Scanner;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegexTest {

	// 문자열 검색, 대체, 추출 ==> 정규표현식(Regular Expression)
	//
	// . -> new line을 제외한 모든 문자.
	// ^ -> 라인의 시작
	// $ -> 라인의 끝
	// * -> 앞문자가 0개 이상 반복
	// + -> 앞문자가 1개 이상 반복
	// ? -> 앞문자가 없거나 하나 있음.
	// [AYZ] -> 셋 중에 하나만 들어있으면 참.
	// [A-Z] -> 대문자중에 하나만 있으면 됨. 한자리만.
	// [A-Za-z0-9] -> 특수문자빼고 다 됨.
	// [A-Za-z0-9]{n} -> 특수문자빼고 다 됨. 앞 문자가 n개 반복.
	// {n,} -> 앞 문자가 n개 이상 반복
	// {n,m} -> 앞 문자가 n개 이상, m개 이하 반복

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);

		// System.out.println(Pattern.matches(".", "x"));
		// System.out.println(Pattern.matches("^.", "한"));

		// matches는 시작과 끝을 가정함.

		// String regex = "^.$";
		// String regex = "^A*$";
		// String regex = "^A+$";
		// String regex = "^[AYZ]$";
		// String regex = "^[A-Za-z0-9]{3}$";
		// String regex = "^[가-힣]{3,5}$";

//		String regex = "^[A-Za-z]{3}"; // 영어가 세 번 반복되면 true.
		String regex = "^[0][1-2][0-9]{7,9}";

		while (true) {
			String line = scan.nextLine();
			System.out.println("line = [" + line + "]");
			// System.out.println("match = " + Pattern.matches(regex, line));

			Pattern pattern = Pattern.compile(regex);
			Matcher m = pattern.matcher(line);
			System.out.println(m.find());
		}
	}
}