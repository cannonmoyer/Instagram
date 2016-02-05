
$(document).ready(function(){
	$("#form_correct").submit(function(){
    	$("#action").prop('disabled', true);
    	}
    );//end click
    
    $("#lmoButton").click(function(){
    	lmoGetUsers()
    });//end keyup
});//end doc


function lmoGetUsers(){
	var username = $('#username').val();  
	if(username == ""){
		alert("You must specify a valid username!")
	}else{
		$.ajax({
		    type : 'get',
		    url : "/instagram_accounts/"+username+"/get_user_media_interactions",    
		    dataType : 'script',
		    async : true,
		    success : function(data) {
		    	 
		    }//end function
		});//end ajax
	}
}