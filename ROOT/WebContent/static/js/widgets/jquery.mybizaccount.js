(function($){

	$.mybizaccount = function() {};
	
	$.mybizaccount.init = function() {
		
		
		
		$('#submitButton').bind('click', function(){
			submit();
		});
		$('#cancelButton').bind('click', function(){
			window.location = "/mybizaccount";
		});
		
		if($('#updateLogoButton')){
			$('#updateLogoButton').bind('click', function(){
				$('#logoimg').remove();
				$('#updateLogoButton').remove();
				$("#bizlogoli").append('<div class="fakeupload"><input required="false" type="text"  id="logo" name="bizlogo" validation="required:false"/>' +
                 '<button type="button" id="uploadButton" onclick="this.form.reallogo.click()">Upload</button></div><input type="file" name="reallogo" id="reallogo" class="reallogo" onchange="this.form.bizlogo.value = this.value;" />');
			});
		}
		
	};

	function submit(){
		$.log('click submit but.');
		if(!validate())
			return;
		document.getElementById("formBizUpdate").submit();
	}

	function validate(){
		var errormsg = '';
		$('#regform input[required= "true"]').each(function(){
			if($(this).val().length == 0){
				errormsg = 'Please enter required fields.';
				$('#' + this.id + 'label').css('color', 'red');
			}else
				$('#' + this.id + 'label').css('color', 'black');
		});
		if(errormsg.length > 0) {
			$('#errorMsg').text(errormsg);
			return false;
		}
		return true;
}
})(jQuery);
