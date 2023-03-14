package com.gw.dto;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Calendar;
import java.util.Date;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import lombok.Data;

@Data
public class TodoDto {

	private String todo_no;
	@NotEmpty(message = "제목을 입력하세요")
	private String title;
	private String content;
	private int writer;
	private Date regDate;
	private Date startDate;
	private boolean is_deleted;
	private int startYear;
	private int startMonth;
	private int startDay;
	private int completeYear;
	private int completeMonth;
	private int completeDay;
	private String event_color;
	public Date completeDate;

	// getStartDate 조합
	public Date getStartDate() {
		setStartDate(getDate(getStartYear(), getStartMonth(), getStartDay()));
		return startDate;

	}

	// getCompleteDate 조합

	public Date getCompleteDate() {
		return getDate(getCompleteYear(), getCompleteMonth(), getCompleteDay());

	}

	// jsp용 StartDate
	public String getStartDateForJsp() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getStartDate());
		DateFormat df = new SimpleDateFormat("yyyy,MM,dd");
		
		cal.add(Calendar.MONTH, -1);

		return df.format(cal.getTime());

	}

	// jsp용 completeDate
	public String getCompleteDateForJsp() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getStartDate());
		DateFormat df = new SimpleDateFormat("yyyy,MM,dd");
		cal.setTime(getCompleteDate());
		cal.add(Calendar.MONTH, -1);
		cal.add(Calendar.DATE, +1);

		return df.format(cal.getTime());

	}

	// getStartDateForSql 조합
	public String getStartDateForSql() {
		changeForSql(getStartDate());

		return changeForSql(getStartDate());

	}

	// getCompleteDateForSql 조합
	public String getCompleteDateForSql() {
		changeForSql(getCompleteDate());
		return changeForSql(getCompleteDate());

	}
	
	// getContentForSql 조합
		public String getContentForSql() {
			String ContentForSql="%"+getContent()+"%";
			return ContentForSql;

		}

	// 조합 클레스
	public static Date getDate(int year, int month, int date) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, date);
		return new Date(cal.getTimeInMillis());
	}

	// sql용으로 변환
	public String changeForSql(Date date) {
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd ");
		return formatter.format(date);

	}

}
