/**
 * @author Mohammed Ali Anis
 */
package elbiscms;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;

public class Datum {


	public static boolean[] compareDate(String from, String to) {

		boolean [] boolArr = new boolean[2];
		
		DateTimeFormatter date = DateTimeFormatter.ofPattern("yyyyMMdd");
		LocalDateTime localDate = LocalDateTime.now();

		String now = date.format(localDate).toString();
		System.out.println("now  : " + now);

		char[] fromArr = from.toCharArray();
		from = "";

		for (int i = 0; i < fromArr.length; i++) {
			if (fromArr[i] != '.') {
				from = from + fromArr[i];
			} else
				continue;
		}

		char[] toArr = to.toCharArray();
		to = "";

		for (int i = 0; i < toArr.length; i++) {
			if (toArr[i] != '.') {
				to = to + toArr[i];
			} else
				continue;
		}

		if (from.length() != 8) {
			from = "0" + from;
		}

		if (to.length() != 8) {
			to = "0" + to;
		}

		char[] FromArr = new char[from.length()];

		FromArr[0] = from.charAt(4);
		FromArr[1] = from.charAt(5);
		FromArr[2] = from.charAt(6);
		FromArr[3] = from.charAt(7);
		FromArr[4] = from.charAt(2);
		FromArr[5] = from.charAt(3);
		FromArr[6] = from.charAt(0);
		FromArr[7] = from.charAt(1);

		from = "";
		for (int i = 0; i < FromArr.length; i++) {
			from = from + FromArr[i];
		}
		System.out.println("From : " + from);

		char[] ToArr = new char[to.length()];

		ToArr[0] = to.charAt(4);
		ToArr[1] = to.charAt(5);
		ToArr[2] = to.charAt(6);
		ToArr[3] = to.charAt(7);
		ToArr[4] = to.charAt(2);
		ToArr[5] = to.charAt(3);
		ToArr[6] = to.charAt(0);
		ToArr[7] = to.charAt(1);

		to = "";
		for (int i = 0; i < ToArr.length; i++) {
			to = to + ToArr[i];
		}
		System.out.println("To   : " + to);
		
		if(now.compareTo(from) == 1 || now.compareTo(from) == 0 ) {
			boolArr[0]=true;
		}
		else
			boolArr[0]=false;
		
		if(to.compareTo(now) == 1 || to.compareTo(now) == 0 ) {
			boolArr[1]=true;
		}
		else
			boolArr[1]=false;

		return boolArr;
	}

}
