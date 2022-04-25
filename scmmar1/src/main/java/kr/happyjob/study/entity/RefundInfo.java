package kr.happyjob.study.entity;

import org.apache.ibatis.type.Alias;

@Alias("refundAlias")
public class RefundInfo {
	
	
	private String refundInfoId;
	private String accountNumber;
	private String accountHolder;
	private String bankName;
	private String returnCnt;
	private String regDate;
	
	private String cnt_total;
	
	private OrderInfo orderInfo;
	private PurchaseInfo purchaseInfo;
	
	private ReturnDir returnDir;
	
	public RefundInfo() {
		
	}



	public RefundInfo(String refundInfoId, String accountNumber, String accountHolder, String bankName,
			String returnCnt, String regDate, String cnt_total, OrderInfo orderInfo, PurchaseInfo purchaseInfo,
			ReturnDir returnDir) {
		
		this.refundInfoId = refundInfoId;
		this.accountNumber = accountNumber;
		this.accountHolder = accountHolder;
		this.bankName = bankName;
		this.returnCnt = returnCnt;
		this.regDate = regDate;
		this.cnt_total = cnt_total;
		this.orderInfo = orderInfo;
		this.purchaseInfo = purchaseInfo;
		this.returnDir = returnDir;
	}



	public String getRefundInfoId() {
		return refundInfoId;
	}

	public void setRefundInfoId(String refundInfoId) {
		this.refundInfoId = refundInfoId;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public String getAccountHolder() {
		return accountHolder;
	}

	public void setAccountHolder(String accountHolder) {
		this.accountHolder = accountHolder;
	}

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	public String getReturnCnt() {
		return returnCnt;
	}

	public void setReturnCnt(String returnCnt) {
		this.returnCnt = returnCnt;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public OrderInfo getOrderInfo() {
		return orderInfo;
	}

	public void setOrderInfo(OrderInfo orderInfo) {
		this.orderInfo = orderInfo;
	}

	public PurchaseInfo getPurchaseInfo() {
		return purchaseInfo;
	}

	public void setPurchaseInfo(PurchaseInfo purchaseInfo) {
		this.purchaseInfo = purchaseInfo;
	}


	public ReturnDir getReturnDir() {
		return returnDir;
	}


	public void setReturnDir(ReturnDir returnDir) {
		this.returnDir = returnDir;
	}



	public String getCnt_total() {
		return cnt_total;
	}



	public void setCnt_total(String cnt_total) {
		this.cnt_total = cnt_total;
	}
	
	
	
	
	
	
	
	
	

}
