$(document).ready(function () {
    $(".readLink").click(function (e) {
        e.preventDefault()

        $.ajax({
            url: readUrl,
            data:{
                id: $(".readLink").prop('href').split("/")[5]
            },
            success: function (response) {
                console.log(response)
                $(".related_posts").load(" .related_posts")
            }
        })
    });
})