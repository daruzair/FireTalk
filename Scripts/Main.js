$(document).ready(function (e) {
    var flag=0;
    $('#eye').on('click',function (a) {

        if(flag==0) {
            document.getElementById('PASS').setAttribute("type","text");
            $('#eye').css('color','red');
            $('#eye').removeClass('fa-eye-slash');
            $('#eye').addClass('fa-eye');
            flag=1;
        }else{
            document.getElementById("PASS").setAttribute("type","password");
            $('#eye').css('color','black');
            $('#eye').removeClass('fa-eye');
            $('#eye').addClass('fa-eye-slash');
            flag=0;
        }
    });

});