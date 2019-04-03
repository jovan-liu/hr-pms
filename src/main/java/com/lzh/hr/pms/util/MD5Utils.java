package com.lzh.hr.pms.util;

import java.util.Date;

public class MD5Utils {

	@SuppressWarnings("restriction")
	public static String encodePassword() {
		String password = new Date().toString();
		byte[] unencodedPassword = password.getBytes();
		java.security.MessageDigest md = null;
		try {
			md = java.security.MessageDigest.getInstance("MD5");
		} catch (Exception e) {
			return password;
		}
		md.reset();
		md.update(unencodedPassword);
		byte[] encodedPassword = md.digest();
		StringBuffer buf = new StringBuffer();
		for (int i = 0; i < encodedPassword.length; i++) {
			if ((encodedPassword[i] & 0xff) < 0x10) {
				buf.append("0");
			}
			buf.append(Long.toString(encodedPassword[i] & 0xff, 16));
		}

		String standardMd5 = buf.toString();
		byte[] ba = new byte[standardMd5.length() / 2];
		for (int i = 0; i < standardMd5.length(); i = i + 2) {
			ba[i == 0 ? 0 : i / 2] = (byte) (0xff & Integer.parseInt(standardMd5.substring(i, i + 2), 16));
		}
		return new sun.misc.BASE64Encoder().encode(ba);
	}

	public static void main(String[] args) {
		System.out.println(MD5Utils.encodePassword());
	}
}
