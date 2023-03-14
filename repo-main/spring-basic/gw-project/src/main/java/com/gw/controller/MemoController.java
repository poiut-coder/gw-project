package com.gw.controller;

import java.util.ArrayList;
import java.util.List;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.gw.dto.MemoDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.service.MemoService;
import com.gw.ui.MemoPager;

@Controller
@RequestMapping(path = { "/memo" })
public class MemoController {

	@Autowired
	@Qualifier("memoService")
	private MemoService memoService;

	
	// 1. 전체쪽지함 목록보기
	@GetMapping(path = { "/memo-all-list.action" })
	public String showMemoList(@RequestParam(defaultValue = "1") int pageNo, HttpSession session, String search, Model model) {

		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "memo-all-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		List<MemoDto> memos = memoService.findMemoByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
		int memoCount = memoService.findMemoCount(loginuserid);
		
		MemoPager pager = new MemoPager(memoCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (memoCount / PAGE_SIZE) + ((memoCount % PAGE_SIZE) > 0 ? 1 : 0);
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
		model.addAttribute("memos", memos);
		model.addAttribute("pager", pager);
		model.addAttribute("memoCount", memoCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);

		// 4. View or Controller로 이동
		return "memo/memo-all-list"; // /WEB-INF/views/ + memo/memo-all-list + .jsp
	}
	
	///////////////////////// 전체쪽지함 검색 
	@PostMapping(path= {"all-list-search.action"})
	public String searchAdminOrderByMemberId(@RequestParam(defaultValue = "") String search, HttpSession session, Model model) {

		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		if(search.length()==0) {

			return "redirect:memo-all-list.action";
		}
		List<MemoDto> search1 = memoService.findMemoBySearch(search, loginuserid);
		model.addAttribute("memos", search1);
		model.addAttribute("search", search);
		return "memo/memo-all-list";
	}

/////// 전체쪽지함 상세보기
	@GetMapping(path = { "/memo-all-detail.action" })
	public String showMemoDetail(@RequestParam(defaultValue = "-1") int m_id_no,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {
		
		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		MemoDto memo = memoService.findMemoBymem_id_no(m_id_no);

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("memo", memo);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "memo/memo-all-detail";
	}
	
	//////////////////////// 2. 받은쪽지함 목록보기
	@GetMapping(path = { "/memo-received-list.action" })
	public String showMemoReceivedList(@RequestParam(defaultValue = "1") int pageNo, Model model, HttpSession session) {
		
		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "memo-received-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		
		List<MemoDto> memos = memoService.findMemoReceivedByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
		int memoCount = memoService.findMemoReceivedCount(loginuserid);
		
		MemoPager pager = new MemoPager(memoCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (memoCount / PAGE_SIZE) + ((memoCount % PAGE_SIZE) > 0 ? 1 : 0);
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
		model.addAttribute("memos", memos);
		model.addAttribute("pager", pager);
		model.addAttribute("memoCount", memoCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);

		// 4. View or Controller로 이동
		return "memo/memo-received-list"; // /WEB-INF/views/ + memo/memo-all-list + .jsp
	}

/////// 받은쪽지함 상세보기
	@GetMapping(path = { "/memo-received-detail.action" })
	public String showMemoReceivedDetail(@RequestParam(defaultValue = "-1") int m_id_no,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {

		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		MemoDto memo = memoService.findMemoReceivedBymem_id_no(m_id_no);

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("memo", memo);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "memo/memo-received-detail";
	}

	////////////////////////  3. 보낸쪽지함 목록보기
	@GetMapping(path = { "/memo-send-list.action" })
	public String showMemoSendList(@RequestParam(defaultValue = "1") int pageNo, Model model, HttpSession session) {
		
		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "memo-send-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		
		List<MemoDto> memos = memoService.findMemoSendByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
		int memoCount = memoService.findMemoSendCount(loginuserid);
		
		MemoPager pager = new MemoPager(memoCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (memoCount / PAGE_SIZE) + ((memoCount % PAGE_SIZE) > 0 ? 1 : 0);
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
		model.addAttribute("memos", memos);
		model.addAttribute("pager", pager);
		model.addAttribute("memoCount", memoCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);

		// 4. View or Controller로 이동
		return "memo/memo-send-list"; // /WEB-INF/views/ + memo/memo-all-list + .jsp
	}

/////// 보낸쪽지함 상세보기
	@GetMapping(path = { "/memo-send-detail.action" })
	public String showMemoSendDetail(@RequestParam(defaultValue = "-1") int m_id_no,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {

		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		MemoDto memo = memoService.findMemoSendBymem_id_no(m_id_no);

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("memo", memo);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "memo/memo-send-detail";
	}

	// 5. 내가쓴쪽지함 목록보기
		@GetMapping(path = { "/memo-my-list.action" })
		public String showMemoMyList(@RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {

			// 페이지
			int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
			int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
			String LINK_URL = "memo-my-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
			// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
			// 2. 데이터 처리 ( 데이터 조회 )
			MemberDto member = (MemberDto)session.getAttribute("loginuser");
			int loginuserid = member.getMem_id_no();
			List<MemoDto> memos = memoService.findMemoMyByPage(loginuserid, pageNo, PAGE_SIZE);// 글번호를 받아서 읽음 처리 ( update )
			int memoCount = memoService.findMemoMyCount(loginuserid);

			MemoPager pager = new MemoPager(memoCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
			int pageCount = (memoCount / PAGE_SIZE) + ((memoCount % PAGE_SIZE) > 0 ? 1 : 0);
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
			model.addAttribute("memos", memos);
			model.addAttribute("pager", pager);
			model.addAttribute("memoCount", memoCount);
			model.addAttribute("pageNo", pageNo);
			model.addAttribute("PAGE_SIZE", PAGE_SIZE);
			model.addAttribute("PAGER_SIZE", PAGER_SIZE);
			model.addAttribute("LINK_URL", LINK_URL);
			model.addAttribute("pageCount", pageCount);
			model.addAttribute("pageBefore", pageBefore);
			model.addAttribute("pageNext", pageNext);

			// 4. View or Controller로 이동
			return "memo/memo-my-list"; // /WEB-INF/views/ + memo/memo-all-list + .jsp
		}

	/////// 내가쓴쪽지함 상세보기
		@GetMapping(path = { "/memo-my-detail.action" })
		public String showMemoMyDetail(@RequestParam(defaultValue = "-1") int m_id_no,
				@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {
//			 1. 요청 데이터 읽기 ( 전달인자로 대체 )

			// 2. 데이터 처리
			ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
			if (readList == null) { // 세션에 목록이 없으면
				readList = new ArrayList<>(); // 목록 새로 만들기
				session.setAttribute("read-list", readList); // 세션에 목록 등록
			}

			MemoDto memo = memoService.findMemoMyBymem_id_no(m_id_no);

			// 3. View에서 읽을 수 있도록 데이터 전달
			model.addAttribute("memo", memo);
			model.addAttribute("pageNo", pageNo);

			// 4. View 또는 Controller로 이동
			return "memo/memo-my-detail";
		}
			
	// 6. 휴지통(쪽지삭제함)
	@GetMapping(path = { "/memo-deleted-list.action" })
	public String showMemoDeleteList(@RequestParam(defaultValue = "1") int pageNo, HttpSession session, Model model) {

		// 페이지
		int PAGE_SIZE = 3; // 한 페이지에 표시되는 데이터 개수
		int PAGER_SIZE = 5; // 한 번에 표시할 페이지 번호 개수
		String LINK_URL = "memo-deleted-list.action"; // 페이지 번호를 클릭했을 때 이동할 페이지 경로
		// 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리 ( 데이터 조회 )
		MemberDto member = (MemberDto)session.getAttribute("loginuser");
		int loginuserid = member.getMem_id_no();
		List<MemoDto> memos = memoService.findMemoDeleteByPage(loginuserid, pageNo, PAGE_SIZE);
		int memoCount = memoService.findMemoDeleteCount(loginuserid);

		MemoPager pager = new MemoPager(memoCount, pageNo, PAGE_SIZE, PAGER_SIZE, LINK_URL);
		int pageCount = (memoCount / PAGE_SIZE) + ((memoCount % PAGE_SIZE) > 0 ? 1 : 0);
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
		model.addAttribute("memos", memos);
		model.addAttribute("pager", pager);
		model.addAttribute("memoCount", memoCount);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("PAGE_SIZE", PAGE_SIZE);
		model.addAttribute("PAGER_SIZE", PAGER_SIZE);
		model.addAttribute("LINK_URL", LINK_URL);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("pageBefore", pageBefore);
		model.addAttribute("pageNext", pageNext);

		// 4. View or Controller로 이동
		return "memo/memo-deleted-list"; // /WEB-INF/views/ + memo/memo-all-list + .jsp
	}

	
/////// 휴지통(쪽지삭제) 상세보기
	@GetMapping(path = { "/memo-deleted-detail.action" })
	public String showMemoDeleteDetail(@RequestParam(defaultValue = "-1") int m_id_no,
			@RequestParam(defaultValue = "-1") int pageNo, HttpSession session, Model model) {
//		 1. 요청 데이터 읽기 ( 전달인자로 대체 )
		// 2. 데이터 처리
		ArrayList<Integer> readList = (ArrayList<Integer>) session.getAttribute("read-list");
		if (readList == null) { // 세션에 목록이 없으면
			readList = new ArrayList<>(); // 목록 새로 만들기
			session.setAttribute("read-list", readList); // 세션에 목록 등록
		}

		MemoDto memodelete = memoService.findMemoDeletedBymem_id_no(m_id_no);

		// 3. View에서 읽을 수 있도록 데이터 전달
		model.addAttribute("memo", memodelete);
		model.addAttribute("pageNo", pageNo);

		// 4. View 또는 Controller로 이동
		return "memo/memo-deleted-detail";
	}

	/// 쪽지쓰기?
	@GetMapping(path = { "/memo-write.action" })
	public String showWriteMemosForm(Model model) {
		
		List<MemberDetailDto> EX = memoService.findAllEXMemo();

		model.addAttribute("EX", EX);

		return "memo/memo-write";
	}

	@PostMapping(path = { "/memo-write.action" })
	public String writeMemo(MemoDto memo, MultipartHttpServletRequest req) {
		// 1. 요청 데이터 읽기 (전달인자로 대체)

		memoService.writeMemo(memo);
		// 3. View에서 읽을 수 있도록 데이터 저장
		// 4. View 또는 Controller로 이동
		return "redirect:memo-all-list.action";
	}

	/// 쪽지삭제
	@GetMapping(path = { "/{m_id_no}/delete.action" })
	public String deleteMemo(@PathVariable("m_id_no") int m_id_no, @RequestParam(defaultValue = "-1") int pageNo,
			Model model) {

		memoService.deleteMemo(m_id_no);

		return "redirect:/memo/memo-all-list.action?pageNo=" + pageNo;
	}
	
	/// 쪽지 인스턴스 삭제 
		@GetMapping(path = { "/{m_id_no}/delete-instance.action" })
		public String deleteInstanceMemo(@PathVariable("m_id_no") int m_id_no, @RequestParam(defaultValue = "-1") int pageNo,
				Model model) {

			memoService.deleteInstanceMemo(m_id_no);

			return "redirect:/memo/memo-deleted.action?pageNo=" + pageNo;
		}
	
}
