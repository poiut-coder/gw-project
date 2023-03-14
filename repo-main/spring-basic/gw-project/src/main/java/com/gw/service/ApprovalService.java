package com.gw.service;

import java.util.List;

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

public interface ApprovalService {
	
	// 결재 문서 작성
	void writeDoc(ApDocDto doc);
	
	// 결재 문서 가져오기
	List<ApDocDto> findDocs(int userNo);
	
	List<ApDocDto> findDocsByPage(int userNo, int pageNo, int pageSize);
	
	int countDocs(int userNo);
	
	ApDocDto findDoc(int doc_id_no);
	
	//결재 문서 즐겨찾기 수정
	void modifyStar(int doc_id_no);
	
	// 결재 문서 즐겨찾기 가져오기
	List<ApDocDto> findDocsByStar(int userNo, int pageNo, int pageSize);
	
	int countDocsByStar(int userNo);
	
	//결재 문서 삭제
	void deleteDoc(int doc_id_no);
	
	// 결재 문서 메모 작성 및 수정
	void writeDocMemo(ApDocDto doc);
	
	// 결재 문서 메모 삭제
	void deleteDocMemo(int doc_id_no);

	// 결재 문서 수정
	void modifyDoc(ApDocDto doc);

	// 결재 양식 가져오기
	List<ApSheetDto> findSheets(int userNo);
	
	ApSheetDto findSheet(int sheet_id_no);
	
	// 결재 문서 양식 추가
	void addSheet(ApSheetDto sheet);

	// 결재 문서 양식 삭제
	void deleteSheet(int sheetNo);
	
	// 부서 가져오기
	List<DeptDto> findDepts(int comNo);
	
	// 직급 가져오기
	List<RoleDto> findRoles();
	
	//부서별 멤버 가져오기
	List<MemberDto> findMembersByDept(int deptNo, int comNo);
	
	//멤버 디테일 가져오기
	List<MemberDetailDto> findMembersDetail();
	
	//ApMemberDto 가져오기
	List<ApMemberDto> findApMembers(int comNo);
	
	//결재 경로 추가
	void addRoute (int sender, int receiver);
	
	//결재 경로수 조회
	int countRoutes(int userNo);
	
	//결재 경로 조회
	List<ApDto> findRoutes(int userNo);

	//결재 경로 삭제
	void delRoute(int apprNo);
	
	//전자결재 기안
	void getApproval(int turn, int docNo, int group, String memo, int apprNo);
	
	//전자결재 유효성1
	void getApprovalValid1(int apprNo);
	
	//전자결재 유효성2
	void getApprovalValid2(int apprNo);
	
	//기안함 가져오기
	List<ApDto> findSendApproval(int userNo);
	
	List<ApDto> findSendApprovalByPage(int userNo, int pageNo, int pageSize);
	
	int countSendApproval(int userNo);
	
	//결재정보 가져오기
	ApDto findApproval(int apprNo);
	
	//결재자 가져오기
	List<ApDto> findApprovalReceiver(int group);
	
	//결재함 가져오기
	List<ApDto> findReceiveApproval(int userNo);
	
	List<ApDto> findReceiveApprovalByPage(int userNo, int pageNo, int pageSize);
	
	int countReceiveApproval(int userNo);
	
	//결재 승인
	void admitApproval(int apprNo);
	
	//결재 반려
	void rejectApproval(String memo, int apprNo);
	
	//결재 중단
	void noneApproval(int group);
	
	//결재 승인 유효성
	void approvalValidAdmit(@Param("group") int group, @Param("turn") int turn);
	
	//결재함 알림 개수
	int countReceiveAlert (int userNo);
	
	//기안함 알림 개수
	int countSendAlert (int userNo);
	
	//결재 알림 확인
	void checkReceiveAlert(int userNo);
	
	//기안 알림 확인
	void checkSendAlert(int userNo);
	
	//기안 알림 변경
	void SendAlert(int apprNo);
	
	//기안 알림 변경
	void SendAlertNone(int group);
	
	//결재 경로 순번 변경
	void modifyRoute(int preTurn, int apprNo);
}
