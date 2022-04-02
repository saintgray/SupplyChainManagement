package kr.happyjob.study.scm.user.model;

import java.util.List;

public class PageInfo {
	
	
	private int selectPage;
	private int rowsPerPage;
	private String searchType;
	private String keyword;
	private String totalPage;
	private int totalCount;
	private int firstIndex;
	private String showall;
	List<User> userlist;
	
	
	public PageInfo() {
		
	}


	


	public int getSelectPage() {
		return selectPage;
	}





	public void setSelectPage(int selectPage) {
		this.selectPage = selectPage;
	}







	public int getRowsPerPage() {
		return rowsPerPage;
	}





	public void setRowsPerPage(int rowsPerPage) {
		this.rowsPerPage = rowsPerPage;
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


	public String getTotalPage() {
		return totalPage;
	}


	public void setTotalPage(String totalPage) {
		this.totalPage = totalPage;
	}


	

	public int getTotalCount() {
		return totalCount;
	}


	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}


	public int getFirstIndex() {
		return firstIndex;
	}


	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}


	public List<User> getUserlist() {
		return userlist;
	}


	public void setUserlist(List<User> userlist) {
		this.userlist = userlist;
	}


	public String getShowall() {
		return showall;
	}


	public void setShowall(String showall) {
		this.showall = showall;
	}
	
	
	
	
	

	
	

}
