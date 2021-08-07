$(document).ready(function () {
   setInterval(function () {
       $.ajax({
           url: topUrl,
           success: function (response) {
               var html = '';
               for(let i = 0; i < response.length; i++) {
                   if(response[i].minsPassed == undefined){
                       if(response[i].description.length <= 120){
                           html += '<div class="card">\n' +
                               '                    <img src="/assets/'+ response[i].creatorPhoto +'"\n' +
                               '                         style="height: 6rem; width: 6rem;">\n' +
                               '\n' +
                               '                    <div class="card_details">\n' +
                               '                        <div class="info">\n' +
                               '                            <p style="float: left; margin: 0;">'+ response[i].creatorName +' &nbsp; @'+response[i].creatorUserName+' &nbsp; less than a min</p>\n' +
                               '\n' +
                               '                            <p style="float: right; margin: 0; color: cornflowerblue">'+ response[i].topicName +'</p>\n' +
                               '                        </div>\n' +
                               '\n' +
                               '                        <p>\n' +
                               '                            '+ response[i].description +'\n' +
                               '                        </p>\n' +
                               '\n' +
                               '                        <div class="card_navigator">\n' +
                               '                            <p style="float: left; margin: 0">\n' +
                               '                                <i style="color:cornflowerblue;" class="fab fa-facebook-f"></i> &nbsp; <i style="color:cornflowerblue;" class="fab fa-twitter"></i></a> &nbsp; <i style="color:cornflowerblue;" class="fab fa-google-plus-g"></i></a>\n' +
                               '                            </p>\n' +
                               '                        </div>\n' +
                               '                    </div>\n' +
                               '                </div>'
                       }else{
                           html += '<div class="card">\n' +
                               '                    <img src="/assets/'+ response[i].creatorPhoto +'"\n' +
                               '                         style="height: 6rem; width: 6rem;">\n' +
                               '\n' +
                               '                    <div class="card_details">\n' +
                               '                        <div class="info">\n' +
                               '                            <p style="float: left; margin: 0;">'+ response[i].creatorName +' &nbsp; @'+response[i].creatorUserName+' &nbsp; less than a min</p>\n' +
                               '\n' +
                               '                            <p style="float: right; margin: 0; color: cornflowerblue">'+ response[i].topicName +'</p>\n' +
                               '                        </div>\n' +
                               '\n' +
                               '                        <p>\n' +
                               '                            '+ response[i].description.substring(0,120) +'...\n' +
                               '                        </p>\n' +
                               '\n' +
                               '                        <div class="card_navigator">\n' +
                               '                            <p style="float: left; margin: 0">\n' +
                               '                                <i style="color:cornflowerblue;" class="fab fa-facebook-f"></i> &nbsp; <i style="color:cornflowerblue;" class="fab fa-twitter"></i></a> &nbsp; <i style="color:cornflowerblue;" class="fab fa-google-plus-g"></i></a>\n' +
                               '                            </p>\n' +
                               '                        </div>\n' +
                               '                    </div>\n' +
                               '                </div>'
                       }
                   }else {
                       if(response[i].description.length <= 120){
                           html += '<div class="card">\n' +
                               '                    <img src="/assets/'+ response[i].creatorPhoto +'"\n' +
                               '                         style="height: 6rem; width: 6rem;">\n' +
                               '\n' +
                               '                    <div class="card_details">\n' +
                               '                        <div class="info">\n' +
                               '                            <p style="float: left; margin: 0;">'+ response[i].creatorName +' &nbsp; @'+response[i].creatorUserName+' &nbsp; '+response[i].minsPassed+' min</p>\n' +
                               '\n' +
                               '                            <p style="float: right; margin: 0; color: cornflowerblue">'+ response[i].topicName +'</p>\n' +
                               '                        </div>\n' +
                               '\n' +
                               '                        <p>\n' +
                               '                            '+ response[i].description +'\n' +
                               '                        </p>\n' +
                               '\n' +
                               '                        <div class="card_navigator">\n' +
                               '                            <p style="float: left; margin: 0">\n' +
                               '                                <i style="color:cornflowerblue;" class="fab fa-facebook-f"></i> &nbsp; <i style="color:cornflowerblue;" class="fab fa-twitter"></i></a> &nbsp; <i style="color:cornflowerblue;" class="fab fa-google-plus-g"></i></a>\n' +
                               '                            </p>\n' +
                               '                        </div>\n' +
                               '                    </div>\n' +
                               '                </div>'
                       }else{
                           html += '<div class="card">\n' +
                               '                    <img src="/assets/'+ response[i].creatorPhoto +'"\n' +
                               '                         style="height: 6rem; width: 6rem;">\n' +
                               '\n' +
                               '                    <div class="card_details">\n' +
                               '                        <div class="info">\n' +
                               '                            <p style="float: left; margin: 0;">'+ response[i].creatorName +' &nbsp; @'+response[i].creatorUserName+' &nbsp; '+response[i].minsPassed+' min</p>\n' +
                               '\n' +
                               '                            <p style="float: right; margin: 0; color: cornflowerblue">'+ response[i].topicName +'</p>\n' +
                               '                        </div>\n' +
                               '\n' +
                               '                        <p>\n' +
                               '                            '+ response[i].description.substring(0,120) +'...\n' +
                               '                        </p>\n' +
                               '\n' +
                               '                        <div class="card_navigator">\n' +
                               '                            <p style="float: left; margin: 0">\n' +
                               '                                <i style="color:cornflowerblue;" class="fab fa-facebook-f"></i> &nbsp; <i style="color:cornflowerblue;" class="fab fa-twitter"></i></a> &nbsp; <i style="color:cornflowerblue;" class="fab fa-google-plus-g"></i></a>\n' +
                               '                            </p>\n' +
                               '                        </div>\n' +
                               '                    </div>\n' +
                               '                </div>'
                       }
                   }
               }
               $("#top_posts").html(html);
           }
       });
   },10000);
});