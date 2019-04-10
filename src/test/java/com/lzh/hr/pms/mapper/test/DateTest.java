package com.lzh.hr.pms.mapper.test;

import java.util.Calendar;

public class DateTest {

	public static void main(String[] args) {
		Calendar cale = null;
		
//		cale = Calendar.getInstance();
//		cale.add(Calendar.MONTH, 0);
//		cale.set(Calendar.DAY_OF_MONTH, 1);
		cale = Calendar.getInstance();
		cale.add(Calendar.MONTH, 1);
		cale.set(Calendar.DAY_OF_MONTH, 0);
		
		System.out.println(cale.getTime());
	}
}
