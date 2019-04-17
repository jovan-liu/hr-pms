package com.lzh.hr.pms.mapper.test;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.lzh.hr.pms.util.DateAPI;

public class DateTest {

	public static void main(String[] args) {
		
		Calendar cale = null;
		cale = Calendar.getInstance();
		cale.add(Calendar.MONTH, -1);
		cale.set(Calendar.DAY_OF_MONTH, 1);
		System.out.println(cale.getTime());
		
		cale.add(Calendar.MONTH, 1);
		cale.set(Calendar.DAY_OF_MONTH, 0);
		System.out.println(cale.getTime());
		System.out.println(cale.get(Calendar.DATE));
		
		
//		cale = Calendar.getInstance();
//		cale.add(Calendar.MONTH, 0);
//		cale.set(Calendar.DAY_OF_MONTH, 1);
		
		
//		cale = Calendar.getInstance();
//		cale.add(Calendar.MONTH, 1);
//		cale.set(Calendar.DAY_OF_MONTH, 0);
//		
//		System.out.println(cale.getTime());
		
		Date now = new Date();
		int hours = now.getHours();
		int minutes = now.getMinutes();
		System.out.println(hours + " " + minutes);
		if (hours > 9 && minutes >= 10) {
			System.out.println("迟到");
		}
		
		if (hours < 18) {
			System.out.println("早退");
		}
	}
}
