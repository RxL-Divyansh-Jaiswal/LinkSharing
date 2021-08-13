$(document).ready(function () {
    $(".checker").hide();
    $("#check_btn").click(function () {
        $.ajax({
            url: checkUrl,
            data:{
                email: $("#email").val()
            },
            success: function (response) {
                console.log(response);
                if(response.length === 0){
                    $("#errMsg").text("No account with this email exists, Try again...");
                }else{
                    $("#email").val(response[0].email);
                    $("#email").prop('disabled', true);
                    $("#check_btn").prop('disabled', true);
                    $("#check_btn").css({
                        "background": "lightblue",
                        "cursor": "not-allowed"
                    });

                    $("#userEmail").prop('value', response[0].email);
                    $("#ques").text(response[0].ques);
                    $(".checker").show();
                }
            }
        });
    });
});