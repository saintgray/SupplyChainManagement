package kr.happyjob.study.epc.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.epc.dao.ProductListDao;
import kr.happyjob.study.epc.model.SalesModel;

@Service
public class ProductListServiceImpl implements ProductListService{

	@Autowired
	ProductListDao pdao;
	
	public ArrayList<SalesModel> getListProduct() {
		ArrayList<SalesModel> list = null;
		list = pdao.getListProduct();
		return list;
	}
	
	public SalesModel getProductDetail(int sales_id) {
		SalesModel product = null;
		product = pdao.getProductDetail(sales_id);
		return product ;
	}
	
	public ArrayList<String> getSalesTypeList() {
		ArrayList<String> list = null;
		list = pdao.getSalesTypeList();
		return list;
	}
	
	public ArrayList<String> getMfcompListBySalesType(String salesType) {
		ArrayList<String> list = null;
		HashMap<String, String> map = new HashMap<>();
		map.put("salesType", salesType);
		list = pdao.getMfcompListBySalesType(map);
		return list;
	}
	
	public ArrayList<SalesModel> searchProductList(HashMap<String, String> params) {
		ArrayList<SalesModel> slist = pdao.searchProductList(params);
		
		return slist;
	}
	
	public Integer orderAndCartProduct(HashMap<String, String> params) {
		String type = params.get("type");
		Integer result = 0;
		if("cart".equals(type)) {
			result = pdao.addProductToCart(params);
		} else	if("order".equals(type)) {
			System.out.println(params.toString());
			result = pdao.orderProductPurchase(params);
			result = pdao.orderProductPurchaseinfo(params);
			
		}
		
		return result;
	}
	
}
