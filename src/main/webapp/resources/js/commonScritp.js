/**
 * 
	//https://blog.naver.com/shinekjm/221633973281 : 한글깨짐관련 사이트.
	script.js : 편집툴로 인코딩 값을 Unicode로 변경한 뒤 새로 저장하면 한글깨짐 현상 해결.
 */


//아이디 체크
function idCheck() {
		
	isIdChecking = true;
	
	var id = $('input[name="id"]').val();
	if(id == ""){
		$('#idMessage').show();
		$('#idMessage').html("아이디 입력 후 중복 체크해주세요.").removeClass('messageBlue').addClass('messageRed');
		$('input[name="id"]').focus();
		return;
	}
	
	if(id.indexOf("admin") != -1 || id.indexOf("java") != -1
			|| id.indexOf("javascript") != -1){
		$('#idMessage').show();
		$('#idMessage').html(id + " 인 아이디는 사용 불가합니다.").removeClass('messageBlue').addClass('messageRed');
		$('input[name="id"]').focus();
		return;
	}
	
	$.ajax({
		url:'check_proc.jsp',
		type : "POST",
		data:{
			userId : id
		},
		success:function(data){
			//console.log("data:"+data.length + ", trim: "+ $.trim(data).length +","+ data.trim());
			
			//아이디 중복 체크했으면 변경된 메세지 보여주기.
			if(isIdChecking){
				$('#idMessage').show();
			}
			
			var dataTrim = $.trim(data); //페이지 따로 만들어서 했지만.. 혹시 몰라 한번 트림해봄.
			if(dataTrim == "YES"){
				$('#idMessage').html("사용가능합니다.").removeClass('messageRed').addClass('messageBlue');
				use = "possible";
			}else{
				$('#idMessage').html("이미 사용중인 아이디입니다.").removeClass('messageBlue').addClass('messageRed');
				use = "impossible";
			}
		},
		error:function(){
			alert("error로 인해 실패하였습니다.");
		}
	});
	
}
	
//아이디 체크
function idConfirm(){
	var id = $('input[name="id"]').val();
	
	if(id.indexOf("admin") != -1 || id.indexOf("java") != -1
			|| id.indexOf("javascript") != -1){
		$('#idMessage').show();
		$('#idMessage').html(id + " 인 아이디는 사용 불가합니다.").removeClass('messageBlue').addClass('messageRed');
		$('input[name="id"]').focus();
		return;
	}else{
		$('#idMessage').html("").removeClass('messageRed');
	}
}	

//닉네임 체크
function nickNameChk(){
	
	var nickname = $('input[name="nickname"]').val();
	if(nickname == ""){
		return;
	}
		
	$.ajax({
		url:'check_proc.jsp',
		type : "POST",
		data:{
			nickname : nickname
		},
		success:function(data){
			//console.log("data:"+data.length + ", trim: "+ $.trim(data).length +","+ data.trim());
			
			if(data == "YES"){
				$('#nickNameMessage').html("").removeClass('messageRed');
				nickNameUse = "possible";
			}else{
				$('#nickNameMessage').html("이미 사용중인 닉네임입니다.").addClass('messageRed');
				nickNameUse = "impossible";
			}
			isNickNameChecking = true;
		},
		error:function(){
			alert("error로 인해 실패하였습니다.");
		}
	});
}	
	
//패스워드 체크
function pwCheck(){
	var pw = $('input[name="pwd"]').val();
	var id = $('input[name="id"]').val();
	var regExp = /^[a-z0-9]{3,8}$/;

	if(pw == ""){
		return;
	}
	
	if(pw.search(/\s/) != -1){
		alert("비밀번호는 공백 없이 입력해주세요.");
		$('input[name="pwd"]').val("");
		$('input[name="pwd"]').focus();
		return;
	}
	
	
	if(pw.search(regExp) == -1){
		alert("비번 형식이 틀렸습니다.");
		$('input[name="pwd"]').val("");
		$('input[name="pwd"]').focus();
		return;
	}
	
	/*if(id != ""){
		if(pw.search(id) > -1){
			alert("비번에 아이디가 포함되어있습니다.");
			$('input[name="pwd"]').val("");
			$('input[name="pwd"]').focus();
			return;
		}
	}*/
	
	var chk_num = pw.search(/[0-9]/);
	var chk_eng = pw.search(/[a-z]/);
	
	//console.log(chk_num +"," + chk_eng);

	if(chk_num <0 || chk_eng <0){
		alert("비번은 영문자 숫자 조합해주세요.");
		$('input[name="pwd"]').val("");
		$('input[name="pwd"]').focus();
		return;
	}
}	


//패스워드 체크
function pwCheckConfirm(){
	var pw = $('input[name="pwd"]').val();
	var id = $('input[name="id"]').val();
	var regExp = /^[a-z0-9]{3,8}$/;

	if(pw == ""){
		return;
	}
	
	if(pw.search(/\s/) != -1){
		$('#pwdMessage').html("비밀번호는 공백 없이 입력해주세요.").addClass('messageRed');
		$('input[name="pwd"]').val("");
		$('input[name="pwd"]').focus();
		return;
	}else{
		$('#pwdMessage').html("").removeClass('messageRed');
	}
	
	
	if(pw.search(regExp) == -1){
		$('#pwdMessage').html("비번 형식이 틀렸습니다.").addClass('messageRed');
		$('input[name="pwd"]').val("");
		$('input[name="pwd"]').focus();
		return;
	}else{
		$('#pwdMessage').html("").removeClass('messageRed');
	}
	
	if(id != ""){
		if(pw.search(id) > -1){
			$('#pwdMessage').html("비번에 아이디가 포함되어있습니다.").addClass('messageRed');
			$('input[name="pwd"]').val("");
			$('input[name="pwd"]').focus();
			return;
		}
	}else{
		$('#pwdMessage').html("").removeClass('messageRed');
	}
	
	var chk_num = pw.search(/[0-9]/);
	var chk_eng = pw.search(/[a-z]/);
	
	//console.log(chk_num +"," + chk_eng);

	if(chk_num <0 || chk_eng <0){
		$('#pwdMessage').html("비번은 영문자 숫자 조합해주세요.").addClass('messageRed');
		$('input[name="pwd"]').val("");
		$('input[name="pwd"]').focus();
		return;
	}else{
		$('#pwdMessage').html("").removeClass('messageRed');
	}
}	

//비밀번호 일치 체크
function passwdConfirm(){

	if($('input[name="pwd"]').val() != $('input[name="repwd"]').val()){
		$('#passwordMessage').html("비밀번호 불일치합니다.").removeClass('messageRed').addClass('messageBlue');
	}else{
		$('#passwordMessage').html("비밀번호 일치합니다.").removeClass('messageBlue').addClass('messageRed');
	}
	
	$('#passwordMessage').show();
}


//이름 한글로만 입력 가능하게 
function nameConfirm(){
	
	var name = $('input[name="name"]').val();
	var regExp = /^[가-힣]{2,4}$/;

	if(name == ""){
		return;
	}
	
	if(name.search(/\s/) != -1){
		$('#nameMessage').html("이름은 공백 없이 입력해주세요.").addClass('messageRed');
		$('input[name="name"]').val("");
		$('input[name="name"]').focus();
		return;
	}else{
		$('#nameMessage').html("").removeClass('messageRed');
	}
	
	if(name.search(regExp) == -1){
		$('#nameMessage').html("한글이름이 올바르지 않습니다.").addClass('messageRed');
		$('input[name="name"]').val("");
		$('input[name="name"]').focus();
		return;
	}else{
		$('#nameMessage').html("").removeClass('messageRed');
	}
	
}

//이메일 체크
function emailConfirm(){
	var email = $('input[name="email"]').val();
	var regExp = /^[a-zA-Z0-9]{3,12}@[a-zA-Z]+[.][a-zA-Z]{3}$/ ;
	
	if(email == ""){
		return;	
	}
	if(email.search(/\s/) != -1){
		$('#emailMessage').html("이메일은 공백 없이 입력해주세요.").addClass('messageRed');
		$('input[name="email"]').val("");
		$('input[name="email"]').focus();
		return;
	}else{
		$('#emailMessage').html("").removeClass('messageRed');	
	}
	
	if(email.search(regExp) == -1){
		$('#emailMessage').html("이메일을 올바르게 입력해주세요.").addClass('messageRed');
		$('input[name="email"]').val("");
		$('input[name="email"]').focus();
		return;
	}else{
		$('#emailMessage').html("").removeClass('messageRed');	
	}
	
}
	
// 회원등록 유효성검사	
function inputCheck() {
	
	var id = $('input[name="id"]').val();
	if(id == "admin"){
		alert(id +" 인 아이디는 사용불가합니다.");
		$('input[name="id"]').focus();
		return false;
	}
	
	if(!isInputNullChk("비밀번호", 'pwd')){
		return false;
	}

	if(!isInputNullChk("비밀번호 확인", 'repwd')){
		return false;
	}

	if($('input[name="pwd"]').val() != $('input[name="repwd"]').val()){
		alert("비밀번호가 다릅니다. 다시 확인해주세요.");
		$('input[name="repwd"]').select();
		return false;
	}
	
	if(!isInputNullChk("이름", 'name')){
		return false;
	}
	
	if(!isInputNullChk("성별", 'sex')){
		return false;
	}
	
	if(!isInputNullChk("닉네임", 'nickname')){
		return false;
	}
	
	if(!isInputNullChk("이메일", 'email')){
		return false;
	}
	
	return true;
}


//누락 체크 함수
function isInputNullChk(inputText, name , type) {
	var inputType; 	//inputType추출 변수
	
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


//게시판 타입 체크하는 Ajax
function boardTypeChk(boardType) {
	console.log(boardType);
	
	$.ajax({
		url:'boardAjaxProc.jsp',
		type : "POST",
		data:{
			boardType : boardType
		},
		success:function(data){
			if(data == 0){
				use = "possible";
			}else{
				use = "impossible";
			}
		},
		error:function(){
			alert("error로 인해 실패하였습니다.");
		}
	});
	
}




//브라우저 정보 얻어오기. (동영상 넣을까말까 고민중..동영상 저장하면.. 브라우저 체크를 해야할듯.)
function userAgentInfo(){
	var userAgent = navigator.userAgent.toLowerCase();
	
	if(userAgent.indexOf('egde') >-1){
		borwser='edge';
		browserVer = userAgent.slice(userAgent.search('edg/'),-1).split(' ')[0].split('/')[1].split('.')[0];
	}
	
	if(userAgent.indexOf('chrome') >-1){
		borwser='chrome';
		browserVer = userAgent.slice(userAgent.search('chrome/'),-1).split(' ')[0].split('/')[1].split('.')[0];
	}
	
	if(userAgent.indexOf('firefox') >-1){
		borwser='firefox';
		browserVer = userAgent.slice(userAgent.search('firefox/'),-1).split(' ')[0].split('/')[1].split('.')[0];
	}
	
	//아이폰관련에서는 맞는건지 모르겠다..ㅠ.ㅠ.. 다시 확인해봐야함..
	
	/* if(userAgent.indexOf('safari') >-1 || userAgent.indexOf('iphone') >-1 || userAgent.indexOf('ipad') >-1){
		borwser='safari';
		browserVer = userAgent.slice(userAgent.search('version/'),-1).split(' ')[0].split('/')[1].split('.')[0];
	} */
	
	//브라우저명, 브라우저 버전
	console.log(borwser+","+browserVer);
	
}

//페이징 관련 함수
function pageingAppend(count, pageSize, currentPage, url, eleId) {
	//console.log("append:" + count+ "," + pageSize + "," + currentPage);
	
	var tag = "";
	
	if(count>0){
		var pageCount = count/pageSize + (count % pageSize == 0 ? 0 : 1);
		var pageBlock = 10;
		
		var startPage = (Math.round((currentPage-1) / pageBlock)*pageBlock)+1;
		var endPage = startPage + pageBlock-1;
		
		if(endPage > pageCount){
			endPage = pageCount;
		}
		
		if(startPage > 10){
			tag += "<li><a href=" + url + (startPage - 10) + "><span>«</span></a></li>";
		}
		
		for(var i = startPage; i<=endPage; i++){
			var liClass = i == currentPage ? "class='active'" : "";
			
			tag += "<li " + liClass + "><a href=" + url + i + ">" + i + "</a></li>";
		}
		
		if(endPage < pageCount){
			tag += "<li><a href=" + url + (startPage + 10) + "><span>»</span></a></li>";
		}
	}
	
	$("#" + eleId).append(tag);
}

