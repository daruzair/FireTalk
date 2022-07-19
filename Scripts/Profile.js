var email;var pass; var post; var limit; var form;
email=$('#email').val();
pass=$('#pass').val();
function getposts() {
    limit=$('#postlimit').val();
    var prelimit= $('#prelimit').val();
    limit=prelimit+','+limit;
    $.post('Processes/Profileprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            LIMIT:limit,
            PROFILE:'GETALLPOST'
        },function (s) {
            s=$.trim(s);
            s= $('#allpostes').html()+s;
            $('#allpostes').html(s);
        });
}
$('#uplodecover').on('submit',function(a) {
    a.preventDefault();
    form=$('#uplodecover')[0];
    var bi=$('#bannerImage').val();
    var data = new FormData(form);
    if(bi!=='') {
        $.ajax({
            url: "Processes/Profileprocess.php",
            type: "POST",
            data: data,
            enctype: "multipart/form-data",
            processData: false,
            contentType: false,
            success: function (s) {
                s = $.trim(s);
                $.post("Processes/Profileprocess.php",{
                        EMAIL:email,
                        PASS:pass,
                        PATH:s,
                        PROFILE:'UPLOADCOVER'
                    },function (t) {
                        if(t!='') {
                            t = $.trim(t);
                            t = '<img src="' + t + '"/>';
                            $('#cover').html(t);
                        }
                    }
                );
            }
        });
        $('#bannerImage').val('');
    }
});
$('#uplodeprofile').on('submit',function (a) {
    a.preventDefault();
    form=$('#uplodeprofile')[0];
    var data = new FormData(form);
    var bi=$('#profileImage').val();
    if(bi!=='') {
        $.ajax({
            url: "Processes/Profileprocess.php",
            type: "POST",
            data: data,
            enctype: "multipart/form-data",
            processData: false,
            contentType: false,
            success: function (s) {
                s = $.trim(s);
                $.post("Processes/Profileprocess.php", {
                        EMAIL: email,
                        PASS: pass,
                        PATH: s,
                        PROFILE: 'UPLOADPROFILE'
                    }, function (t) {
                    alert(t);
                        if (t != '') {
                            t = $.trim(t);
                            t = '<img src="' + t + '"/>';
                            $('#profilepic').html(t);
                        }
                    }
                );
            },
                error:function f() {
                    alert(s);
                }

        });
        $('#profileImage').val('');
    }
});
$('#uplodepost').on('click',function (a) {
    a.preventDefault();
    $('#postlimit').val('20');
    $('#prelimit').val('0');
    post=$('#txtpost').val();
    $.post('Processes/Profileprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST:post,
            PROFILE:'UPLODEPOST'
        },function (s) {
            s=$.trim(s);
            if(s==="success")
            {
                s="<div class=\"Succ\">Posted Successfullly!</div>";
                $('#postMsg').show();
                $('#postMsg').html(s).fadeOut(1500);
                $('#txtpost').val("");
                getAllpost();
            }else if(s==="failed"){
                s="<div class=\"errorMsg\">Post Failed to uplode</div>"
                $('#postMsg').show();
                $('#postMsg').html(s).fadeOut(1500);
            }

        });
});
function likepost(post_id) {
    $.post('Processes/Profileprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            PROFILE:'LIKE'
        },function (s) {
            s=$.trim(s);
            if(s=='liked')
            {
                $('#like'+post_id).removeClass('black fa-thumbs-o-up');
                $('#like'+post_id).addClass('blue fa-thumbs-up');
            }else if(s=='unliked'){

                $('#like'+post_id).removeClass('blue fa-thumbs-up');
                $('#like'+post_id).addClass('black fa-thumbs-o-up');
            }
            likecount(post_id);
        });

}
function likecount(post_id) {
    $.post('Processes/Profileprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            PROFILE:'LIKECOUNT'
        },function (s) {
            s=$.trim(s);
            if(s=='0') {
                $('#likecount' + post_id).html("");

            }else {
                s+='<i class="black fa fa-thumbs-up">';
                $('#likecount' + post_id).html(s);
            }
        });
}
var flag=0;
function  comment(postid) {
    var commentext='#commentexp'+postid;
    if(flag==0){
        flag=commentext;
        $(commentext).slideDown(200);
        $('#txtcomment'+postid).focus();
    }else if(flag==commentext){
        $(commentext).slideUp(200);
        flag=0;
    }else{
        $(flag).slideUp(200);
        $(commentext).slideDown(200);
        flag=commentext;
    }


}
function LOADMORE(){
    var prelimit;
    var limit= $('#postlimit').val();
    prelimit=limit;
    limit=parseInt(limit);
    limit=limit+10;
    $('#postlimit').val(limit);
    $('#prelimit').val(prelimit);
    getposts();
}
function uplodecomment(post_id) {
    var comment=$('#txtcomment'+post_id).val();
    $.post('Processes/Profileprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            COMMENT:comment,
            PROFILE:'UPLODECOMMENT',
        },function (s) {
            s = $.trim(s);
            if(s!=='')
            {
                countcomment(post_id);
                $('#comments'+post_id).html(s);
            }

        });

}
function countcomment(post_id) {
    $.post('Processes/Profileprocess.php', {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            PROFILE:'COUNTCOMMENT',
        },function (s) {
            s = $.trim(s);
            if(s=='0') {
                $('#commentcount' + post_id).html("");
            }else {
                s+='<i class="black fa fa-comment">';
                $('#commentcount' + post_id).html(s);
            }
            $('#txtcomment'+post_id).val("");
        });

}
function share(post_id) {
    $.post('Processes/Profileprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            PROFILE:'SHARE',
        },function (s) {
            s = $.trim(s);
            s = $.trim(s);
            if(s=='0') {
                $('#sharecount' + post_id).html("");
            }else {
                s+='<i class="black fa fa-share-alt">';
                $('#sharecount' + post_id).html(s);
            }
        });
}
var id; var textarear_obj; var secondval;var value
$('.info>div').children().on('dblclick',function (a) {
    id=$(this).attr('id');
    if(!(id=='iemail'|| id=='igender' || id=='idob' || id=='iaddress')) {
    value=$(this).text();
    textarear_obj=$(this).html('<textarea  id="edit-area"></textarea>');
    value=$.trim(value);
        $('#edit-area').val(value);
        $('#edit-area').focus();
        $('#edit-area').select();
        $('#edit-area').on('blur', function (a) {
            secondval = $('#edit-area').val();
            if (secondval != value) {
                insertvalinfo(id);
            } else {
                textarear_obj.text(value);
            }

        });
    }
});
function insertvalinfo(id) {
    var  value=secondval;
    $.post("Processes/Profileprocess.php",
    {
        EMAIL:email,
        PASS:pass,
        VALUE:value,
        COLNAME:id,
        PROFILE:'insertvalinfo'
    },
        function (s) {
        s=$.trim(s);
            if(s=='success')
            {
                textarear_obj.text(secondval);
                if(id='tfname') {
                    $('#tfname').text($('#ifname').text());
                }else if(id='tlname'){
                    $('#tlname').text($('#ilname').text());
                }

            }else if(s=='fail')
            {

                textarear_obj.text(value);
            }
        })
}
function getAllpost() {
    limit=$('#postlimit').val();
    $.post('Processes/Profileprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            LIMIT:limit,
            PROFILE:'GETALLPOST'
        },function (s) {
            s=$.trim(s);
            if(s!=='') {
                $('#allpostes').html(s);
            }
        });
}
//addfriend
function addfrnd(to_id) {

    $.post('Processes/Profileprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            TO_ID:to_id,
            PROFILE:'ADDFRIEND'
        },function (s) {
            s=$.trim(s);
            alert(s);
        });
};

