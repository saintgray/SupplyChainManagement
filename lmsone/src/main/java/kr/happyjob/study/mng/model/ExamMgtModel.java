package kr.happyjob.study.mng.model;

public class ExamMgtModel {

	// 강의 목록
	private String classNm;
	private String classStartdate;
	private String classEnddate;
	private int classNo;
	
	// 시험 목록
	private int exClassNo;
	private int qNo;
	private String qType;
	private String qContent;
	private String qOne;
	private String qTwo;
	private String qThree;
	private String qFour;
	private int qSolution;
	
	private int examCnt;
	private int examMaxqNo;
	
	public String getClassNm() {
		return classNm;
	}
	public void setClassNm(String classNm) {
		this.classNm = classNm;
	}
	public String getClassStartdate() {
		return classStartdate;
	}
	public void setClassStartdate(String classStartdate) {
		this.classStartdate = classStartdate;
	}
	public String getClassEnddate() {
		return classEnddate;
	}
	public void setClassEnddate(String classEnddate) {
		this.classEnddate = classEnddate;
	}
	public int getClassNo() {
		return classNo;
	}
	public void setClassNo(int classNo) {
		this.classNo = classNo;
	}
	public int getExClassNo() {
		return exClassNo;
	}
	public void setExClassNo(int exClassNo) {
		this.exClassNo = exClassNo;
	}
	public int getqNo() {
		return qNo;
	}
	public void setqNo(int qNo) {
		this.qNo = qNo;
	}
	public String getqType() {
		return qType;
	}
	public void setqType(String qType) {
		this.qType = qType;
	}
	public String getqContent() {
		return qContent;
	}
	public void setqContent(String qContent) {
		this.qContent = qContent;
	}
	public String getqOne() {
		return qOne;
	}
	public void setqOne(String qOne) {
		this.qOne = qOne;
	}
	public String getqTwo() {
		return qTwo;
	}
	public void setqTwo(String qTwo) {
		this.qTwo = qTwo;
	}
	public String getqThree() {
		return qThree;
	}
	public void setqThree(String qThree) {
		this.qThree = qThree;
	}
	public String getqFour() {
		return qFour;
	}
	public void setqFour(String qFour) {
		this.qFour = qFour;
	}
	public int getqSolution() {
		return qSolution;
	}
	public void setqSolution(int qSolution) {
		this.qSolution = qSolution;
	}
	
}
