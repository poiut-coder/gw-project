package com.gw.service;

import java.util.List;

import com.gw.dto.ApDocDto;
import com.gw.dto.ApDto;
import com.gw.dto.ApMemberDto;
import com.gw.dto.ApSheetDto;
import com.gw.dto.DeptDto;
import com.gw.dto.MemberDetailDto;
import com.gw.dto.MemberDto;
import com.gw.dto.RoleDto;
import com.gw.mapper.ApprovalMapper;

import lombok.Setter;

public class ApprovalServiceImpl implements ApprovalService {

	@Setter
	private ApprovalMapper approvalMapper;
	
	// 결재 문서 작성
	@Override
	public void writeDoc(ApDocDto doc) {
		approvalMapper.insertDoc(doc);
	}
	
	// 결재 문서 가져오기
	@Override
	public List<ApDocDto> findDocs(int userNo) {
		List<ApDocDto> docs = approvalMapper.selectDocsByUserNo(userNo);
		return docs;
	}
	
	@Override
	public List<ApDocDto> findDocsByPage(int userNo, int pageNo, int pageSize) {
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		
		List<ApDocDto> docs = approvalMapper.selectDocsByUserNoAndPageNo(userNo, from, count);
		return docs;
	}
	
	@Override
	public int countDocs(int userNo) {
		return approvalMapper.countDocsByUserNo(userNo);
	}
	
	@Override
	public ApDocDto findDoc(int doc_id_no) {
		ApDocDto doc = approvalMapper.selectDocByDocNo(doc_id_no);
		return doc;
	}
	
	// 결재 문서 즐겨찾기 수정
	@Override
	public void modifyStar(int doc_id_no) {
		approvalMapper.updateStar(doc_id_no);
	}

	// 결재 문서 즐겨찾기 가져오기
	@Override
	public List<ApDocDto> findDocsByStar(int userNo, int pageNo, int pageSize) {
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		
		List<ApDocDto> docs = approvalMapper.selectDocsByStar(userNo, from, count);
		return docs;
		}
	
	@Override
	public int countDocsByStar(int userNo) {
		return approvalMapper.countDocsByStar(userNo);
		
	}
	
	//결재 문서 삭제
	@Override
	public void deleteDoc(int doc_id_no) {
		approvalMapper.deleteDoc(doc_id_no);
	}

	//결재 문서 메모 작성 및 수정
	@Override
	public void writeDocMemo(ApDocDto doc) {
		approvalMapper.insertDocMemo(doc);
	}

	//결재 문서 메모 삭제
	@Override
	public void deleteDocMemo(int doc_id_no) {
		approvalMapper.deleteDocMemo(doc_id_no);
	}

	//결재 문서 수정
	@Override
	public void modifyDoc(ApDocDto doc) {
		approvalMapper.updateDoc(doc);
	}
	
	// 결재 양식 가져오기
	@Override
	public List<ApSheetDto> findSheets(int userNo) {
		List<ApSheetDto> sheets = approvalMapper.selectSheets(userNo);
		return sheets;
	}
	
	@Override
	public ApSheetDto findSheet(int sheet_id_no) {
		
		ApSheetDto sheet = approvalMapper.selectSheetBySheetNo(sheet_id_no);
		return sheet;
		
	}
	
	// 결재 양식 추가
	@Override
	public void addSheet(ApSheetDto sheet) {
		approvalMapper.insertSheet(sheet);
	}

	// 결재 양식 삭제
	@Override
	public void deleteSheet(int sheetNo) {
		approvalMapper.deleteSheet(sheetNo);
	}

	// 부서 가져오기
	@Override
	public List<DeptDto> findDepts(int comNo) {
		List<DeptDto> depts = approvalMapper.selectDepts(comNo);
		return depts;
	}
	
	// 직급 가져오기
	@Override
	public List<RoleDto> findRoles() {
		List<RoleDto> roles = approvalMapper.selectRoles();
		return roles;
	}

	// 부서별 멤버 가져오기
	@Override
	public List<MemberDto> findMembersByDept(int deptNo, int comNo) {
		List<MemberDto> members = approvalMapper.selectMembersByDept(deptNo, comNo);
		return members;
	}

	// 멤버 디테일 가져오기
	@Override
	public List<MemberDetailDto> findMembersDetail() {
		List<MemberDetailDto> membersDetail = approvalMapper.selectMembersDetail();
		return membersDetail;
	}
	
	//결재 경로 추가
	@Override
	public void addRoute(int sender, int receiver) {
		approvalMapper.insertApprovalRoute(sender, receiver);
		ApDto ap = approvalMapper.selectRecentApproval();
		int preTurn = ap.getAppr_id_no();
		int apprNo = ap.getAppr_id_no();
		approvalMapper.updatePreTurn(preTurn, apprNo);
	}

	//결재 경로수 조회
	@Override
	public int countRoutes(int userNo) {
		int routes = approvalMapper.countApprovalRoutesByUserNo(userNo);
		return routes;
	}

	//결재 경로 조회
	@Override
	public List<ApDto> findRoutes(int userNo) {
		List<ApDto> routes = approvalMapper.selectApprovalRoutesByUserNo(userNo);
		return routes;
	}

	//ApMember 조회
	@Override
	public List<ApMemberDto> findApMembers(int comNo) {
		List<ApMemberDto> apMembers = approvalMapper.selectApMembers(comNo);
		return apMembers;
	}

	// 결재 경로 삭제
	@Override
	public void delRoute(int apprNo) {
		approvalMapper.deleteRoute(apprNo);
	}

	// 전자결재 기안
	@Override
	public void getApproval(int turn, int docNo, int group, String memo, int apprNo) {
		
		approvalMapper.updateApproval(turn, docNo, group, memo, apprNo);
	}

	// 전자결재 기안 유효성1
	@Override
	public void getApprovalValid1(int apprNo) {
		
		approvalMapper.updateApprovalvalid1(apprNo);
	}

	// 전자결재 기안 유효성2
	@Override
	public void getApprovalValid2(int apprNo) {
		
		approvalMapper.updateApprovalvalid2(apprNo);
	}

	// 기안함 가져오기
	@Override
	public List<ApDto> findSendApproval(int userNo) {
		List<ApDto> aps = approvalMapper.selectSendApprovalByUserNo(userNo);
		return aps;
	}

	@Override
	public List<ApDto> findSendApprovalByPage(int userNo, int pageNo, int pageSize) {
		
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		
		List<ApDto> aps = approvalMapper.selectSendApprovalByUserNoAndPageNo(userNo, from, count);
		return aps;
	}

	@Override
	public int countSendApproval(int userNo) {
		
		int count = approvalMapper.countSendApprovalByUserNo(userNo);
		return count;
	}

	// 결재정보 가져오기
	@Override
	public ApDto findApproval(int apprNo) {
		ApDto ap = approvalMapper.selectApprovalByApprovalNo(apprNo);
		return ap;
	}

	// 결재자 가져오기
	@Override
	public List<ApDto> findApprovalReceiver(int group) {
		List<ApDto> aps = approvalMapper.selectApprovalReceiverByGroup(group);
		return aps;
	}

	// 결재함 가져오기
	@Override
	public List<ApDto> findReceiveApproval(int userNo) {
		List<ApDto> aps = approvalMapper.selectReceiveApprovalByUserNo(userNo);
		return aps;
	}

	@Override
	public List<ApDto> findReceiveApprovalByPage(int userNo, int pageNo, int pageSize) {
		
		int from = (pageNo - 1) * pageSize;
		int count = pageSize;
		
		List<ApDto> aps = approvalMapper.selectReceiveApprovalByUserNoAndPageNo(userNo, from, count);
		return aps;
	}

	@Override
	public int countReceiveApproval(int userNo) {
		int count = approvalMapper.countReceiveApprovalByUserNo(userNo);
		return count;
	}

	// 결재 승인
	@Override
	public void admitApproval(int apprNo) {
		approvalMapper.updateApprovalStatusAdmit(apprNo);
		
	}

	// 결재 반려
	@Override
	public void rejectApproval(String memo, int apprNo) {
		approvalMapper.updateApprovalStatusReject(memo, apprNo);
		
	}
	
	// 결재 중단
	@Override
	public void noneApproval(int group) {
		approvalMapper.updateApprovalStatusNone(group);
		
	}
	
	// 결재 승인 유효성
	@Override
	public void approvalValidAdmit(int group, int turn) {
		approvalMapper.updateApprovalValidAdmit(group, turn);
		
	}

	//결재함 알림 개수
	@Override
	public int countReceiveAlert(int userNo) {
		return approvalMapper.countReceiveApprovalAlertByUserNo(userNo);
	}

	//기안함 알림 개수
	@Override
	public int countSendAlert(int userNo) {
		return approvalMapper.countSendApprovalAlertByUserNo(userNo);
	}

	//결재함 알림 확인
	@Override
	public void checkReceiveAlert(int userNo) {
		approvalMapper.updateReceiveApprovalAlert(userNo);
		
	}

	//기안함 알림 확인
	@Override
	public void checkSendAlert(int userNo) {
		approvalMapper.updateSendApprovalAlert(userNo);
		
	}

	//기안 알림 변경
	@Override
	public void SendAlert(int apprNo) {
		approvalMapper.updateSendApprovalAlert1(apprNo);
		
	}

	@Override
	public void SendAlertNone(int group) {
		approvalMapper.updateSendApprovalAlertByGroup(group);
	}

	@Override
	public void modifyRoute(int preTurn, int apprNo) {
		approvalMapper.updatePreTurn(preTurn, apprNo);
	}

	
}
