$("#login_button").on('click', function(e){
    if(!document.getElementById("#modal")){
        document.getElementById("loader-wrapper").style.display = "flex";
        $("modal-login").load("/login #modal", function(response, status, xhr){//function for onCemplete
            document.getElementById("loader-wrapper").style.display = "none";
            if(status == "success"){
                
            }else{
                console.log(xhr.statusText);
            }
        });
    }
});
function loginForm(){
    $("#login_form").on('submit', function(e){
        e.preventDefault();
        let formData = new FormData();
        formData = $(this).serializeArray();
        $.ajax({
            url: "/login",
            type: "POST", 
            data: $.param(formData),
            success: function(){
                location.reload();
            },
            error: function(){
                document.getElementById("error_label").innerHTML = "Incorrect username or password";
            }
        });
    });
    $("#close_button").on('click', function(e){
        $("#modal").remove();
    });
}
if(!document.getElementById("#logout_button")){
    $("#logout_button").on('click', function(e){
        $.ajax({
            url: "/logout",
            type: "POST", 
            success: function(){
                location.reload();
            },
            error: function(xhr){
                console.log(xhr.statusText);
            }
        });
    });
}