
var email;
var code;
var email;
$('#Active-form').on('submit',function (e) {
    e.preventDefault();
    email=$('#CON-EMAIL').val();
    pass=$('#PASS').val();
    code=$('#email_code').val();
    var epattern = /^[A-Za-z0-9@.]{1,30}$/;

            if(email.length < 6)
            {
                document.location="Login.php?Err=Invalid Email";
            }else
                {
                    if(!email.match(epattern))
                    {
                        document.location="Login.php?Err=Invalid Email";
                    }else
                        {
                            if(pass.length<8)
                            {
                                document.location="Login.php?Err=Password is very short it must 8 characters";
                            }else{
                                if(code.length <6 )
                                {
                                    $('#Msg').html('<div class="errorMsg">Invalid Code</div>').show();
                                }else
                                {
                                    Active();
                                }
                            }
                        }
                }
});
function  Active() {
    $('#loder').show();
    $.post("Processes/Activeprocess.php",
        {
            EMAIL:email,
            PASS:pass,
            CODE:code,
            ACTIVE:"active"
        },
        function (s) {
             s=$.trim(s);
            if(s=='success')
            {
                document.location="login.php";
            }else if(s=='<div class="errorMsg">Already Activated Account</div>')
            {
                document.location="login.php";
            }else{
                $("#Msg").html(s).show();
            }

    });
    $('#loder').hide();
}

//  Resend code

$('#resend').on('click',function (e) {
    e.preventDefault();
    email=$('#CON-EMAIL').val();
    pass=$('#PASS').val();
    var epattern = /^[A-Za-z0-9@.]{1,30}$/;

    if(email.length < 6)
    {
        document.location="Login.php?Err=Invalid Email";
    }else
    {
        if(!email.match(epattern))
        {
            document.location="Login.php?Err=Invalid Email";
        }else
        {
            if(pass.length<8)
            {
                document.location="Login.php?Err=Password is very short it must 8 characters";
            }else{
                    resend();
            }
        }
    }
});
function resend() {
   $.post("Processes/Activeprocess.php",
       {
           EMAIL:email,
           PASS:pass,
           ACTIVE:'resend'
       },function (s) {
           s=$.trim(s);
           $("#Msg").html(s).show();
       });
}