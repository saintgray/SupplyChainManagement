package kr.happyjob.study.entity;

import org.apache.ibatis.type.Alias;

@Alias("sale")
public class Sale {
	
	protected String salesId;
	protected String salesType;
	protected String modelCode;
	protected String price;
	protected String modelName;
	protected String photo;
	protected String mfComp;
	protected String info;
	
	
	public Sale() {
		
	}


	public Sale(String salesId, String salesType, String modelCode, String price, String modelName, String photo,
			String mfComp, String info) {
		
		this.salesId = salesId;
		this.salesType = salesType;
		this.modelCode = modelCode;
		this.price = price;
		this.modelName = modelName;
		this.photo = photo;
		this.mfComp = mfComp;
		this.info = info;
	}


	public String getSalesId() {
		return salesId;
	}


	public void setSalesId(String salesId) {
		this.salesId = salesId;
	}


	public String getSalesType() {
		return salesType;
	}


	public void setSalesType(String salesType) {
		this.salesType = salesType;
	}


	public String getModelCode() {
		return modelCode;
	}


	public void setModelCode(String modelCode) {
		this.modelCode = modelCode;
	}


	public String getPrice() {
		return price;
	}


	public void setPrice(String price) {
		this.price = price;
	}


	public String getModelName() {
		return modelName;
	}


	public void setModelName(String modelName) {
		this.modelName = modelName;
	}


	public String getPhoto() {
		return photo;
	}


	public void setPhoto(String photo) {
		this.photo = photo;
	}


	public String getMfComp() {
		return mfComp;
	}


	public void setMfComp(String mfComp) {
		this.mfComp = mfComp;
	}


	public String getInfo() {
		return info;
	}


	public void setInfo(String info) {
		this.info = info;
	}
	
	
	
	
	
	

}
