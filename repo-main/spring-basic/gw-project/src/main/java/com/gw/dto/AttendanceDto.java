package com.gw.dto;

import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class AttendanceDto {
	
	private int attd_mem_no;
	private Date attd_date;
	private Date attd_on;
	private Date attd_off;
	private int hh;
	private int mm;
	private int MM;
	
	public int setHour(Date attd_on) {

    SimpleDateFormat hourFormat = new SimpleDateFormat("HH");
    
    int hour = Integer.parseInt(hourFormat.format(attd_on));
	
	return hour;
	}
	
	public int setMin(Date attd_on) {
		
    SimpleDateFormat secFormat = new SimpleDateFormat("mm");
    
    int min = Integer.parseInt(secFormat.format(attd_on));
	
	return min;
	}
	
	
	public void setHourAndSec(int hh, int mm) {
		this.hh = hh;
		this.mm = mm;
	}
	
	public void setMonth(Date attd_date) {
		
	    SimpleDateFormat monthFormat = new SimpleDateFormat("MM");
	    
	    int month = Integer.parseInt(monthFormat.format(attd_date));
		
		this.MM = month;
	}
}