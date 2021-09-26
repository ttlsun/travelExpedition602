
//누락 체크 함수
function isInputNullChk(inputText, name , type) {
	
	//만약에 type은 안넘겨주면, 타입추출해서 분기태우기.
	if(type == null || type == ""){ //type == undefined
		inputType = $("input[name='"+ name +"']").attr('type');
	}else{
		inputType = type;
	}

	//console.log("넘긴 type: "+type +" , 추출 inputType:"+inputType +", inputName : " + name);
	
	if(inputType == "checkbox" || inputType == "radio"){
		if(!$("input[type="+inputType+"][name='"+name+"']").is(':checked')){
			alert(inputText + "하나는 선택하세요.");
			return false;
		}
	}else if(inputType == "select"){
		if($("select[name='"+name+"'] option:selected").val() == "선택"){
			alert(inputText + " 선택해주세요.");
			return false;
		}
	}else if(inputType == "textarea"){
		if($("textarea[name='"+name+"']").val() == ""){
			alert(inputText + " 입력해주세요.");
			$("textarea[name='"+name+"']").focus();
			return false;
		}
	}else{
		if ($("input[name='"+ name +"']").val() == "") {
			alert(inputText + " 값이 없습니다.");
			$("input[name='"+ name +"']").focus();
			return false;
		}
	}
	
	return true;
}

//길이 체크
function isInputLen(inputText, name , startLen, endLen, type) {
	console.log("type: "+type +" , name : " + name + "," +startLen + "," +endLen);
	
	var inputNume ;
	if(type == "textarea"){
		inputNume = $("textarea[name='"+name+"']").val().length;	
		
		if(inputNume < startLen || inputNume > endLen ){
			alert(inputText + "는 최소 "+startLen +" 자 에서 최대 "+endLen +" 자로 입력하세요.");
			$("textarea[name='"+ name +"']").focus();
			return false;
		}
		
	}else{
		inputNume = $("input[name='"+ name +"']").val().length;
		
		if(inputNume < startLen || inputNume > endLen ){
			alert(inputText + "는 최소 "+startLen +" 자 에서 최대 "+endLen +" 자로 입력하세요.");
			$("input[name='"+ name +"']").focus();
			return false;
		}
	}
	return true;	
	
}