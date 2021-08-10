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
                $("#email").val(response[1].email);
                $("#email").prop('disabled', true);
                $("#check_btn").prop('disabled', true);
                $("#check_btn").css({
                    "background": "lightblue",
                    "cursor": "not-allowed"
                });

                $("#userEmail").prop('value', response[1].email);
                $("#ques").text(response[1].ques);
                $(".checker").show();
            }
        });
    });
});