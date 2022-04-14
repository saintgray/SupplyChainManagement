package kr.happyjob.study.epc.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.epc.dao.ProductListDao;
import kr.happyjob.study.epc.model.SalesModel;
import kr.happyjob.study.epc.model.SearchParamDTO;
import kr.happyjob.study.epc.model.ShoppingCartItemDTO;

@Service
public class ProductListServiceImpl implements ProductListService{

	@Autowired
	ProductListDao pdao;
	
	//variables  using in lambda
	boolean doesntExistFlag = false;
	boolean salesExistDateDifferentFlag = false;
	boolean alreadyExistFlag = false;
	
	@Override
	public ArrayList<SalesModel> getListProduct(SearchParamDTO param) {
		ArrayList<SalesModel> list = null;
		list = pdao.getListProduct(param);
		return list;
	}
	
	@Override
	public SalesModel getProductDetail(int sales_id) {
		SalesModel product = null;
		product = pdao.getProductDetail(sales_id);
		return product ;
	}
	
	@Override
	public ArrayList<String> getSalesTypeList() {
		ArrayList<String> list = null;
		list = pdao.getSalesTypeList();
		return list;
	}
	
	
	@Override
	public ArrayList<String> getMfcompListBySalesType(String salesType) {
		ArrayList<String> list = null;
		HashMap<String, String> map = new HashMap<>();
		map.put("salesType", salesType);
		list = pdao.getMfcompListBySalesType(map);
		return list;
	}
	

	@Override
	public Integer orderAndCartProduct(ShoppingCartItemDTO param) {
		Integer result = 0;
		Integer status = null;
		if("cart".equals(param.getType())) {
			status = checkCartItem(param);
			switch(status){
				case 1 :	//row already exist
					System.out.println("already exist");
					ShoppingCartItemDTO already = getCartItem(param);
					param.setPur_cnt(already.getPur_cnt() +param.getPur_cnt());
					result = pdao.updateCartItemCnt(param);
					break;
				default :	//insert new row
					System.out.println("new row");
					result = pdao.addProductToCart(param);
			}
			
		} else	if("order".equals(param.getType())) {
			status = 1;
			System.out.println(param.toString());
			result = pdao.orderProductPurchase(param);
			result = pdao.orderProductPurchaseinfo(param);
			
		}
		
		return status;
	}
	
	@Override
	public int getListProductCnt(SearchParamDTO param) {
		int result = pdao.getListProductCnt(param);
		return result;
	}
	
	private Integer checkCartItem(ShoppingCartItemDTO param) {
		HashMap<String,Object> paramMap = new HashMap<>();
		paramMap.put("loginID", param.getLoginID());
		paramMap.put("sales_id", param.getSales_id());
		ArrayList<ShoppingCartItemDTO> itemList = pdao.getCartItems(paramMap);
		
		itemList.forEach((item)->{
			doesntExistFlag = false;
			salesExistDateDifferentFlag = false;
			alreadyExistFlag = false;
			boolean isId = param.getLoginID().equals(item.getLoginID());
			boolean isSalesId = param.getSales_id() == item.getSales_id();
			boolean isDate = param.getWanted_date().trim().equals(item.getWanteddate().trim());
			if(isId && isSalesId && isDate) {
				alreadyExistFlag = true;
			} else if (isId && isSalesId && !isDate) {
				salesExistDateDifferentFlag = true;
			} else {
				doesntExistFlag = true;
			} 
			System.out.println(doesntExistFlag);
			System.out.println(salesExistDateDifferentFlag);
			System.out.println(alreadyExistFlag);
		});
		if(alreadyExistFlag) {
			return 1;
		} else if(salesExistDateDifferentFlag) {
			return 0;
		} else {
			return -1;
		}
	}
	
	private ShoppingCartItemDTO getCartItem(ShoppingCartItemDTO param) {
		HashMap<String,Object> paramMap = new HashMap<>();
		paramMap.put("loginID", param.getLoginID());
		paramMap.put("sales_id", param.getSales_id());
		ArrayList<ShoppingCartItemDTO> itemList = pdao.getCartItems(paramMap);
		if(itemList.size() > 0) {
			return itemList.get(0);
		} else {
			return null;
		}
		
	}
}
