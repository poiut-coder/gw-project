package com.gw.controller;


import java.lang.reflect.Member;
import java.util.ArrayList;
import java.util.List;


import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.fasterxml.jackson.annotation.JsonCreator;
import com.gw.dto.*;
import com.mysql.cj.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.View;
import org.springframework.web.servlet.view.RedirectView;

import com.gw.service.AccountService;
import com.gw.ui.MemberPager;

@Controller
public class AccountController {
	private final int PAGE_SIZE = 5; // 한 페이지에 표시되는 데이터 개수
	private final int PAGER_SIZE = 3; // 한 번에 표시할 페이지 번호 개수
	private final String A_LINK_URL = "/gw-project/member/admin/member-list"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
	private final String R_LINK_URL = "/gw-project/member/admin/retire-member-list"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로

//
//	@Autowired
//	private FileUploadService fileUploadService;

	@Autowired
	@Qualifier("accountService")
	private AccountService accountService;


//	@GetMapping(path = { "member/settings" })
//	public String settings(){
//		return "/member/settings";
//	}
//
//	@PostMapping(path = { "member/settings" })
//	public String settings(CompanyDto company, DeptDto dept, RoleDto role, MemberDto member){
//
//		return"/member/settings";
//	}

	@GetMapping(path = { "member/register" })
	public String register(Model model) {

		List<CompanyDto> companies = accountService.findAllCompanies();
		//List<DeptDto> depts = accountService.findAllDeptsByCompId();
//		List<DeptDto> depts = accountService.findAllDepts();
//		List<RoleDto> roles = accountService.findAllRoles();

		model.addAttribute("companies", companies);

		return "/member/register";

	}

///////연습중//////대분류//////./...


	@PostMapping(path = { "member/register" })
	public String register(@Valid MemberDto member, BindingResult br) { // @Valid에 의해 검출된 오류 정보가 저장된 객체

		if (br.hasErrors()) {
			System.out.println("유효성 검사 오류 발생");
			return "/member/register";
		}


		System.out.println(member.getMemberDetail());

		accountService.registerMember(member);

		System.out.println(member);

		return "redirect:/";
	}


	/// loginController///////////////////////////////

	@GetMapping(path = { "member/login" })
	public String showLoginForm() {
		return "/member/login";
	}

	// post로 들어간 데이터 읽기
	@PostMapping(path = { "member/login" })
	public String login(int mem_id_no, String mem_passwd, HttpSession session, Model model) {


		MemberDto member = accountService.findMemIdNoPasswd(mem_id_no, mem_passwd);

		System.out.println(member);
		//TODO 관리자 로그인 시 member값 받도록 하려고;;

		int memAdmin = member.getMem_admin();

		if (memAdmin == 1) {
			session.setAttribute("adminuser", memAdmin);
			return "/member/admin/admin-home";
		}else if(memAdmin == 2 ) {
			session.setAttribute("generaluser", member);
			return "/member/member2";
		}else if(member != null ) {
			session.setAttribute("loginuser", member);
		}else {
			model.addAttribute("fail", mem_id_no);
			return "/member/login";
		}
		return "redirect:/home2";
	}




	@GetMapping(path = { "member/logout.action" })
	public View logout(HttpSession session) {

		session.removeAttribute("loginuser");

		return new RedirectView("/gw-project/");

	}

	// mypageController와 합쳐서
	// 마이페이지 조회 및 입력(회원가입할 때 detail까지 입력하지 않기때문)
	@GetMapping(path = { "member/member-modify" })
	public String showWriteMypageForm(int mem_id_no, Model model) {

		MemberDto member = accountService.findMemById(mem_id_no);

		if (member != null) {
			model.addAttribute("member", member);
			return "/member/member-modify";
		} else {
			return "redirect:/member/login";
		}

	}

	// 마이페이지 수정
	@PostMapping(path = { "member/member-modify" })

	public String modifiedMypage(MemberDto member, HttpSession session) {

		int mem_id = member.getMem_id_no();
		MemberDetailDto memberDetail = member.getMemberDetail();

		memberDetail.setMem_detail_id_no(mem_id);

		System.out.println(member.getMemberDetail());
		accountService.modifyMypage(member.getMemberDetail());

		System.out.println(member);
		return "redirect:/member/member-modify?mem_id_no=" + member.getMem_id_no();

	}


	// admin으로 로그인 한 후 login home 구현하기
	@GetMapping(path = { "member/admin/admin-home" })
	public String loginSuccess() {
		return "member/admin/admin-home";
	}



	// admin home에서 멤버리스트 페이지로 이동하기
	@GetMapping(path = { "member/admin/member-list" })
	public String showMemberList(@RequestParam(defaultValue = "1") int pageNo, @RequestParam(defaultValue = "-1") int mem_id_no, Model model) {

		List<MemberDto> members = accountService.findAllMemberByPage(pageNo, PAGE_SIZE);
		int memberCount = accountService.findActiveMemberCount();

		MemberPager pager = new MemberPager(memberCount, pageNo, PAGE_SIZE, PAGER_SIZE, A_LINK_URL);

		model.addAttribute("members", members);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageCount", pager.getPageCount());

		return "/member/admin/member-list";
	}

	@GetMapping(path = { "member/admin/admin-modified-member" })
	public String showAdminMemberModify(int mem_id_no,  Model model) {

		MemberDto member = accountService.findDetailMemAdminById(mem_id_no);
		List<DeptDto> depts = accountService.findMemDeptsByCompId(member.getMem_com_code());
		List<RoleDto> roles = accountService.findMemRolesByCompId(member.getMem_com_code());
		model.addAttribute("member", member);
		model.addAttribute("mem_id_no", mem_id_no);
		model.addAttribute("depts", depts);
		model.addAttribute("roles",roles);
		// model.addAttribute("adminuser",mem_admin);


		if (member != null) {
			model.addAttribute("member", member);
			return "/member/admin/admin-modified-member";
		} else {
			return "redirect:/member/admin/member-list";
		}
	}


	@PostMapping(path = { "member/admin/admin-modified-member" })
	public String editAuthorities (MemberDto member) {
		System.out.println(member);

		int mem_id = member.getMem_id_no();
		int mem_admin = member.getMem_admin();
		int mem_dept_no = member.getMem_dept_no();
		int mem_position_no = member.getMem_position_no();
		boolean mem_retire = member.isMem_retire();

		accountService.modifiedMember(member);
		System.out.println(member);

		// 메일 보내기

		// 메일 전송 구현
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message);

			messageHelper.setFrom("eathergs012@naver.com");
			messageHelper.setTo(member.getMemberDetail().getMem_detail_email());
			messageHelper.setSubject("회원 인증 완료");
			messageHelper.setText("계정 확인되었습니다. 로그인하세요", true);

			mailSender.send(message);

		} catch(Exception ex) {
			ex.printStackTrace();
		}

		return "redirect:/member/admin/admin-modified-member?mem_id_no=" + member.getMem_id_no();

	}
	// admin home에서 멤버리스트 페이지로 이동하기
	@GetMapping(path = { "member/admin/retire-member-list" })
	public String showRetireMemberList(@RequestParam(defaultValue = "1") int pageNo, @RequestParam(defaultValue = "-1") int mem_id_no, Model model) {

		List<MemberDto> members = accountService.findRetireMemberByPage(pageNo, PAGE_SIZE);
		int memberCount = accountService.findRetireMemberCount();

		MemberPager pager = new MemberPager(memberCount, pageNo, PAGE_SIZE, PAGER_SIZE, R_LINK_URL);


		model.addAttribute("members", members);
		model.addAttribute("pager",pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("pageCount", pager.getPageCount());

		return "/member/admin/retire-member-list";
	}
//search
	@PostMapping(path={"member/admin/admin-list/member-search"})
	public String showSearchForm(int pageNo, String memberSearchByName){
		List<MemberDto> member = accountService.findSearchMembersByName(memberSearchByName);

		return "";
	}


	@GetMapping(path = { "member/admin/send-mail" })
	public String showSendMailForm() {

		return "/member/admin/send-mail";
	}

	@Autowired
	@Qualifier("mailSender")
	private JavaMailSenderImpl mailSender;

	@PostMapping(path = { "member/admin/send-mail" })
	public String sendMail(String title, String from, String to, String content) {

		//for test
		String[] toList = { to, "eathergs012@gmail.com" };

		// 메일 전송 구현
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(message);

			messageHelper.setFrom(from);
			// messageHelper.setTo(to);
			messageHelper.setTo(toList);
			messageHelper.setSubject(title);
			messageHelper.setText(content, true);

			mailSender.send(message);

		} catch(Exception ex) {
			ex.printStackTrace();
		}

		return "/member/admin/send-mail";
	}

}



//	@GetMapping(path = { "/member/admin/mailSend" })
//	public String sendMailPost(int memId) {
////		System.out.println(title);
////		System.out.println(from);
////		System.out.println(to);
////		System.out.println(content);
//
//		MemberDto member = accountService.findAllMemberByMemId(memId);
//		MemberDetailDto detail = accountService.findMemDetailById(memId);
//
//		List<String> list = new ArrayList<String>();
//		list.add("eathergs012@gmail.com");
//		if (!StringUtils.isNullOrEmpty(detail.getMem_detail_email())) {
//			list.add(member.getMemberDetail().getMem_detail_email());
//		}
//
//		String[] a = {"eathergs012@gmail.com"};
//
////		String[] toList= {to,"eathergs012@gmail.com"};
//
//		try {
//			MimeMessage message=mailSender.createMimeMessage();
//			MimeMessageHelper messageHelper= new MimeMessageHelper(message);
//
////			messageHelper.setFrom(from);
//			messageHelper.setTo(a);
//			messageHelper.setSubject("완료됐어요!!");//제목
//			messageHelper.setText("완료됐어요!!",true);//html 의 내용과 동일한 내용 임력시 깨지는걸 방지하기 위해


//
//			mailSender.send(message);
//		}catch(Exception ex){
//			System.out.println("==============================>>>>>>>");
//			System.out.println(ex.getMessage());
//			System.out.println("==============================>>>>>>>");
//		}
//
//
//		return "redirect:/member/admin/admin-modified-member?mem_id_no=" + memId;
//	}



//}
