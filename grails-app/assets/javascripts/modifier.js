function changeVisibility(id,value){
    $.ajax({
        url: visUrl,
        data: {
            new_visibility: value,
            topic_id: id
        },
        success:function(response){
            console.log(response);
            $("#subs_list").load(" #subs_list")
            $("#trend_list").load(" #trend_list")
            $("#topic_list").load(" #topic_list")
            $("#topic_details").load(" #topic_details")
        }
    });
}

function changeSeriousness(id,value){
    $.ajax({
        url: serUrl,
        data: {
            new_seriousness: value,
            subs_id: id
        },
        success:function(response){
            console.log(response);
            $("#subs_list").load(" #subs_list")
            $("#trend_list").load(" #trend_list")
            $("#topic_list").load(" #topic_list")
            $("#topic_details").load(" #topic_details")
        }
    });
}

function updateName(id) {
    $.ajax({
        url: nameUrl,
        data:{
            new_name: $("#new_name"+id).val(),
            topic_id: id
        },
        success: function (response) {
            console.log(response);
            $("#subs_list").load(" #subs_list")
            $("#trend_list").load(" #trend_list")
            $("#topic_list").load(" #topic_list")
        }
    });
}