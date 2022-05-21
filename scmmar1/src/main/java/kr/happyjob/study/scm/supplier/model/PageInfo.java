package kr.happyjob.study.scm.supplier.model;

import java.util.List;

public class PageInfo {
	
	private int selectPage;
	private int rowsPerPage;
	private String searchType;
	private String keyword;
	private int totalCount;
	private int totalPage;
	private int firstIndex;
	private List<Supplier> suppliers;
	
	public PageInfo() {
	
	}

	public PageInfo(int selectPage, int rowsPerPage, String searchType, String keyword, int totalCount, int totalPage,
			int firstIndex, List<Supplier> suppliers) {
		this.selectPage = selectPage;
		this.rowsPerPage = rowsPerPage;
		this.searchType = searchType;
		this.keyword = keyword;
		this.totalCount = totalCount;
		this.totalPage = totalPage;
		this.firstIndex = firstIndex;
		this.suppliers = suppliers;
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


	public List<Supplier> getSuppliers() {
		return suppliers;
	}


	public void setSuppliers(List<Supplier> suppliers) {
		this.suppliers = suppliers;
	}


	public int getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(int totalPage) {
		this.totalPage = totalPage;
	}
	

	
	
	
	
	
	
	

}
