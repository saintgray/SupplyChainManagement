package kr.happyjob.study.epc.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	//variables using in lambda clause
	boolean doesntExistFlag = false;
	boolean salesExistDateDifferentFlag = false;
	boolean alreadyExistFlag = false;
	
	@Override
	public List<SalesModel> getListProduct(SearchParamDTO param) {
		List<SalesModel> list = null;
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
	public List<String> getSalesTypeList() {
		List<String> list = null;
		list = pdao.getSalesTypeList();
		return list;
	}
	
	
	@Override
	public List<String> getMfcompListBySalesType(String salesType) {
		List<String> list = null;
		Map<String, String> map = new HashMap<>();
		map.put("salesType", salesType);
		list = pdao.getMfcompListBySalesType(map);
		return list;
	}
	

	@Override
	public int orderAndCartProduct(ShoppingCartItemDTO param) {
		int result = 0;
		if("cart".equals(param.getType())) {
			int status = checkCartItem(param);
			switch(status){
				case 1 :	//cart item already exists
					System.out.println("already exist");
					ShoppingCartItemDTO already = getCartItem(param);
					param.setPur_cnt(already.getPur_cnt() +param.getPur_cnt());
					pdao.updateCartItemCnt(param);
					return status;
				default :	//insert a new row
					System.out.println("new row");
					pdao.addProductToCart(param);
					return status;
			}
			
		} else	if("order".equals(param.getType())) {
			int result1 = pdao.orderProductPurchase(param);
			int result2 = pdao.orderProductPurchaseinfo(param);
			if(result1==1 && result2==1) {
				result = 1;
			}
		}
		
		return result;
	}
	
	@Override
	public int getListProductCnt(SearchParamDTO param) {
		int result = pdao.getListProductCnt(param);
		return result;
	}
	
	private int checkCartItem(ShoppingCartItemDTO param) {
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("loginID", param.getLoginID());
		paramMap.put("sales_id", param.getSales_id());
		paramMap.put("wanted_date", param.getWanted_date());
		List<ShoppingCartItemDTO> itemList = pdao.getCartItems(paramMap);
		
		itemList.forEach((item)->{
			doesntExistFlag = false;
			salesExistDateDifferentFlag = false;
			alreadyExistFlag = false;
			boolean isId = param.getLoginID().equals(item.getLoginID());
			boolean isSalesId = param.getSales_id() == item.getSales_id();
			boolean isDate = param.getWanted_date().trim().equals(item.getWanted_date().trim());
			if(isId && isSalesId && isDate) {
				alreadyExistFlag = true;
			} else if (isId && isSalesId && !isDate) {
				salesExistDateDifferentFlag = true;
			} else {
				doesntExistFlag = true;
			} 
		});
		if(alreadyExistFlag) {
			initFlags();
			return 1;
		} else if(salesExistDateDifferentFlag) {
			initFlags();
			return 0;
		} else {
			initFlags();
			return -1;
		}
	}
	private void initFlags() {
		doesntExistFlag = false;
		salesExistDateDifferentFlag = false;
		alreadyExistFlag = false;
	}
	private ShoppingCartItemDTO getCartItem(ShoppingCartItemDTO param) {

		System.out.println("getCartItem > param");
		System.out.println(param);
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("loginID", param.getLoginID());
		paramMap.put("sales_id", param.getSales_id());
		paramMap.put("wanted_date", param.getWanted_date());
		List<ShoppingCartItemDTO> itemList = pdao.getCartItems(paramMap);
		System.out.println("getCartItem > itemList");
		System.out.println(itemList);
		if(itemList.size() > 0) {
			return itemList.get(0);
		}
		return null;
		
	}
}
