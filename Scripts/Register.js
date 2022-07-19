
var fname;var lname;var uname;var email;var pass;var address;var district;var dob;var day;var month; var year;var male;var female;var other;var gender;
$('#regform').on('submit',function(e) {
    e.preventDefault();
    fname=$('#FNAME').val();
    lname=$('#LNAME').val();
    uname = $('#UNAME').val();
    day = $('#DAY').val();
    month = $('#MONTH').val();
    year = $('#YEAR').val();
    email = $('#EMAIL').val();
    pass = $('#PASS').val();
    address = $('#ADDRESS').val();
    district=$('#DISTRICT').val();
    dob="";
    male = document.getElementById("MALE");
    male = male.checked;
    female = document.getElementById("FEMALE");
    female = female.checked;
    other = document.getElementById("OTHER");
    other = other.checked;
    gender = 0;
    var upattern = /^[A-Za-z0-9]{5,15}$/;
    var fpattern = /^[A-Za-z]{2,15}$/;
    var lpattern = /^[A-Za-z]{2,15}$/;
    var ppattern = /^[A-Za-z0-9@]{8,20}$/;
    var epattern = /^[A-Za-z0-9]{}$/;
    if(fname.length===0){
        $('#Msg').html('<div class="errorMsg">Please enter firstname</div>').show();
    }else{
        if(fname.length===1){
            $('#Msg').html('<div class="errorMsg">Firstname is very short</div>').show();
        }else {
            if (!(fname.match(fpattern))) {
                $('#Msg').html('<div class="errorMsg">Firstname have A-Z and a-z charectors only</div>').show();
            } else {
                if (lname.length === 0) {
                    $('#Msg').html('<div class="errorMsg">Please enter lastname</div>').show();
                } else {
                    if (lname.length === 1) {
                        $('#Msg').html('<div class="errorMsg">Lastname is very short</div>').show();
                    } else {
                        if (!(lname.match(lpattern))) {
                            $('#Msg').html('<div class="errorMsg">Lastname have A-Z and a-z charectors only</div>').show();
                        } else {
                            if (uname.length === 0) {
                                $('#Msg').html('<div class="errorMsg">Please enter username first</div>').show();
                            } else {
                                if (uname.length < 5) {
                                    $('#Msg').html('<div class="errorMsg">username is very short it must 5 characters</div>').show();
                                } else {
                                    if (!(uname.match(upattern))) {
                                        $('#Msg').html('<div class="errorMsg">Username have only A-Z and 1-9 charectors only</div>').show();
                                    } else {
                                        if (email.length < 1) {
                                            $('#Msg').html('<div class="errorMsg">Please enter email first</div>').show();
                                        } else {
                                            if (email.length < 6) {
                                                $('#Msg').html('<div class="errorMsg">invalid email</div>').show();
                                            } else {
                                                if (pass.length < 1) {
                                                    $('#Msg').html('<div class="errorMsg">Please enter password first</div>').show();
                                                } else {
                                                    if (pass.length < 8) {
                                                        $('#Msg').html('<div class="errorMsg">password is very short it must 8 characters</div>').show();
                                                    } else {
                                                        if (!(pass.match(ppattern))) {
                                                            $('#Msg').html('<div class="errorMsg">invalid-password  these Symbols are not allowed in password #~!-$%</div>').show();
                                                        } else {
                                                            if (address.length < 1) {
                                                                $('#Msg').html('<div class="errorMsg">Please enter address first</div>').show();
                                                            } else {
                                                                if (address.length < 3) {
                                                                    $('#Msg').html('<div class="errorMsg">Address is very short it must 4 characters</div>').show();
                                                                } else {
                                                                    if (district.length < 1) {
                                                                        $('#Msg').html('<div class="errorMsg">Please enter district first</div>').show();
                                                                    } else {
                                                                        if (district.length < 2) {
                                                                            $('#Msg').html('<div class="errorMsg">District is very short</div>').show();
                                                                        }
                                                                        if (month === "" && year === "" && day === "") {
                                                                            $('#Msg').html('<div class="errorMsg">Pick your date of birth first</div>').show();
                                                                        } else {
                                                                            if (day === "") {
                                                                                $('#Msg').html('<div class="errorMsg">please Pick day first</div>').show();
                                                                            } else {
                                                                                if (month === "") {
                                                                                    $('#Msg').html('<div class="errorMsg">please Pick Month first</div>').show();
                                                                                } else {
                                                                                    if (year === "") {
                                                                                        $('#Msg').html('<div class="errorMsg">please Pick year first</div>').show();
                                                                                    } else {
                                                                                        dob = year + "-" + month + "-" + day;
                                                                                        if (male === true | female === true | other === true) {
                                                                                            if (male === true) {
                                                                                                gender = 1;
                                                                                            } else if (female === true) {
                                                                                                gender = 2;
                                                                                            } else if (other === true) {
                                                                                                gender = 3;
                                                                                            }
                                                                                            Register();
                                                                                        } else {
                                                                                            $('#Msg').html('<div class="errorMsg">enter your gender</div>').show();
                                                                                        }
                                                                                    }
                                                                                }
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
});
function Register() {
    $('#loder').show();
    $.post("Processes/Registerprocess.php",
        {

            FNAME:fname,
            LNAME:lname,
            UNAME:uname,
            EMAIL:email,
            DOB:dob,
            PASS:pass,
            ADDRESS:address,
            DISTRICT:district,
            GENDER:gender,
            REGISTER:"register"
        },
        function(s){

            s=$.trim(s);
            if(s=='<div class="Succ">Register Successfully</div>')
            {
                document.location="login.php?Succ=Register_Successfully!__Login_and_Confirm_your_Account";
            }
            $("#Msg").html(s).show();
            alert(s)
        });
    $("#loder").hide();

}
