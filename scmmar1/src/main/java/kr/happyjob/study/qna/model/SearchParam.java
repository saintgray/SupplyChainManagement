package kr.happyjob.study.qna.model;

public class SearchParam {
	
	private String selectPage;
	private String rowsPerPage;
	private String totalCount;
	private String searchType;
	private String keyword;
	
	private String loginID;
	private String userType;
	
	public SearchParam() {

	}

	
	
	


	public SearchParam(String selectPage, String rowsPerPage, String totalCount, String searchType, String keyword,
			String loginID, String userType) {
		
		this.selectPage = selectPage;
		this.rowsPerPage = rowsPerPage;
		this.totalCount = totalCount;
		this.searchType = searchType;
		this.keyword = keyword;
		this.loginID = loginID;
		this.userType = userType;
	}






	public String getSelectPage() {
		return selectPage;
	}

	public void setSelectPage(String selectPage) {
		this.selectPage = selectPage;
	}

	public String getRowsPerPage() {
		return rowsPerPage;
	}

	public void setRowsPerPage(String rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
	}

	public String getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(String totalCount) {
		this.totalCount = totalCount;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}






	public String getLoginID() {
		return loginID;
	}






	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}






	public String getUserType() {
		return userType;
	}






	public void setUserType(String userType) {
		this.userType = userType;
	}
	
	
	
	

}
