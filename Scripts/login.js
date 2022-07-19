var email;
var pass;
$('#log-forms').on('submit',function(a) {
         a.preventDefault();
         email = $('#EMAIL').val();
         pass = $('#PASS').val();
         var epattern = /^[A-Za-z0-9@.]{1,30}$/;
         var ppattern=/^[A-Za-z0-9@]{8,100}$/;
         if (email.length < 1) {
             $('#Msg').html('<div class="errorMsg">Please enter email first</div>').show();
         } else {
             if(email.length < 6)
             {
                 $('#Msg').html('<div class="errorMsg">Invalid email</div>').show();
             }else{
                 if(!email.match(epattern))
                 {
                     $('#Msg').html('<div class="errorMsg">email error in javascript</div>').show();
                 }else{
                     if(pass.length < 1)
                     {
                         $('#Msg').html('<div class="errorMsg">Please enter password first</div>').show();
                     }else{
                         if (pass.length < 8) {
                             $('#Msg').html('<div class="errorMsg">Password is very short it must 8 characters</div>').show();
                         } else {
                             if (!(pass.match(ppattern))) {
                                 $('#Msg').html('<div class="errorMsg">Invalid-password! these Symbols are not allowed in password #~!-$%</div>').show();
                             }else {
                                 Login();
                             }
                         }
                     }
                 }
             }
         }
     });
function Login() {
    $('#loder').show();
    $.post("Processes/Loginprocess.php",
        {
            EMAIL:email,
            PASS:pass,
            LOGIN:"login"
        },
        function(s){
            s=$.trim(s);
            if(s=='success')
            {
                document.location="View/Home.php";
            }else if(s=='verify'){
                document.location="View/Active.php?email="+email+'&&pass='+pass;
            }else
             {
                $("#Msg").html(s).show();
            }
        });
    $('#loder').hide();

}