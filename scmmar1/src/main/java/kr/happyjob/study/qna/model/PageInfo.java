package kr.happyjob.study.qna.model;

import java.util.List;

public class PageInfo {
	
	private SearchParam params;
	private List<QnaListRow> list;
	
	public PageInfo() {
		
	}
	
	

	public PageInfo(SearchParam params, List<QnaListRow> list) {
		
		this.params = params;
		this.list = list;
	}



	public SearchParam getParams() {
		return params;
	}

	public void setParams(SearchParam params) {
		this.params = params;
	}

	public List<QnaListRow> getList() {
		return list;
	}

	public void setList(List<QnaListRow> list) {
		this.list = list;
	}
	
	
	
	

}
