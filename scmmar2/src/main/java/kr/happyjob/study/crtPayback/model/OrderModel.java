package kr.happyjob.study.crtPayback.model;

import java.sql.Date;

public class OrderModel {
	
	private String orderno;
	private String userId;
	private Date orderdate;
	private int ordercnt;
	private String orderpayyn;
	private int orderamount;
	public String getOrderno() {
		return orderno;
	}
	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getOrderdate() {
		return orderdate;
	}
	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}
	public int getOrdercnt() {
		return ordercnt;
	}
	public void setOrdercnt(int ordercnt) {
		this.ordercnt = ordercnt;
	}
	public String getOrderpayyn() {
		return orderpayyn;
	}
	public void setOrderpayyn(String orderpayyn) {
		this.orderpayyn = orderpayyn;
	}
	public int getOrderamount() {
		return orderamount;
	}
	public void setOrderamount(int orderamount) {
		this.orderamount = orderamount;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + orderamount;
		result = prime * result + ordercnt;
		result = prime * result + ((orderdate == null) ? 0 : orderdate.hashCode());
		result = prime * result + ((orderno == null) ? 0 : orderno.hashCode());
		result = prime * result + ((orderpayyn == null) ? 0 : orderpayyn.hashCode());
		result = prime * result + ((userId == null) ? 0 : userId.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderModel other = (OrderModel) obj;
		if (orderamount != other.orderamount)
			return false;
		if (ordercnt != other.ordercnt)
			return false;
		if (orderdate == null) {
			if (other.orderdate != null)
				return false;
		} else if (!orderdate.equals(other.orderdate))
			return false;
		if (orderno == null) {
			if (other.orderno != null)
				return false;
		} else if (!orderno.equals(other.orderno))
			return false;
		if (orderpayyn == null) {
			if (other.orderpayyn != null)
				return false;
		} else if (!orderpayyn.equals(other.orderpayyn))
			return false;
		if (userId == null) {
			if (other.userId != null)
				return false;
		} else if (!userId.equals(other.userId))
			return false;
		return true;
	}
	@Override
	public String toString() {
		return "OrderModel [orderno=" + orderno + ", userId=" + userId + ", orderdate=" + orderdate + ", ordercnt="
				+ ordercnt + ", orderpayyn=" + orderpayyn + ", orderamount=" + orderamount + "]";
	}
	public OrderModel(String orderno, String userId, Date orderdate, int ordercnt, String orderpayyn, int orderamount) {
		super();
		this.orderno = orderno;
		this.userId = userId;
		this.orderdate = orderdate;
		this.ordercnt = ordercnt;
		this.orderpayyn = orderpayyn;
		this.orderamount = orderamount;
	}
	public OrderModel() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	
	
	
}
