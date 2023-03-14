package com.gw.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import com.gw.common.Util;
import com.gw.dto.MailAttachDto;
import com.gw.dto.MailDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.service.MailService;
import com.gw.ui.MailPager;
import com.gw.view.MailDownloadView;

@Controller
@RequestMapping(path = { "/mail" })
public class MailController {

	@Autowired
	@Qualifier("mailService")
	private MailService mailService;

	// 1. 전체메일함 목록보기
	@GetMapping(path = { "/mail-list.action" })
	public String showMailList(@RequestParam(defaultValue = "1") int pageNo, HttpSession session, String search, Model model) {

		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "mail-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
//		List<MailDto> mails = mailService.findMailByPage(loginuserid, mailbox_type, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
//		int mailCount = mailService.findMailCount(loginuserid, mailbox_type);
		List<MailDto> mails = mailService.findMailByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
		int mailCount = mailService.findMailCount(loginuserid);
		

		MailPager pager = new MailPager(mailCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (mailCount / PAGE_SIZE) + ((mailCount % PAGE_SIZE) > 0 ? 1 : 0);
		int pageBefore = 0;
		int pageNext = 0;

		if (pageNo == 1 && pageNo == pageCount) { // 페이지가 하나밖에 없을 경우.
			pageBefore = 1;
			pageNext = 1;
		} else if (pageNo == 1) { // 이전 페이지 활성화
			pageBefore = 1;
			pageNext = pageNo + 1;
		} else if (pageNo == pageCount) { // 다음 페이지 활성화
			pageBefore = pageNo - 1;
			pageNext = pageCount;
		} else { // 기본
			pageBefore = pageNo - 1;
			pageNext = pageNo + 1;
		};
		
		// 3. View에서 읽을 수 있도록 데이터 저장
		model.addAttribute("mails", mails);
		model.addAttribute("pager", pager);
		model.addAttribute("mailCount", mailCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);


		// 4. View or Controller로 이동
		return "mail/mail-list"; // /WEB-INF/views/ + mail/mail-list + .jsp
	}
	
	///////////////////////// 전체메일함 검색 
	@PostMapping(path= {"all-list-search.action"})
	public String searchAdminOrderByMemberId(@RequestParam(defaultValue = "") String search, HttpSession session, Model model) {

		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		if(search.length()==0) {

			return "redirect:mail-list.action";
		}
		List<MailDto> search1 = mailService.findMailBySearch(search, loginuserid);
		model.addAttribute("mails", search1);
		model.addAttribute("search", search);
		return "mail/mail-list";
	}

/////// 전체메일함 상세보기
	@GetMapping(path = { "/mail-all-detail.action" })
	public String showMailDetail(@RequestParam(defaultValue = "-1") int mailNo,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {
//		 1. 요청 데이터 읽기 ( 전달인자로 대체 )
//		if (mailNo == -1 || pageNo == -1) { // 요청 데이터가 잘못된 경우
//			return "redirect:mail-list.action";
//		}

		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		if (!readList.contains(mailNo)) { // 현재 글 번호가 읽은 글 목록에 포함되지 않은 경우
			mailService.increaseMailReadCount(mailNo); // 글 조회수 증가
			readList.add(mailNo); // 읽은 글 목록에 현개 글 번호 추가
		}

		MailDto mail = mailService.findMailByMailNo(mailNo);

//		if (mail == null) { // 조회되지 않은 경우 (글 번호가 잘못되었거나 또는 삭제된 글인 경우)
//			return "redirect:mail-list.action";
//		}

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("mail", mail);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "mail/mail-all-detail";
	}
	
	//////////////////////// 2. 받은메일함 목록보기
	@GetMapping(path = { "/mail-received-list.action" })
	public String showMailReceivedList(@RequestParam(defaultValue = "1") int pageNo, Model model, HttpSession session) {
		
		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "mail-received-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		
		List<MailDto> mails = mailService.findMailReceivedByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
		int mailCount = mailService.findMailReceivedCount(loginuserid);
		
		MailPager pager = new MailPager(mailCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (mailCount / PAGE_SIZE) + ((mailCount % PAGE_SIZE) > 0 ? 1 : 0);
		int pageBefore = 0;
		int pageNext = 0;

		if (pageNo == 1 && pageNo == pageCount) { // 페이지가 하나밖에 없을 경우.
			pageBefore = 1;
			pageNext = 1;
		} else if (pageNo == 1) { // 이전 페이지 활성화
			pageBefore = 1;
			pageNext = pageNo + 1;
		} else if (pageNo == pageCount) { // 다음 페이지 활성화
			pageBefore = pageNo - 1;
			pageNext = pageCount;
		} else { // 기본
			pageBefore = pageNo - 1;
			pageNext = pageNo + 1;
		};
		
		// 3. View에서 읽을 수 있도록 데이터 저장
		model.addAttribute("mails", mails);
		model.addAttribute("pager", pager);
		model.addAttribute("mailCount", mailCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);

		// 4. View or Controller로 이동
		return "mail/mail-received-list"; // /WEB-INF/views/ + mail/mail-list + .jsp
	}

/////// 받은메일함 상세보기
	@GetMapping(path = { "/mail-received-detail.action" })
	public String showMailReceivedDetail(@RequestParam(defaultValue = "-1") int mailNo,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {
//		 1. 요청 데이터 읽기 ( 전달인자로 대체 )
//		if (mailNo == -1 || pageNo == -1) { // 요청 데이터가 잘못된 경우
//			return "redirect:mail-list.action";
//		}

		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		if (!readList.contains(mailNo)) { // 현재 글 번호가 읽은 글 목록에 포함되지 않은 경우
			mailService.increaseMailReadCount(mailNo); // 글 조회수 증가
			readList.add(mailNo); // 읽은 글 목록에 현개 글 번호 추가
		}

		MailDto mail = mailService.findMailReceivedByMailNo(mailNo);

//		if (mail == null) { // 조회되지 않은 경우 (글 번호가 잘못되었거나 또는 삭제된 글인 경우)
//			return "redirect:mail-list.action";
//		}

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("mail", mail);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "mail/mail-received-detail";
	}

	
	////////////////////////  3. 보낸메일함 목록보기
	@GetMapping(path = { "/mail-send-list.action" })
	public String showMailSendList(@RequestParam(defaultValue = "1") int pageNo, Model model, HttpSession session) {
		
		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "mail-send-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		
		List<MailDto> mails = mailService.findMailSendByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
		int mailCount = mailService.findMailSendCount(loginuserid);
		
		MailPager pager = new MailPager(mailCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (mailCount / PAGE_SIZE) + ((mailCount % PAGE_SIZE) > 0 ? 1 : 0);
		int pageBefore = 0;
		int pageNext = 0;

		if (pageNo == 1 && pageNo == pageCount) { // 페이지가 하나밖에 없을 경우.
			pageBefore = 1;
			pageNext = 1;
		} else if (pageNo == 1) { // 이전 페이지 활성화
			pageBefore = 1;
			pageNext = pageNo + 1;
		} else if (pageNo == pageCount) { // 다음 페이지 활성화
			pageBefore = pageNo - 1;
			pageNext = pageCount;
		} else { // 기본
			pageBefore = pageNo - 1;
			pageNext = pageNo + 1;
		};
		
		// 3. View에서 읽을 수 있도록 데이터 저장
		model.addAttribute("mails", mails);
		model.addAttribute("pager", pager);
		model.addAttribute("mailCount", mailCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);

		// 4. View or Controller로 이동
		return "mail/mail-send-list"; // /WEB-INF/views/ + mail/mail-list + .jsp
	}

/////// 보낸메일함 상세보기
	@GetMapping(path = { "/mail-send-detail.action" })
	public String showMailSendDetail(@RequestParam(defaultValue = "-1") int mailNo,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {
//		 1. 요청 데이터 읽기 ( 전달인자로 대체 )
//		if (mailNo == -1 || pageNo == -1) { // 요청 데이터가 잘못된 경우
//			return "redirect:mail-list.action";
//		}

		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		if (!readList.contains(mailNo)) { // 현재 글 번호가 읽은 글 목록에 포함되지 않은 경우
			mailService.increaseMailReadCount(mailNo); // 글 조회수 증가
			readList.add(mailNo); // 읽은 글 목록에 현개 글 번호 추가
		}

		MailDto mail = mailService.findMailSendByMailNo(mailNo);

//		if (mail == null) { // 조회되지 않은 경우 (글 번호가 잘못되었거나 또는 삭제된 글인 경우)
//			return "redirect:mail-list.action";
//		}

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("mail", mail);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "mail/mail-send-detail";
	}

	
	///////////////////////////////// 4. 임시보관함
	@GetMapping(path = { "/mail-draft-list.action" })
	public String showMailDraftList(@RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {

		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "mail-draft-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		List<MailDto> mails = mailService.findMailDraftByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
		int mailCount = mailService.findMailDraftCount(loginuserid);

		MailPager pager = new MailPager(mailCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (mailCount / PAGE_SIZE) + ((mailCount % PAGE_SIZE) > 0 ? 1 : 0);
		int pageBefore = 0;
		int pageNext = 0;

		if (pageNo == 1 && pageNo == pageCount) { // 페이지가 하나밖에 없을 경우.
			pageBefore = 1;
			pageNext = 1;
		} else if (pageNo == 1) { // 이전 페이지 활성화
			pageBefore = 1;
			pageNext = pageNo + 1;
		} else if (pageNo == pageCount) { // 다음 페이지 활성화
			pageBefore = pageNo - 1;
			pageNext = pageCount;
		} else { // 기본
			pageBefore = pageNo - 1;
			pageNext = pageNo + 1;
		};
		
		
		// 3. View에서 읽을 수 있도록 데이터 저장
		model.addAttribute("mails", mails);
		model.addAttribute("pager", pager);
		model.addAttribute("mailCount", mailCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);

		// 4. View or Controller로 이동
		return "mail/mail-draft-list"; // /WEB-INF/views/ + mail/mail-list + .jsp
	}

/////// 임시메일함 상세보기
	@GetMapping(path = { "/mail-dfaft-detail.action" })
	public String showMailDraftDetail(@RequestParam(defaultValue = "-1") int mailNo,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {

		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		if (!readList.contains(mailNo)) { // 현재 글 번호가 읽은 글 목록에 포함되지 않은 경우
			mailService.increaseMailReadCount(mailNo); // 글 조회수 증가
			readList.add(mailNo); // 읽은 글 목록에 현개 글 번호 추가
		}

		MailDto mail = mailService.findMailDraftByMailNo(mailNo);

//		if (mail == null) { // 조회되지 않은 경우 (글 번호가 잘못되었거나 또는 삭제된 글인 경우)
//			return "redirect:mail-list.action";
//		}

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("mail", mail);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "mail/mail-draft-detail";
	}

	// 5. 내가쓴메일함 목록보기
		@GetMapping(path = { "/mail-my-list.action" })
		public String showMailMyList(@RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {

			// 페이지
			int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
			int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
			String LINK_URL = "mail-my-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
			// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
			// 2. 데이터 처리 ( 데이터 조회 )
			MemberDto member = (MemberDto)session.getAttribute("loginuser");
			int loginuserid = member.getMem_id_no();
			List<MailDto> mails = mailService.findMailMyByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
			int mailCount = mailService.findMailMyCount(loginuserid);

			MailPager pager = new MailPager(mailCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
			int pageCount = (mailCount / PAGE_SIZE) + ((mailCount % PAGE_SIZE) > 0 ? 1 : 0);
			int pageBefore = 0;
			int pageNext = 0;

			if (pageNo == 1 && pageNo == pageCount) { // 페이지가 하나밖에 없을 경우.
				pageBefore = 1;
				pageNext = 1;
			} else if (pageNo == 1) { // 이전 페이지 활성화
				pageBefore = 1;
				pageNext = pageNo + 1;
			} else if (pageNo == pageCount) { // 다음 페이지 활성화
				pageBefore = pageNo - 1;
				pageNext = pageCount;
			} else { // 기본
				pageBefore = pageNo - 1;
				pageNext = pageNo + 1;
			};
			// 3. View에서 읽을 수 있도록 데이터 저장
			model.addAttribute("mails", mails);
			model.addAttribute("pager", pager);
			model.addAttribute("mailCount", mailCount);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("PAGE_SIZE", PAGE_SIZE);
			model.addAttribute("PAGER_SIZE", PAGER_SIZE);
			model.addAttribute("LINK_URL", LINK_URL);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("pageBefore", pageBefore);
			model.addAttribute("pageNext", pageNext);

			// 4. View or Controller로 이동
			return "mail/mail-my-list"; // /WEB-INF/views/ + mail/mail-list + .jsp
		}

	/////// 내가쓴메일함 상세보기
		@GetMapping(path = { "/mail-my-detail.action" })
		public String showMailMyDetail(@RequestParam(defaultValue = "-1") int mailNo,
				@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {
//			 1. 요청 데이터 읽기 ( 전달인자로 대체 )
//			if (mailNo == -1 || pageNo == -1) { // 요청 데이터가 잘못된 경우
//				return "redirect:mail-list.action";
//			}

			// 2. 데이터 처리
			ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
			if (readList == null) { // 세션에 목록이 없으면
				readList = new ArrayList<>(); // 목록 새로 만들기
				session.setAttribute("read-list", readList); // 세션에 목록 등록
			}

			if (!readList.contains(mailNo)) { // 현재 글 번호가 읽은 글 목록에 포함되지 않은 경우
				mailService.increaseMailReadCount(mailNo); // 글 조회수 증가
				readList.add(mailNo); // 읽은 글 목록에 현개 글 번호 추가
			}

			MailDto mail = mailService.findMailMyByMailNo(mailNo);

//			if (mail == null) { // 조회되지 않은 경우 (글 번호가 잘못되었거나 또는 삭제된 글인 경우)
//				return "redirect:mail-list.action";
//			}

			// 3. View에서 읽을 수 있도록 데이터 전달
			model.addAttribute("mail", mail);
			model.addAttribute("pageNo", pageNo);

			// 4. View 또는 Controller로 이동
			return "mail/mail-my-detail";
		}
			
	// 6. 휴지통(메일삭제함)
	@GetMapping(path = { "/mail-deleted.action" })
	public String showMailDeleteList(@RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {

		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "mail-deleted.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		List<MailDto> mails = mailService.findMailDeleteByPage(loginuserid, pageNo, PAGE_SIZE);
		int mailCount = mailService.findMailDeleteCount(loginuserid);

		MailPager pager = new MailPager(mailCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (mailCount / PAGE_SIZE) + ((mailCount % PAGE_SIZE) > 0 ? 1 : 0);
		int pageBefore = 0;
		int pageNext = 0;

		if (pageNo == 1 && pageNo == pageCount) { // 페이지가 하나밖에 없을 경우.
			pageBefore = 1;
			pageNext = 1;
		} else if (pageNo == 1) { // 이전 페이지 활성화
			pageBefore = 1;
			pageNext = pageNo + 1;
		} else if (pageNo == pageCount) { // 다음 페이지 활성화
			pageBefore = pageNo - 1;
			pageNext = pageCount;
		} else { // 기본
			pageBefore = pageNo - 1;
			pageNext = pageNo + 1;
		};

		// 3. View에서 읽을 수 있도록 데이터 저장
		model.addAttribute("mails", mails);
		model.addAttribute("pager", pager);
		model.addAttribute("mailCount", mailCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);

		// 4. View or Controller로 이동
		return "mail/mail-deleted"; // /WEB-INF/views/ + mail/mail-list + .jsp
	}

	
/////// 휴지통(메일삭제) 상세보기
	@GetMapping(path = { "/mail-delete-detail.action" })
	public String showMailDeleteDetail(@RequestParam(defaultValue = "-1") int mailNo,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {
//		 1. 요청 데이터 읽기 ( 전달인자로 대체 )
//		if (mailNo == -1 || pageNo == -1) { // 요청 데이터가 잘못된 경우
//			return "redirect:mail-deleted.action";
//		}

		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		if (!readList.contains(mailNo)) { // 현재 글 번호가 읽은 글 목록에 포함되지 않은 경우
			mailService.increaseMailReadCount(mailNo); // 글 조회수 증가
			readList.add(mailNo); // 읽은 글 목록에 현개 글 번호 추가
		}

		MailDto maildelete = mailService.findMailDeletedByMailNo(mailNo);

//		if (mail == null) { // 조회되지 않은 경우 (글 번호가 잘못되었거나 또는 삭제된 글인 경우)
//			return "redirect:mail-deleted.action";
//		}

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("mail", maildelete);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "mail/mail-delete-detail";
	}

	/// 메일쓰기?
	@GetMapping(path = { "/mail-write.action" })
	public String showWriteMailsForm(Model model) {
		
		List<MemberDetailDto> EX = mailService.findAllEXMail();
		

		model.addAttribute("EX", EX);

		return "mail/mail-write";
	}

	@PostMapping(path = { "/mail-write.action" })
	public String writeMail(MailDto mail, MultipartHttpServletRequest req) {
		// 1. 요청 데이터 읽기 (전달인자로 대체)
		MultipartFile attach = req.getFile("attach");

		if (attach != null) { // 내용이 있는 경우
			// 2. 데이터 처리
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/mail-attachments");
			String fileName = attach.getOriginalFilename(); // 파일 이름 가져오기

			if (fileName != null && fileName.length() > 0) {
				String uniqueFileName = Util.makeUniqueFileName(fileName);

				try {
					attach.transferTo(new File(path, uniqueFileName));// 파일 저장

					// 첨부파일 정보를 객체에 저장
					ArrayList<MailAttachDto> attachments = new ArrayList<>(); // 첨부파일 정보를 저장하는 DTO 객체
					MailAttachDto attachment = new MailAttachDto();
					attachment.setUserFileName(fileName);
					attachment.setSavedFileName(uniqueFileName);
					attachments.add(attachment);
					mail.setAttachments(attachments);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		mailService.writeMail(mail);
		// 3. View에서 읽을 수 있도록 데이터 저장
		// 4. View 또는 Controller로 이동
		return "redirect:mail-list.action";
	}

	/// 메일임시저장함
	@GetMapping(path = { "/mail-draft.action" })
	public String draftMail(Model model) {

		List<MemberDetailDto> EX = mailService.findAllEXMail();

		model.addAttribute("EX", EX);
		
		
		
		// 3. View에서 읽을 수 있도록 데이터 저장
		
		return "/mail/mail-draft-list";
	}
	
	@PostMapping(path = { "/mail-draft.action" })
	public String draftMail(MailDto mail, MultipartHttpServletRequest req ) {
		// 1. 요청 데이터 읽기 (전달인자로 대체)
		MultipartFile attach = req.getFile("attach");

		if (attach != null) { // 내용이 있는 경우
			// 2. 데이터 처리
			ServletContext application = req.getServletContext();
			String path = application.getRealPath("/mail-attachments");
			String fileName = attach.getOriginalFilename(); // 파일 이름 가져오기

			if (fileName != null && fileName.length() > 0) {
				String uniqueFileName = Util.makeUniqueFileName(fileName);

				try {
					attach.transferTo(new File(path, uniqueFileName));// 파일 저장

					// 첨부파일 정보를 객체에 저장
					ArrayList<MailAttachDto> attachments = new ArrayList<>(); // 첨부파일 정보를 저장하는 DTO 객체
					MailAttachDto attachment = new MailAttachDto();
					attachment.setUserFileName(fileName);
					attachment.setSavedFileName(uniqueFileName);
					attachments.add(attachment);
					mail.setAttachments(attachments);

				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}

		mailService.draftMail(mail);
		

		// 4. View 또는 Controller로 이동
		return "redirect:mail-draft-list.action";
	}

	@GetMapping(path = { "/download.action" })
	public View download(@RequestParam(defaultValue = "-1") int attachNo, Model model) {

		if (attachNo == -1) {
			model.addAttribute("error_type", "download");
			model.addAttribute("message", "첨부파일 번호가 없습니다.");
		}

		MailAttachDto attachment = mailService.findMailAttachByAttachNo(attachNo);

		// View에게 전달할 데이터 저장
		model.addAttribute("attachment", attachment);

		MailDownloadView view = new MailDownloadView();

		return view;
	}
	
	/// 메일삭제
	@GetMapping(path = { "/{mailNo}/delete.action" })
	public String deleteMail(@PathVariable("mailNo") int mailNo, @RequestParam(defaultValue = "-1") int pageNo,
			Model model) {

		mailService.deleteMail(mailNo);

		return "redirect:/mail/mail-list.action?pageNo=" + pageNo;
	}
	
	/// 메일 인스턴스 삭제 
		@GetMapping(path = { "/{mailNo}/delete-instance.action" })
		public String deleteInstanceMail(@PathVariable("mailNo") int mailNo, @RequestParam(defaultValue = "-1") int pageNo,
				Model model) {

			mailService.deleteInstanceMail(mailNo);

			return "redirect:/mail/mail-deleted.action?pageNo=" + pageNo;
		}
	

	
	
//	@GetMapping(path = { "/mail-edit.action" })
//	public String showMailEditForm(@RequestParam(defaultValue = "-1") int mailNo,
//			@RequestParam(defaultValue = "-1") int pageNo, Model model) {
//
//
//		MailDto mail = mailService.findMailByMailNo(mailNo);
//
//		model.addAttribute("mail", mail);
//		model.addAttribute("mailNo", mailNo);
//		model.addAttribute("pageNo", pageNo);
//
//		return "mail/mail-edit"; // /WEB-INF/views/ + board/edit + .jsp
//
//	}
//
//	@PostMapping(path = { "/mail-edit.action" })
//	public String modifyMail(@RequestParam(defaultValue = "-1") int pageNo, MailDto mail, Model model) {
//
//		mailService.modifyMail(mail);
//
//		return "redirect:mail/mail-all-detail.action?mailNo=" + mail.getMailNo() + "&pageNo=" + pageNo;
//
//	}

	/////////////////////////////////////////////////////////////////////////////

}
