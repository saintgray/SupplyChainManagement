package kr.happyjob.study.entity;

public class DeliverDir {
	
	private String delivId;
	private String regDate;
	private String delDate;
	private String deliverStatus;
	private String purInfId;
	private String orderId;
	private String delivWhId;
	
	public DeliverDir() {
		
	}

	public DeliverDir(String delivId, String regDate, String delDate, String deliverStatus, String purInfId,
			String orderId, String delivWhId) {
		
		this.delivId = delivId;
		this.regDate = regDate;
		this.delDate = delDate;
		this.deliverStatus = deliverStatus;
		this.purInfId = purInfId;
		this.orderId = orderId;
		this.delivWhId = delivWhId;
	}

	public String getDelivId() {
		return delivId;
	}

	public void setDelivId(String delivId) {
		this.delivId = delivId;
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

	public String getDeliverStatus() {
		return deliverStatus;
	}

	public void setDeliverStatus(String deliverStatus) {
		this.deliverStatus = deliverStatus;
	}

	public String getPurInfId() {
		return purInfId;
	}

	public void setPurInfId(String purInfId) {
		this.purInfId = purInfId;
	}

	public String getOrderId() {
		return orderId;
	}

	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}

	public String getDelivWhId() {
		return delivWhId;
	}

	public void setDelivWhId(String delivWhId) {
		this.delivWhId = delivWhId;
	}
	
	
	
	
	

}
