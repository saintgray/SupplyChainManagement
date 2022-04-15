package kr.happyjob.study.scmDeal.model;

import java.sql.Date;

public class DailyDeal {
	
	private    int  oddtno            //주문번호
	             ,  stockcnt          //총 재고 개수
	             ,  oddtcnt           //주문개수
	             ,  orderamount       //금액합계
	             ,  pdcode            //제품모델번호
				 ,  stCntforModal     //총 재고 개수(모달)
				 ,  whcode			  //창고코드
				 ,  oddtdelcnt 		  //출고개수
				 ,  dcnt			  //출고건수
				 ,  rctn			  //반품수량
				 ,  pdno 			  //제품번호
				 ,  impdtcnt		  //발주(입고) 수량
				 ,  compId			  //납품회사고유번호
				 ,  importyn		  //발주여부
				 ,  pdmdprice		  //(제품)판매단가
				 ,	impprice;		  //발주단가
	private   Date  orderdate         //주문일자
	             ,  rtncomdate;       //반품처리일자
	private String  client            //고객기업명
	             ,  pdnm              //주문제품명
	             ,  oddtreqyn         //반품요청여부
	             ,  orderpayyn        //입금여부
	             ,  oddtreqynStr      //반품번역
				 ,  orderpayynStr	  //입금번역
				 ,  oddtcntStr		  //재고수량번역
			  	 ,	whnm         	  //창고이름
				 ,  pdmdno			  //모델이름
				 ,  productnm 		  //취급품목
				 ,  orderno           //일련번호
				 ,  loginID           //로그인ID
	             ,  userType		  //배송담당직원
	             ,  name			  //이름
	             ,  address			  //주소
	             ,  dtAddress		  //상세주소
	             ,  phone			  //휴대폰번호
	             ,  email			  //이메일주소
				 ,  compNm;			  //납품회사이름
	
	@Override
	public String toString() {
		return "DailyDeal [oddtno=" + oddtno + ", stockcnt=" + stockcnt + ", oddtcnt=" + oddtcnt + ", orderamount="
				+ orderamount + ", pdcode=" + pdcode + ", stCntforModal=" + stCntforModal + ", whcode=" + whcode
				+ ", oddtdelcnt=" + oddtdelcnt + ", dcnt=" + dcnt + ", rctn=" + rctn + ", pdno=" + pdno + ", impdtcnt="
				+ impdtcnt + ", compId=" + compId + ", importyn=" + importyn + ", pdmdprice=" + pdmdprice
				+ ", impprice=" + impprice + ", orderdate=" + orderdate + ", rtncomdate=" + rtncomdate + ", client="
				+ client + ", pdnm=" + pdnm + ", oddtreqyn=" + oddtreqyn + ", orderpayyn=" + orderpayyn
				+ ", oddtreqynStr=" + oddtreqynStr + ", orderpayynStr=" + orderpayynStr + ", oddtcntStr=" + oddtcntStr
				+ ", whnm=" + whnm + ", pdmdno=" + pdmdno + ", productnm=" + productnm + ", orderno=" + orderno
				+ ", loginID=" + loginID + ", userType=" + userType + ", name=" + name + ", address=" + address
				+ ", dtAddress=" + dtAddress + ", phone=" + phone + ", email=" + email + ", compNm=" + compNm + "]";
	}

	public DailyDeal() {
		
	}

	public int getOddtno() {
		return oddtno;
	}

	public void setOddtno(int oddtno) {
		this.oddtno = oddtno;
	}

	public int getStockcnt() {
		return stockcnt;
	}

	public void setStockcnt(int stockcnt) {
		this.stockcnt = stockcnt;
	}

	public int getOddtcnt() {
		return oddtcnt;
	}

	public void setOddtcnt(int oddtcnt) {
		this.oddtcnt = oddtcnt;
	}

	public int getOrderamount() {
		return orderamount;
	}

	public void setOrderamount(int orderamount) {
		this.orderamount = orderamount;
	}

	public Date getOrderdate() {
		return orderdate;
	}

	public void setOrderdate(Date orderdate) {
		this.orderdate = orderdate;
	}

	public Date getRtncomdate() {
		return rtncomdate;
	}

	public void setRtncomdate(Date rtncomdate) {
		this.rtncomdate = rtncomdate;
	}

	public String getClient() {
		return client;
	}

	public void setClient(String client) {
		this.client = client;
	}

	public String getPdnm() {
		return pdnm;
	}

	public void setPdnm(String pdnm) {
		this.pdnm = pdnm;
	}

	public String getOddtreqyn() {
		return oddtreqyn;
	}

	public void setOddtreqyn(String oddtreqyn) {
		this.oddtreqyn = oddtreqyn;
	}

	public String getOrderpayyn() {
		return orderpayyn;
	}

	public void setOrderpayyn(String orderpayyn) {
		this.orderpayyn = orderpayyn;
	}

	public int getPdcode() {
		return pdcode;
	}

	public void setPdcode(int pdcode) {
		this.pdcode = pdcode;
	}

	//질문 왜 oddtreqyn == "Y" 라고하면 안되나?
	public String getOddtreqynStr() {
		if ( "Y".equals(oddtreqyn)) {
			return "반품신청";
		} else {
			return "-";
		}
	}

	public void setOddtreqynStr(String oddtreqynStr) {
		this.oddtreqynStr = oddtreqynStr;
	}

	public String getOrderpayynStr() {		
		if ( "Y".equals(orderpayyn) ) {
			return "완료";
		} else {
			return "미입금 ";
		}
	}

	public void setOrderpayynStr(String orderpayynStr) {
		this.orderpayynStr = orderpayynStr;
	}

	public String getOddtcntStr() {
		if (stockcnt <= 0) {
			return "입고";
		} else {
			return "출고";
		}
	}

	public void setOddtcntStr(String oddtcntStr) {
		this.oddtcntStr = oddtcntStr;
	}

	public String getLoginID() {
		return loginID;
	}

	public void setLoginID(String loginID) {
		this.loginID = loginID;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDtAddress() {
		return dtAddress;
	}

	public void setDtAddress(String dtAddress) {
		this.dtAddress = dtAddress;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getWhcode() {
		return whcode;
	}

	public void setWhcode(int whcode) {
		this.whcode = whcode;
	}

	public String getWhnm() {
		return whnm;
	}

	public void setWhnm(String whnm) {
		this.whnm = whnm;
	}

	public int getStCntforModal() {
		return stCntforModal;
	}

	public void setStCntforModal(int stCntforModal) {
		this.stCntforModal = stCntforModal;
	}

	public String getPdmdno() {
		return pdmdno;
	}

	public void setPdmdno(String pdmdno) {
		this.pdmdno = pdmdno;
	}

	public int getOddtdelcnt() {
		return oddtdelcnt;
	}

	public void setOddtdelcnt(int oddtdelcnt) {
		this.oddtdelcnt = oddtdelcnt;
	}

	public String getProductnm() {
		return productnm;
	}

	public void setProductnm(String productnm) {
		this.productnm = productnm;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public int getDcnt() {
		return dcnt;
	}

	public void setDcnt(int dcnt) {
		this.dcnt = dcnt;
	}

	public int getRctn() {
		return rctn;
	}

	public void setRctn(int rctn) {
		this.rctn = rctn;
	}

	public int getPdno() {
		return pdno;
	}

	public void setPdno(int pdno) {
		this.pdno = pdno;
	}

	public int getImpdtcnt() {
		return impdtcnt;
	}

	public void setImpdtcnt(int impdtcnt) {
		this.impdtcnt = impdtcnt;
	}

	public int getCompId() {
		return compId;
	}

	public void setCompId(int compId) {
		this.compId = compId;
	}

	public String getCompNm() {
		return compNm;
	}

	public void setCompNm(String compNm) {
		this.compNm = compNm;
	}

	public int getImportyn() {
		return importyn;
	}

	public void setImportyn(int importyn) {
		this.importyn = importyn;
	}

	public int getPdmdprice() {
		return pdmdprice;
	}

	public void setPdmdprice(int pdmdprice) {
		this.pdmdprice = pdmdprice;
	}

	public int getImpprice() {
		return impprice;
	}

	public void setImpprice(int impprice) {
		this.impprice = impprice;
	}
	
}
