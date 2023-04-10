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
        error: function(){
            document.getElementById("error_label").innerHTML = "Incorrect username or password";
        }
    });
});