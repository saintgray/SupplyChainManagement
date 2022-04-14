package kr.happyjob.study.ged.model;

public class ProfitAndLossModel {
	private int deliv_id;
	private String purdate;
	private String sales_Nm;
	private int sellSUM;
	private int returnSUM;
	private int sell;
	private String client;
	private String from_date;
	private String to_date;
	
	public ProfitAndLossModel() {
	}
	

	public ProfitAndLossModel(int deliv_id, String purdate, String sales_Nm, int sellSUM, int returnSUM, int sell,
			String client, String from_date, String to_date) {
		super();
		this.deliv_id = deliv_id;
		this.purdate = purdate;
		this.sales_Nm = sales_Nm;
		this.sellSUM = sellSUM;
		this.returnSUM = returnSUM;
		this.sell = sell;
		this.client = client;
		this.from_date = from_date;
		this.to_date = to_date;
	}


	@Override
	public String toString() {
		return "ProfitAndLossModel [deliv_id=" + deliv_id + ", purdate=" + purdate + ", sales_Nm=" + sales_Nm
				+ ", sellSUM=" + sellSUM + ", returnSUM=" + returnSUM + ", sell=" + sell + ", client=" + client
				+ ", from_date=" + from_date + ", to_date=" + to_date + "]";
	}


	public int getDeliv_id() {
		return deliv_id;
	}

	public void setDeliv_id(int deliv_id) {
		this.deliv_id = deliv_id;
	}

	public String getPurdate() {
		return purdate;
	}

	public void setPurdate(String purdate) {
		this.purdate = purdate;
	}

	public String getSales_Nm() {
		return sales_Nm;
	}

	public void setSales_Nm(String sales_Nm) {
		this.sales_Nm = sales_Nm;
	}

	public int getSellSUM() {
		return sellSUM;
	}

	public void setSellSUM(int sellSUM) {
		this.sellSUM = sellSUM;
	}

	public int getReturnSUM() {
		return returnSUM;
	}

	public void setReturnSUM(int returnSUM) {
		this.returnSUM = returnSUM;
	}

	public int getSell() {
		return sell;
	}

	public void setSell(int sell) {
		this.sell = sell;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getFrom_date() {
		return from_date;
	}

	public void setFrom_date(String from_date) {
		this.from_date = from_date;
	}

	public String getTo_date() {
		return to_date;
	}

	public void setTo_date(String to_date) {
		this.to_date = to_date;
	}
	
}