package com.nexacro.sample.service;

import java.util.List;
import java.util.Map;

public interface testService {
	
	 List<Map<String,Object>> testselect(Map<String,String> searchInfo);
	 void updatetest(List<Map<String,Object>> sampleList);
}
