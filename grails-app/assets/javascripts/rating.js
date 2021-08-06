$(document).ready(function () {
    $('#rating-form').on('change','[name="rating"]',function(){
        console.log($('[name="rating"]:checked').val());

        $.ajax({
            url: rateUrl,
            data:{
                id: $("#rating-form").attr('action'),
                score: $('[name="rating"]:checked').val()
            },
            success: function (response) {
                console.log(response);
            }
        });
    });
});
