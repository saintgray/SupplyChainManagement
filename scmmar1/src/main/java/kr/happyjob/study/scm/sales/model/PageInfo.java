package kr.happyjob.study.scm.sales.model;

import java.util.List;


public class PageInfo {
	
	private int selectPage;
	private int rowsPerPage;
	private String searchType;
	private String keyword;
	private int totalCount;
	private int firstIndex;
	
	private List<Sales> salesList;
	
	
	
	public PageInfo() {
		
	}



	public PageInfo(int selectPage, int rowsPerPage, String searchType, String keyword, int totalCount, int firstIndex,
			List<Sales> salesList) {
		super();
		this.selectPage = selectPage;
		this.rowsPerPage = rowsPerPage;
		this.searchType = searchType;
		this.keyword = keyword;
		this.totalCount = totalCount;
		this.firstIndex = firstIndex;
		this.salesList = salesList;
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



	public List<Sales> getSalesList() {
		return salesList;
	}



	public void setSalesList(List<Sales> salesList) {
		this.salesList = salesList;
	}
	
	
	
	
	

}
