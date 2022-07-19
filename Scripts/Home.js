$(document).ready(function (e) {

});
var email;var pass; var post; var limit;
email=$('#email').val();
pass=$('#pass').val();
function getposts() {
    limit=$('#postlimit').val();
    var prelimit= $('#prelimit').val();
    limit=prelimit+','+limit;
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            LIMIT:limit,
            HOME:'GETALLPOST'
        },function (s) {
            s=$.trim(s);
            s= $('#allpostes').html()+s;
            $('#allpostes').html(s);
        });
}
function getAllpost() {
    limit=$('#postlimit').val();
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            LIMIT:limit,
            HOME:'GETALLPOST'
        },function (s) {
            s=$.trim(s);
            $('#allpostes').html(s);
        });
}
function getmsgdfrnd(){
    limit=$('#msglimit').val();
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            LIMIT:limit,
            HOME:'GETMSGDFRND'
        },function (s) {
            s=$.trim(s);
            $('.side-nav').children().removeAttr('style');
            $('#msg').css('color','blue');
            $('#side-div').html(s);
        });

}
function getsetting(){
    $.post('Processes/Homeprocess.php',
        {
            HOME:'SETTINGS'
        },function (s) {
            s=$.trim(s);
            $('.side-nav').children().removeAttr('style');
            $('#setting').css('color','blue');
            $('#side-div').html(s);
        });

}
$('#uplodepost').on('click',function (a) {
    a.preventDefault();
    $('#postlimit').val('20');
    $('#prelimit').val('0');
    post=$('#txtpost').val();
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST:post,
            HOME:'UPLODEPOST'
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
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            HOME:'LIKE'
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
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            HOME:'LIKECOUNT'
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
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            COMMENT:comment,
            HOME:'UPLODECOMMENT',
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
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            HOME:'COUNTCOMMENT',
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
function share(post_id)     {
    $.post('Processes/Homeprocess.php',
        {
            EMAIL:email,
            PASS:pass,
            POST_ID:post_id,
            HOME:'SHARE',
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