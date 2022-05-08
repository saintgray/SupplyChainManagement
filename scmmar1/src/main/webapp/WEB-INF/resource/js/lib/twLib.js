
function numFormmat(num) { //넘버 포맷 함수
	return new Intl.NumberFormat().format(num);
}

//ex) {{ statusData(item.deliverStatus,'U,O,E','배송준비,배송시작,배송완료') }}
function statusVal(data, statusKey, statusVal) { //키벨류 값 출력
        let statusKeys = statusKey.split(','); // key
        let statusVals = statusVal.split(','); // value
        
        let i=0;
        let dataArr = {};
        
        for(i; i < statusKeys.length; i++) {
            dataArr[statusKeys[i]] = statusVals[i];  // 원하는 key,val 배열에 담기
        }
        let dataVal = dataArr[data];  //val 출력
        
        return dataVal;
    }
	
//데이트 타임 포맷
function dateFormatter(date) { //타임스템프 날짜변환 처리
	var result = "";
	if(date != null && date != "") {  //널값은 유닉스 시간이 나오기 때문에 조건처리
		var now = new Date(date);
		var year = now.getFullYear() < 10 ? '0' + now.getFullYear() : now.getFullYear();
		var month = now.getMonth() + 1 < 10 ? '0' + (now.getMonth() + 1) : (now.getMonth() + 1);
		var day = now.getDate() < 10 ? '0' + now.getDate() : now.getDate();
		var result = year + '-' + month + '-' + day;
	} 
	
	return result;
}

/*axios 메소드
 기존 ajax -> callAjax("/dlm/selectDeliOrder.do", "post", "json", true, param, resultCallback);
 변경 axios -> axiosFnc("/dlm/selectDeliOrder.do", "post", "json", param, resultCallback); 
 sync 기능만 없음 cdn 방식으로 지원안하기 때문에 추가안함 
 */
function axiosFnc(url,method,param, pfChk, callback) {
	// FormData의 값 확인
	/*
	for (var pair of param.entries()) {
	  console.log(pair[0]+ ', ' + pair[1]);
	}
	*/
	if(pfChk == "f") { //폼 데이터
		 axios(
				 {
					  url: url,
					  method: method,
						  data : param
				 },
				 { 
					 headers: { "Content-Type": 'multipart/form-data'}
				 }
			).then(function (response) {
			    callback(response) //리턴 값
			}).catch(function (error) {
			    console.log(error);
			}).then(function () {
			    // always executed (try catch finally에서 finally부분)
			});
	} else if(pfChk == "p") { //객체 데이터
		axios(
				 {
					  url: url,
					  method: method,
					  params : param
				 },
				 { 
					 headers: { "Content-Type": 'application/json'}
				 }
			).then(function (response) {
			    callback(response) //리턴 값
			}).catch(function (error) {
			    console.log(error);
			}).then(function () {
			    // always executed (try catch finally에서 finally부분)
			});
	}
}