package com.gw.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.gw.dto.ApDocDto;
import com.gw.dto.ApDto;
import com.gw.dto.ApMemberDto;
import com.gw.dto.ApSheetDto;
import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.RoleDto;

@Mapper
public interface ApprovalMapper {
	
	//결재 문서 작성
	@Insert("INSERT INTO approval_doc (doc_sender, doc_title, doc_content) " +
			"VALUES (#{doc_sender}, #{doc_title}, #{doc_content})")
	void insertDoc(ApDocDto doc);
	
	//결재 문서 가져오기	  
	@Select("SELECT * FROM approval_doc Where doc_sender = #{ userNo } AND doc_deleted = 0 ORDER BY doc_id_no desc")
	List<ApDocDto> selectDocsByUserNo(int userNo);
	
	@Select("SELECT * FROM approval_doc Where doc_sender = #{ userNo } AND doc_deleted = 0 ORDER BY doc_id_no desc " +
			"limit #{ from }, #{ count }")
	List<ApDocDto> selectDocsByUserNoAndPageNo(@Param("userNo") int userNo, @Param("from") int from, @Param("count") int count);
	
	@Select("SELECT count(*) FROM approval_doc Where doc_sender = #{ userNo } AND doc_deleted = 0 ORDER BY doc_id_no desc")
	int countDocsByUserNo (int userNo);
	
	@Select("SELECT * FROM approval_doc Where doc_id_no = #{ doc_id_no } AND doc_deleted = 0")
	ApDocDto selectDocByDocNo(int doc_id_no);
	 
	//결재 문서 즐겨찾기 수정
	@Update("UPDATE approval_doc SET doc_star = if(doc_star=1, 0, 1) WHERE doc_id_no = #{ doc_id_no }")
	void updateStar(int doc_id_no);
	
	//결재 문서 즐겨찾기 불러오기
	@Select("SELECT * FROM approval_doc Where doc_sender = #{ userNo } AND doc_deleted = 0 AND doc_star = 1 ORDER BY doc_id_no desc " + 
			"limit #{ from }, #{ count }")
	List<ApDocDto> selectDocsByStar(@Param("userNo") int userNo, @Param("from") int from, @Param("count") int count);
	
	@Select("SELECT count(*) FROM approval_doc Where doc_sender = #{ userNo } AND doc_deleted = 0 AND doc_star = 1 ORDER BY doc_id_no desc")
	int countDocsByStar (int userNo);
	
	//결재 문서 삭제
	@Update("UPDATE approval_doc SET doc_deleted = 1 WHERE doc_id_no = #{ doc_id_no }")
	void deleteDoc(int doc_id_no);
	
	//결재 문서 메모 작성 및 수정
	@Update("UPDATE approval_doc SET doc_memo = #{doc_memo} WHERE doc_id_no = #{ doc_id_no }")
	void insertDocMemo(ApDocDto doc);
	
	//결재 문서 메모 삭제
	@Update("UPDATE approval_doc SET doc_memo = null WHERE doc_id_no = #{ doc_id_no }")
	void deleteDocMemo(int doc_id_no);

	//결재 문서 수정
	@Update("UPDATE approval_doc SET doc_title = #{doc_title}, doc_content = #{doc_content} WHERE doc_id_no = #{ doc_id_no }")
	void updateDoc(ApDocDto doc);

	//결재 양식 가져오기
	@Select("SELECT * FROM approval_sheet_type WHERE sheet_deleted = 0 AND (sheet_all = 1 OR mem_id_no = #{userNo})")
	List<ApSheetDto> selectSheets(int userNo);
	
	@Select("SELECT * FROM approval_sheet_type WHERE sheet_id_no = #{sheet_id_no}")
	ApSheetDto selectSheetBySheetNo(int sheet_id_no);
	
	//결재 문서 양식 추가
	@Insert("INSERT INTO approval_sheet_type (sheet_name, sheet_content, mem_id_no) " +
			"VALUES (#{sheet_name}, #{sheet_content}, #{mem_id_no})")
	void insertSheet(ApSheetDto sheet);
	
	//결재 문서 양식 삭제
	@Update("UPDATE approval_sheet_type SET sheet_deleted = 1 WHERE sheet_id_no = #{ sheet_id_no }")
	void deleteSheet(int sheet_id_no);
	
	//부서 불러오기
	@Select("SELECT * FROM dept WHERE comp_dept_id_no = #{ comNo } ORDER BY dept_name")
	List<DeptDto> selectDepts(int comNo);
	
	//직급 불러오기
	@Select("SELECT * FROM role")
	List<RoleDto> selectRoles();
	
	//부서별 멤버 가져오기
	@Select("SELECT * FROM member WHERE mem_dept_no = #{ deptNo } and mem_com_code = #{ comNo } ORDER BY mem_position_no")
	List<MemberDto> selectMembersByDept(@Param("deptNo")int deptNo, @Param("comNo")int comNo);
	
	//멤버 디테일 가져오기
	@Select("SELECT * FROM member_detail")
	List<MemberDetailDto> selectMembersDetail();
	
	//ApMemberDto 가져오기
	@Select("SELECT mem_id_no, mem_detail_name, dept_name, role_name FROM member LEFT JOIN member_detail ON mem_id_no = mem_detail_id_no " +
			"LEFT JOIN dept ON mem_dept_no = dept_id_no LEFT JOIN role ON mem_position_no = role_id_no WHERE mem_com_code = #{ comNo }")
	List<ApMemberDto> selectApMembers(int comNo);
	
	//결재 경로 추가
	@Insert("INSERT INTO approval (appr_sender, appr_receiver) " +
			"VALUES (#{sender}, #{receiver})")
	void insertApprovalRoute(@Param("sender") int sender,@Param("receiver") int receiver);
	
	@Select("SELECT * FROM approval ORDER BY appr_id_no DESC LIMIT 1")
	ApDto selectRecentApproval();
	
	@Update("UPDATE approval SET appr_preturn = #{ preTurn } WHERE appr_id_no = #{ apprNo }")
	void updatePreTurn(@Param("preTurn") int preTurn, @Param("apprNo") int apprNo);
	
	//결재 경로수 조회
	@Select("SELECT count(appr_id_no) FROM approval WHERE appr_sender = #{ userNo } AND appr_valid = 0")
	int countApprovalRoutesByUserNo(int userNo);
	
	//결재 경로 조회
	@Select("SELECT * FROM approval WHERE appr_sender = #{ userNo } AND appr_valid = 0 ORDER BY appr_preturn")
	List<ApDto> selectApprovalRoutesByUserNo(int userNo);

	//결재 경로 삭제
	@Update("UPDATE approval SET appr_valid = 3 WHERE appr_id_no = #{ apprNo }")
	void deleteRoute(int apprNo);

	//전자결재 기안
	@Update("UPDATE approval SET appr_turn = #{ turn }, appr_doc_no = #{ docNo }, appr_group = #{ group }, appr_status = 0, appr_regdate = CURRENT_TIMESTAMP, appr_memo = #{ memo } WHERE appr_id_no = #{ apprNo }")
	void updateApproval(@Param("turn") int turn, @Param("docNo") int docNo, @Param("group") int group, @Param("memo") String memo, @Param("apprNo") int apprNo);
	
	//전자결재 기안 순번1 유효성1
	@Update("UPDATE approval SET appr_valid = 1 WHERE appr_id_no = #{ apprNo }")
	void updateApprovalvalid1(int apprNo);
	
	//전자결재 기안 유효성2
	@Update("UPDATE approval SET appr_valid = 2 WHERE appr_id_no = #{ apprNo }")
	void updateApprovalvalid2(int apprNo);
	
	//기안함 가져오기
	@Select("SELECT * FROM approval WHERE appr_sender = #{ userNo } AND (appr_valid = 1 OR appr_valid = 2) ORDER BY appr_group DESC, appr_turn DESC")
	List<ApDto> selectSendApprovalByUserNo(int userNo);
	
	@Select("SELECT * FROM approval WHERE appr_sender = #{ userNo } AND (appr_valid = 1 OR appr_valid = 2) ORDER BY appr_group DESC, appr_turn DESC " +
			"LIMIT #{ from }, #{ count }")
	List<ApDto> selectSendApprovalByUserNoAndPageNo(@Param("userNo") int userNo, @Param("from") int from, @Param("count") int count);
	
	@Select("SELECT count(*) FROM approval WHERE appr_sender = #{ userNo } AND (appr_valid = 1 OR appr_valid = 2)")
	int countSendApprovalByUserNo (int userNo);
	
	//결재 정보 가져오기
	@Select("SELECT * FROM approval Where appr_id_no = #{ appr_id_no }")
	ApDto selectApprovalByApprovalNo(int appr_id_no);
	
	//결재자 가져오기
	@Select("SELECT * FROM approval WHERE appr_group = #{ appr_group } ORDER BY appr_turn")
	List<ApDto> selectApprovalReceiverByGroup(int appr_group);
	
	//결재함 가져오기
	@Select("SELECT * FROM approval WHERE appr_receiver = #{ userNo } AND appr_valid = 1 ORDER BY appr_id_no DESC")
	List<ApDto> selectReceiveApprovalByUserNo(int userNo);
	
	@Select("SELECT * FROM approval WHERE appr_receiver = #{ userNo } AND appr_valid = 1 ORDER BY appr_id_no DESC " +
			"LIMIT #{ from }, #{ count }")
	List<ApDto> selectReceiveApprovalByUserNoAndPageNo(@Param("userNo") int userNo, @Param("from") int from, @Param("count") int count);
	
	@Select("SELECT count(*) FROM approval WHERE appr_receiver = #{ userNo } AND appr_valid = 1")
	int countReceiveApprovalByUserNo (int userNo);
	
	//결재 승인
	@Update("UPDATE approval SET appr_status = 1 WHERE appr_id_no = #{ apprNo }")
	void updateApprovalStatusAdmit(int apprNo);
	
	//결재 반려
	@Update("UPDATE approval SET appr_status = 2, appr_reject_memo = #{ memo } WHERE appr_id_no = #{ apprNo }")
	void updateApprovalStatusReject(@Param("memo") String memo, @Param("apprNo") int apprNo);
	
	//결재 중단
	@Update("UPDATE approval SET appr_status = 3 WHERE appr_group = #{ group } AND appr_status LIKE 0")
	void updateApprovalStatusNone(int group);
	
	//결재 승인 유효성
	@Update("UPDATE approval SET appr_valid = 1 WHERE appr_group = #{ group } AND appr_turn = #{ turn }")
	void updateApprovalValidAdmit(@Param("group") int group, @Param("turn") int turn);
	
	//결재함 알림 개수
	@Select("SELECT count(*) FROM approval WHERE appr_receiver = #{ userNo } AND appr_valid = 1 AND receive_alert = 1")
	int countReceiveApprovalAlertByUserNo (int userNo);
	
	//기안함 알림 개수
	@Select("SELECT count(*) FROM approval WHERE appr_sender = #{ userNo } AND (appr_valid = 1 OR appr_valid = 2) AND send_alert = 1")
	int countSendApprovalAlertByUserNo (int userNo);
	
	//결재 알림 확인
	@Update("UPDATE approval SET receive_alert = 0 WHERE appr_receiver = #{ userNo } AND appr_valid = 1")
	void updateReceiveApprovalAlert(int userNo);
	
	//기안 알림 확인
	@Update("UPDATE approval SET send_alert = 0 WHERE appr_sender = #{ userNo }")
	void updateSendApprovalAlert(int userNo);
	
	//기안 알림 변경
	@Update("UPDATE approval SET send_alert = 1 WHERE appr_id_no = #{ apprNo }")
	void updateSendApprovalAlert1(int apprNo);
	
	@Update("UPDATE approval SET send_alert = 1 WHERE appr_group = #{ group } AND appr_status LIKE 3")
	void updateSendApprovalAlertByGroup(int group);
	
}


	