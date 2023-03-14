package com.gw.controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gw.dto.ApDocDto;
import com.gw.dto.ApDto;
import com.gw.dto.ApMemberDto;
import com.gw.dto.ApSheetDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.DeptDto;
import com.gw.dto.RoleDto;
import com.gw.service.ApprovalService;
import com.gw.ui.ApprovalOnOffPager;
import com.gw.ui.ApprovalPager;

@Controller // @Component + Web configuration
@RequestMapping(path = { "/approval" })
public class ApprovalController {

	private final int PAGE_SIZE = 10; // 한 페이지에 표시되는 데이터 개수
	private final int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
	private final String LINK_URL = "manage"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
	private final String LINK_URL_SEND = "send"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
	private final String LINK_URL_RECEIVE = "receive"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로

	@Autowired
	@Qualifier("approvalService")
	private ApprovalService approvalService;
	
	// 결재함으로 이동
	@GetMapping(path = { "/receive" })
	public String approvalReceive(@RequestParam(defaultValue = "-1") int userNo, @RequestParam(defaultValue = "-1") int comNo, @RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		userNo = member.getMem_id_no();
		comNo = member.getMem_com_code();
		
		List<ApDto> aps = approvalService.findReceiveApprovalByPage(userNo, pageNo, PAGE_SIZE);
		List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
		int totalCount = approvalService.countReceiveApproval(userNo);
		ApprovalPager pager = new ApprovalPager(totalCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL_RECEIVE);
		
		approvalService.checkReceiveAlert(userNo);
		
		model.addAttribute("aps", aps);
		model.addAttribute("apMembers", apMembers);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		
		return "approval/approval_receive";
	}
	
	@GetMapping(path = { "/receive_list" })
	public String approvalReceiveList(@RequestParam(defaultValue = "-1") int userNo, @RequestParam(defaultValue = "-1") int comNo, @RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		userNo = member.getMem_id_no();
		comNo = member.getMem_com_code();
		
		List<ApDto> aps = approvalService.findReceiveApprovalByPage(userNo, pageNo, PAGE_SIZE);
		List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
		int totalCount = approvalService.countReceiveApproval(userNo);
		ApprovalPager pager = new ApprovalPager(totalCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL_RECEIVE);
		
		model.addAttribute("aps", aps);
		model.addAttribute("apMembers", apMembers);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		
		return "approval/approval_receive_list";
	}
	
	// 결재함 문서 보기
		@GetMapping(path = { "/receive_detail" })
		public String showReceiveApprovalDetail(@Param("apprNo") int apprNo, @Param("docNo") int docNo, @RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {
			
			MemberDto member = (MemberDto) session.getAttribute("loginuser");
			int comNo = member.getMem_com_code();
			
			ApDocDto doc = approvalService.findDoc(docNo);
			ApDto ap = approvalService.findApproval(apprNo);
			int group = ap.getAppr_group();
			List<ApDto> receivers = approvalService.findApprovalReceiver(group);
			List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
			
			model.addAttribute("doc", doc);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("ap", ap);
			model.addAttribute("receivers", receivers);
			model.addAttribute("apMembers", apMembers);
			
			return "approval/approval_receive_detail";
		}
		
		@GetMapping(path = { "/receive_detail_info" })
		public String showReceiveApprovalDetailInfo(@Param("apprNo") int apprNo, @RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {
			
			MemberDto member = (MemberDto) session.getAttribute("loginuser");
			int comNo = member.getMem_com_code();
			
			ApDto ap = approvalService.findApproval(apprNo);
			int group = ap.getAppr_group();
			List<ApDto> receivers = approvalService.findApprovalReceiver(group);
			List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
			
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("ap", ap);
			model.addAttribute("receivers", receivers);
			model.addAttribute("apMembers", apMembers);
			
			return "approval/approval_receive_detail_info";
		}
		
	

	// 기안함으로 이동
	@GetMapping(path = { "/send" })
	public String approvalSendList(@RequestParam(defaultValue = "-1") int userNo, @RequestParam(defaultValue = "-1") int comNo, @RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {
		
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		userNo = member.getMem_id_no();
		comNo = member.getMem_com_code();
		
		List<ApDto> aps = approvalService.findSendApprovalByPage(userNo, pageNo, PAGE_SIZE);
		List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
		int totalCount = approvalService.countSendApproval(userNo);
		ApprovalPager pager = new ApprovalPager(totalCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL_SEND);
		
		approvalService.checkSendAlert(userNo);
		
		model.addAttribute("aps", aps);
		model.addAttribute("apMembers", apMembers);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		
		return "approval/approval_send";
	}
	
	// 기안함 문서 보기
	@GetMapping(path = { "/send_detail" })
	public String showSendApprovalDetail(@Param("apprNo") int apprNo, @Param("docNo") int docNo, @RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {
		
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		int comNo = member.getMem_com_code();
		
		ApDocDto doc = approvalService.findDoc(docNo);
		ApDto ap = approvalService.findApproval(apprNo);
		int group = ap.getAppr_group();
		List<ApDto> receivers = approvalService.findApprovalReceiver(group);
		List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
		
		model.addAttribute("doc", doc);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("ap", ap);
		model.addAttribute("receivers", receivers);
		model.addAttribute("apMembers", apMembers);
		
		return "approval/approval_send_detail";
	}

	// 결재 문서 작성으로 이동
	@GetMapping(path = { "/write" })
	public String approval_compose(@RequestParam(defaultValue = "-1") int userNo, HttpSession session, Model model) {

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		userNo = member.getMem_id_no();

		List<ApSheetDto> sheets = approvalService.findSheets(userNo);
		model.addAttribute("sheets", sheets);
		return "approval/approval_write";
	}

	// 결재 관리로 이동
	@GetMapping(path = { "/manage" })
	public String showApprovalManage(@RequestParam(defaultValue = "0") int onStar, @RequestParam(defaultValue = "-1") int comNo,
			@RequestParam(defaultValue = "-1") int userNo, @RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(defaultValue = "1") int sPageNo, HttpSession session, Model model) {

		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		userNo = member.getMem_id_no();
		comNo = member.getMem_com_code();

		List<ApDocDto> docs;
		int totalCount;
		ApprovalOnOffPager pager;

		if (onStar == 0) {
			totalCount = approvalService.countDocs(userNo);
			docs = approvalService.findDocsByPage(userNo, pageNo, PAGE_SIZE);
			pager = new ApprovalOnOffPager(totalCount, pageNo, sPageNo, PAGE_SIZE, PAGER_SIZE, onStar, LINK_URL);
		} else {
			totalCount = approvalService.countDocsByStar(userNo);
			docs = approvalService.findDocsByStar(userNo, sPageNo, PAGE_SIZE);
			pager = new ApprovalOnOffPager(totalCount, pageNo, sPageNo, PAGE_SIZE, PAGER_SIZE, onStar, LINK_URL);
		}

		

		model.addAttribute("docs", docs);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("sPageNo", sPageNo);
		model.addAttribute("onStar", onStar);

		int count = approvalService.countRoutes(userNo);
		List<ApDto> routes = approvalService.findRoutes(userNo);
		model.addAttribute("routes", routes);	
		model.addAttribute("count", count);
		
		List<DeptDto> depts = approvalService.findDepts(comNo);
		List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
		model.addAttribute("depts", depts);
		model.addAttribute("apMembers", apMembers);
		
		return "approval/approval_manage";
	}

	// 결재 문서 리스트 불러오기
	@GetMapping(path = { "/doc_list" })
	public String showDocList(@RequestParam(defaultValue = "0") int onStar,
			@RequestParam(defaultValue = "-1") int userNo, @RequestParam(defaultValue = "1") int pageNo,
			@RequestParam(defaultValue = "1") int sPageNo, HttpSession session, Model model) {
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		userNo = member.getMem_id_no();

		List<ApDocDto> docs;
		int totalCount;
		ApprovalOnOffPager pager;

		if (onStar == 0) {
			totalCount = approvalService.countDocs(userNo);
			docs = approvalService.findDocsByPage(userNo, pageNo, PAGE_SIZE);
			pager = new ApprovalOnOffPager(totalCount, pageNo, sPageNo, PAGE_SIZE, PAGER_SIZE, onStar, LINK_URL);
		} else {
			totalCount = approvalService.countDocsByStar(userNo);
			docs = approvalService.findDocsByStar(userNo, sPageNo, PAGE_SIZE);
			pager = new ApprovalOnOffPager(totalCount, pageNo, sPageNo, PAGE_SIZE, PAGER_SIZE, onStar, LINK_URL);
		}

		model.addAttribute("docs", docs);
		model.addAttribute("pager", pager);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("sPageNo", sPageNo);
		model.addAttribute("onStar", onStar);

		return "approval/approval_doc_list";
	}

	// 결재 경로 멤버 보기
	@GetMapping(path = { "/find_approval_member" })
	public String showMemberListByDept(@Param("deptNo") int deptNo, @RequestParam(defaultValue = "-1")int comNo, HttpSession session, Model model) {

		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		comNo = member.getMem_com_code();
		
		List<MemberDto> members = approvalService.findMembersByDept(deptNo, comNo);
		List<MemberDetailDto> details = approvalService.findMembersDetail();
		List<RoleDto> roles = approvalService.findRoles();

		model.addAttribute("members", members);
		model.addAttribute("details", details);
		model.addAttribute("roles", roles);

		return "approval/approval_route_member";
	}

	// 결재 문서 보기로 이동
	@GetMapping(path = { "/detail" })
	public String showApprovalDetail(@RequestParam(defaultValue = "0") int onStar, @Param("docNo") int docNo,
			@RequestParam(defaultValue = "1") int pageNo, @RequestParam(defaultValue = "1") int sPageNo,
			HttpSession session, Model model) {
		ApDocDto doc = approvalService.findDoc(docNo);
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		if (doc.getDoc_sender() != member.getMem_id_no()) {
			return "";
		}
		model.addAttribute("doc", doc);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("sPageNo", sPageNo);
		model.addAttribute("onStar", onStar);
		return "approval/approval_detail";
	}

	// 결재 문서 수정으로 이동
	@GetMapping(path = { "/edit" })
	public String showApprovaledit(@RequestParam(defaultValue = "0") int onStar, @Param("docNo") int docNo,
			@RequestParam(defaultValue = "1") int pageNo, @RequestParam(defaultValue = "1") int sPageNo,
			HttpSession session, Model model) {
		ApDocDto doc = approvalService.findDoc(docNo);
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		if (doc.getDoc_sender() != member.getMem_id_no()) {
			return "";
		}
		model.addAttribute("doc", doc);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("sPageNo", sPageNo);
		model.addAttribute("onStar", onStar);
		return "approval/approval_edit";
	}

	// 결재 문서 작성
	@GetMapping(path = { "/write_approval_doc" })
	@ResponseBody
	public String writeDoc(ApDocDto doc) {
		approvalService.writeDoc(doc);

		return "success";
	}

	@GetMapping(path = { "/modify_approval_doc" })
	@ResponseBody
	public String modifyDoc(ApDocDto doc) {
		approvalService.modifyDoc(doc);
		return "success";
	}

	// 결재 문서 삭제
	@GetMapping(path = { "/delete_approval_doc" })
	@ResponseBody
	public String deleteDoc(@RequestParam(defaultValue = "-1") int docNo) {
		approvalService.deleteDoc(docNo);
		return "success";
	}

	// 결재 문서 즐겨찾기 수정
	@GetMapping(path = { "/update_starmark" })
	@ResponseBody
	public String modifyStar(@RequestParam(defaultValue = "-1") int docNo) {
		approvalService.modifyStar(docNo);
		return "success";
	}

	// 결재 문서 메모 작성 및 수정
	@PostMapping(path = { "/write_memo" })
	@ResponseBody
	public String writeMemo(ApDocDto doc) {
		approvalService.writeDocMemo(doc);
		return "success";
	}

	// 결재 문서 메모 삭제
	@GetMapping(path = { "/delete_memo" })
	@ResponseBody
	public String deleteMemo(@RequestParam(defaultValue = "-1") int doc_id_no) {
		approvalService.deleteDocMemo(doc_id_no);
		return "success";
	}

	// 결재 문서 양식 가져오기
	@GetMapping(path = { "/doc_sheet" }, produces = "application/text;charset=utf8")
	@ResponseBody
	public String showDocSheet(int sheetNo) {
		ApSheetDto sheet = approvalService.findSheet(sheetNo);
		String sheetContent = sheet.getSheet_content();
		return sheetContent;
	}

	// 결재 문서 양식 리스트 불러오기
	@GetMapping(path = { "/sheet_list" })
	public String sheet_list(@RequestParam(defaultValue = "-1") int userNo, HttpSession session, Model model) {
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		userNo = member.getMem_id_no();

		List<ApSheetDto> sheets = approvalService.findSheets(userNo);
		model.addAttribute("sheets", sheets);
		return "approval/approval_doc_sheet";
	}

	// 결재 문서 양식 추가
	@GetMapping(path = { "/add_sheet" })
	@ResponseBody
	public String addApprovalSheet(ApSheetDto sheet) {
		approvalService.addSheet(sheet);
		return "success";
	}

	// 결재 문서 양식 삭제
	@GetMapping(path = { "/del_sheet" })
	@ResponseBody
	public String deleteApprovalSheet(int sheetNo) {
		approvalService.deleteSheet(sheetNo);
		return "success";
	}
	
	//결재 경로 추가
	@PostMapping(path = {"/add_approval_route"})
	@ResponseBody
	public String addApprovalRoute(int[] memberIds, HttpSession session) {
	
	  MemberDto member = (MemberDto)session.getAttribute("loginuser");
	  int userNo = member.getMem_id_no();
	  int count = approvalService.countRoutes(userNo);
	  
	  if (count >= 5) { return Integer.toString(count); }
	  
	  for (int memberId : memberIds) {
	  
	  approvalService.addRoute(userNo,memberId);}
	
	  count = approvalService.countRoutes(userNo);
		
	return Integer.toString(count);
	}
		
	//결재 경로 삭제
	@PostMapping(path = {"/del_approval_route"})
	@ResponseBody
	public String delApprovalRoute(@RequestParam(defaultValue = "-1") int apprNo, HttpSession session) {
	
	  MemberDto member = (MemberDto)session.getAttribute("loginuser");
	  int userNo = member.getMem_id_no();
	  int count;
	  
	  approvalService.delRoute(apprNo);
	
	  count = approvalService.countRoutes(userNo);
		
	return Integer.toString(count);
	}
	
	//결재 경로 이동
	@GetMapping(path = {"/up_approval_route"})
	@ResponseBody
	public String upApprovalRoute(@RequestParam(defaultValue = "-1") int apprNo, HttpSession session) {
	
	MemberDto member = (MemberDto)session.getAttribute("loginuser");
    int userNo = member.getMem_id_no();	
		
	List<ApDto> aps = approvalService.findRoutes(userNo);
	
	ApDto ap = approvalService.findApproval(apprNo);
	
	int preTurn = ap.getAppr_preturn();
	
	if (preTurn == aps.get(0).getAppr_preturn()) {
		return "success";
	}
	
	for (int i = 0; i < aps.size(); i++) {
		if (preTurn == aps.get(i).getAppr_preturn()) {
			
			int ownPreTurn = aps.get(i).getAppr_preturn();
			int prevPreTurn = aps.get(i-1).getAppr_preturn();
			
			approvalService.modifyRoute(prevPreTurn, aps.get(i).getAppr_id_no());
			approvalService.modifyRoute(ownPreTurn, aps.get(i-1).getAppr_id_no());
		}
		
	}
		
	return "success";
	}
	
	@GetMapping(path = {"/down_approval_route"})
	@ResponseBody
	public String downApprovalRoute(@RequestParam(defaultValue = "-1") int apprNo, HttpSession session) {
	
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
	    int userNo = member.getMem_id_no();	
			
		List<ApDto> aps = approvalService.findRoutes(userNo);	
		
		ApDto ap = approvalService.findApproval(apprNo);
		
		int preTurn = ap.getAppr_preturn();
		
		if (preTurn == aps.get(aps.size()-1).getAppr_preturn()) {
			return "success";
		}
		
		for (int i = 0; i < aps.size(); i++) {
			if (preTurn == aps.get(i).getAppr_preturn()) {
				
				int ownPreTurn = aps.get(i).getAppr_preturn();
				int nextPreTurn = aps.get(i+1).getAppr_preturn();
				
				approvalService.modifyRoute(nextPreTurn, aps.get(i).getAppr_id_no());
				approvalService.modifyRoute(ownPreTurn, aps.get(i+1).getAppr_id_no());
			}
			
		}
			
		return "success";
	}
	
	//전자결재 기안
	@PostMapping(path = {"/get_approval"})
	@ResponseBody
	public String getApproval(int[] apprNo, @RequestParam(defaultValue = "-1") int docNo, String approval_memo, HttpSession session) {
	
	  MemberDto member = (MemberDto)session.getAttribute("loginuser"); int userNo =
	  member.getMem_id_no(); int count;
	  
	  
	  int group = apprNo[0];
	  
	  for (int i = 0; i < apprNo.length; i++) { approvalService.getApproval((i+1),
	  docNo, group, approval_memo, apprNo[i]);
	  
	  if (i == 0) { approvalService.getApprovalValid1(apprNo[0]); } else {
	  approvalService.getApprovalValid2(apprNo[i]); } }
	  
	  count = approvalService.countRoutes(userNo);
	  
	 return Integer.toString(count);
		
	}
	
	//전자결재 승인
	@GetMapping(path = {"/admit_approval"})
	@ResponseBody
	public String admitApproval(@RequestParam(defaultValue = "-1") int apprNo, HttpSession session) {
	 
	approvalService.admitApproval(apprNo);
	approvalService.SendAlert(apprNo);
	ApDto ap = approvalService.findApproval(apprNo);
	int group = ap.getAppr_group();
	int turn = (ap.getAppr_turn() + 1);
	approvalService.approvalValidAdmit(group, turn);
		
	 return "success";
		
	}
		
	//전자결재 반려
	@GetMapping(path = {"/reject_approval"})
	@ResponseBody
	public String rejectApproval(@RequestParam(defaultValue = "-1") int apprNo, String rejectMemo, HttpSession session) {
	  
		approvalService.rejectApproval(rejectMemo, apprNo);
		approvalService.SendAlert(apprNo);
		ApDto ap = approvalService.findApproval(apprNo);
		
		int group = ap.getAppr_group();
		
		approvalService.noneApproval(group);
		approvalService.SendAlertNone(group);
		
	 return "success";
		
	}
	
	//결재 경로 불러오기
	@GetMapping(path = { "/route_list" })
	public String route_list(@RequestParam(defaultValue = "-1") int apprNo, HttpSession session, Model model) {
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		int userNo = member.getMem_id_no();
		int comNo = member.getMem_com_code();
		
		List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
		List<ApDto> routes = approvalService.findRoutes(userNo);
		model.addAttribute("routes", routes);
		model.addAttribute("apMembers", apMembers);
		model.addAttribute("apprNo", apprNo);
		
		return "approval/approval_route_list";
	}
	
	//결재 경로 불러오기2
	@GetMapping(path = { "/added_route_list" })
	public String added_route_list(HttpSession session, Model model) {
		MemberDto member = (MemberDto) session.getAttribute("loginuser");
		int userNo = member.getMem_id_no();
		int comNo = member.getMem_com_code();
		
		List<ApMemberDto> apMembers = approvalService.findApMembers(comNo);
		List<ApDto> routes = approvalService.findRoutes(userNo);
		model.addAttribute("routes", routes);
		model.addAttribute("apMembers", apMembers);
		return "approval/approval_added_route_list";
	}
	
	//결재 경로수 불러오기
	@GetMapping(path = {"/count_approval_route"})
	@ResponseBody
	public String countApprovalRoute(HttpSession session) {
	
	  MemberDto member = (MemberDto)session.getAttribute("loginuser");
	  int userNo = member.getMem_id_no();
	  int count = approvalService.countRoutes(userNo);
		
	return Integer.toString(count);
	}
	
	//결재내용 불러오기
	
}