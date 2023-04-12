$("#login_button").on('click', function(e){
    /*$.get("/login", function(data){
        $("body").append(data);
    });*/

    $.ajax({
        async: false,
        type: 'GET',
        url: '/login',
        success: function(data) {
            /*alert($(data).find('#modal').html())
            $("body").append($(data).find('#modal').html());

            */
            $('<div />').load('/login', function(data) {
                //$("body").append($(this).find('modal').html());
                document.getElementByTagName("body").appendChild(document.createTextNode($(this).find('modal').html()));
            });

            $("#close_button").on('click', function(e){
                $("#modal").remove();
             });
        }
    });
});





let formData = new FormData();
$("#login_form").on('submit', function(e){
    e.preventDefault();
    formData = $(this).serializeArray();
    $.ajax({
        url: "/login",
        type: "POST", 
        data: $.param(formData),
        success: function(){
            location.reload();
        },
        error: function(response){
            document.getElementById("error_label").innerHTML = "Incorrect username or password";
        }
    });
});