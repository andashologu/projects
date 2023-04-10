document.getElementById("modal").style.display = "none";
$("#login_button").on('click', function(e){
    document.getElementById("modal").style.display = "flex";
});

let formData = new FormData();
$("#login_form").on('submit', function(e){
    e.preventDefault();
    var formData = $(this).serializeArray();
    $.ajax({
        url: "/login",
        type: "POST", 
        data: $.param(formData),
        success: function(){
            location.reload();
        },
        error: function(response){
            document.getElementById("error_label").innerHTML = "Incorrect username or password";
            console.log("status: "+response.status);
            console.log("statusText: "+response.statusText);
            console.log("readyState: "+response.readyState);
            console.log("responseText: "+response.responseText);
            console.log("responseXML: "+response.responseXML);
            console.log("responseJSON: "+response.responseJSON);
            console.log("headerJSON: "+response.headerJSON);
            console.log("request: "+response.request);
            console.log("transport: "+response.transport);
            
        }
    });
});