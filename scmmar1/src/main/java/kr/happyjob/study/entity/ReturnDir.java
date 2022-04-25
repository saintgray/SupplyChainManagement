package kr.happyjob.study.entity;

import java.util.List;

import org.apache.ibatis.type.Alias;

@Alias("returnAlias")
public class ReturnDir {

	private String returnId;
	private String regDate;
	private String delDate;
	private String editDate;
	private String confirmYN;
	
	private RefundInfo refundInfo;
	
	
	private DeliverDir delivDir;
	
	
	public ReturnDir() {
		
	}



	public ReturnDir(String returnId, String regDate, String delDate, String editDate, String confirmYN,
			RefundInfo refundInfo, DeliverDir delivDir) {

		this.returnId = returnId;
		this.regDate = regDate;
		this.delDate = delDate;
		this.editDate = editDate;
		this.confirmYN = confirmYN;
		this.refundInfo = refundInfo;
		this.delivDir = delivDir;
	}



	public String getReturnId() {
		return returnId;
	}


	public void setReturnId(String returnId) {
		this.returnId = returnId;
	}


	public String getRegDate() {
		return regDate;
	}


	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}


	public String getDelDate() {
		return delDate;
	}


	public void setDelDate(String delDate) {
		this.delDate = delDate;
	}


	public String getEditDate() {
		return editDate;
	}


	public void setEditDate(String editDate) {
		this.editDate = editDate;
	}


	public String getConfirmYN() {
		return confirmYN;
	}


	public void setConfirmYN(String confirmYN) {
		this.confirmYN = confirmYN;
	}


	public RefundInfo getRefundInfo() {
		return refundInfo;
	}


	public void setRefundInfo(RefundInfo refundInfo) {
		this.refundInfo = refundInfo;
	}



	public DeliverDir getDelivDir() {
		return delivDir;
	}



	public void setDelivDir(DeliverDir delivDir) {
		this.delivDir = delivDir;
	}
	
	
	
	
	
	
}
