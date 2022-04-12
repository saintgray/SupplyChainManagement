package kr.happyjob.study.epc.model;

public class SearchParamDTO {
	String searchKeyword;
	String dateStart;
	String dateEnd;
	String loginID;
	String salesType;
	String mfcomp;
	String keywordProductList;
	int purID;
	int startIndex;
	int currentPage;
	int pageBlockSize;
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public String getDateStart() {
		return dateStart;
	}
	public String getDateEnd() {
		return dateEnd;
	}
	public String getLoginID() {
		return loginID;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public int getPageBlockSize() {
		return pageBlockSize;
	}
	public int getStartIndex() {
		return startIndex;
	}
	public int getPurID() {
		return purID;
	}
	public String getSalesType() {
		return salesType;
	}
	public String getMfcomp() {
		return mfcomp;
	}
	public String getKeywordProductList() {
		return keywordProductList;
	}
	public void setSalesType(String salesType) {
		this.salesType = salesType;
	}
	public void setMfcomp(String mfcomp) {
		this.mfcomp = mfcomp;
	}
	public void setKeywordProductList(String keywordProductList) {
		this.keywordProductList = keywordProductList;
	}
	public void setPurID(int purID) {
		this.purID = purID;
	}
	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public void setPageBlockSize(int pageBlockSize) {
		this.pageBlockSize = pageBlockSize;
	}
	public void setLoginID(String loginID) {
		if("".equals(loginID)) {
			loginID = null;
		}
		this.loginID = loginID;
	}
	public void setSearchKeyword(String searchKeyword) {
		if("".equals(searchKeyword)) {
			searchKeyword = null;
		}
		this.searchKeyword = searchKeyword;
	}
	public void setDateStart(String dateStart) {
		if("".equals(dateStart)) {
			dateStart = null;
		}
		this.dateStart = dateStart;
	}
	public void setDateEnd(String dateEnd) {
		if("".equals(dateEnd)) {
			dateEnd = null;
		}
		this.dateEnd = dateEnd;
	}
	@Override
	public String toString() {
		return "SearchParamDTO [searchKeyword=" + searchKeyword + ", dateStart=" + dateStart + ", dateEnd=" + dateEnd
				+ ", loginID=" + loginID + ", salesType=" + salesType + ", mfcomp=" + mfcomp + ", keywordProductList="
				+ keywordProductList + ", purID=" + purID + ", startIndex=" + startIndex + ", currentPage="
				+ currentPage + ", pageBlockSize=" + pageBlockSize + "]";
	}

	
	
	
	
}
