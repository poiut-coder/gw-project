package com.gw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class CalenderController {

	@GetMapping(path = { "/calender.action" })
	public String calender() {
		return "calender";
	}
}
