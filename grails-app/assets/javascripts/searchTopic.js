$(document).ready(function () {
    $(".search_results").hide();
    $("#search_btn").click(function () {
        $.ajax({
            url: dataUrl,
            data:{
                text: $("#search_text").val()
            },
            success: function(response){
                console.log(response);
                var html = '';
                html += '<div class="head_box">\n' +
                    '        <h3 style="margin: 0 2%; display: inline-block;">Search results for "' + $("#search_text").val() + '"</h3>\n' +
                    '    </div>' +
                    '     <div style="min-height: 8rem; max-height: 20rem; overflow-y: scroll">';
                $.each(response, function (index, item) {
                    let subsAns = item.isSubscribed;
                    if(subsAns == true){
                        html += '<div class="topic_details">\n' +
                            '        <img src="/assets'+ item.creatorPhoto +'" style="height: 5rem; width: 5rem;">\n' +
                            '        <div class="topic_info">\n' +
                            '            <p style="margin: 0;"><a href="/topic/viewTopic/'+ item.topicId +'">' + item.topicName + '</a></p>\n' +
                            '            <div style="display: flex; flex-direction: row; justify-content: space-between;">\n' +
                            '                <div>\n' +
                            '                    <p style="margin-bottom: 0;"><a href="/user/getProfile/'+ item.creatorId +'" style="text-decoration: none; color: darkred;">@' +item.creatorUserName+ '</a></p>\n' +
                            '                    <a href="/topic/unsubscribeTopic/'+item.topicId+'">Unsubscribe</a>\n' +
                            '                </div>\n' +
                            '                <div>\n' +
                            '                    <p style="margin-bottom: 0;">Subscriptions</p>\n' +
                            '                    <p>'+ item.subsCount +'</p>\n' +
                            '                </div>\n' +
                            '                <div>\n' +
                            '                    <p style="margin-bottom: 0;">Posts</p>\n' +
                            '                    <p>'+ item.postCount +'</p>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        </div>\n' +
                            '    </div>';
                    }else{
                        html += '<div class="topic_details">\n' +
                            '        <img src="/assets'+ item.creatorPhoto +'" style="height: 5rem; width: 5rem;">\n' +
                            '        <div class="topic_info">\n' +
                            '            <p style="margin: 0;"><a href="/topic/viewTopic/'+ item.topicId +'">' + item.topicName + '</a></p>\n' +
                            '            <div style="display: flex; flex-direction: row; justify-content: space-between;">\n' +
                            '                <div>\n' +
                            '                    <p style="margin-bottom: 0;">@' + item.creatorUserName + '</p>\n' +
                            '                    <a href="/topic/subscribeTopic/'+item.topicId+'">Subscribe</a>\n' +
                            '                </div>\n' +
                            '                <div>\n' +
                            '                    <p style="margin-bottom: 0;">Subscriptions</p>\n' +
                            '                    <p>'+ item.subsCount +'</p>\n' +
                            '                </div>\n' +
                            '                <div>\n' +
                            '                    <p style="margin-bottom: 0;">Posts</p>\n' +
                            '                    <p>'+ item.postCount +'</p>\n' +
                            '                </div>\n' +
                            '            </div>\n' +
                            '        </div>\n' +
                            '    </div>';
                    }
                });
                html += '</div>';
                $(".search_results").html(html);
                $(".search_results").show();
            }
        });
    });
});