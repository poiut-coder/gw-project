package com.gw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DashboardController {

	@GetMapping(path = { "/dashboard.action"})
	public String dashboard() {
		return "dashboard";
	}
}
