package kr.happyjob.study.scm.orders.dao;

import java.util.List;

import kr.happyjob.study.scm.orders.model.DirModel;

public interface DirDao {

	int insertShippingDir(List<DirModel> regData);

}
