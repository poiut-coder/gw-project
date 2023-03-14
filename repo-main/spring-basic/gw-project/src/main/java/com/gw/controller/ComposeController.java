package com.gw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ComposeController {

	@GetMapping(path = { "/compose.action"})
	public String compose() {
		return "compose";
	}
	@GetMapping(path = { "/list.action"})
	public String list() {
		return "list";
	}
	@GetMapping(path = { "/delete.action"})
	public String delete() {
		return "deleted";
	}
	
}
