<?php
    require '../Db/dbfunctions.tpl';
    require '../includes/validation.tpl';
class Registercontroller{
    public function Register(Registermodel $user)
    {
       if($this->isvalid($user))
       {
            if($this->isauth($user))
            {
                $this->authorize($user);
            }
       }
    }
    private function isvalid(Registermodel $user)
    {
        if (!validateFirstname($user->getfname())){
            $user->setmassage("<div class=\"errorMsg\">Firstname is very short</div>");
        }else{
            if(validateLastname($user->getlname())){
                $user->setmassage("<div class=\"errorMsg\">Lastname is very short</div>");
            }else{
                if(validateUsername($user->getuname())){
                    $user->setmassage("<div class=\"errorMsg\">username is very short it must 5 characters</div>");
                }else {

                    if (!validateEmaill($user->getemail())) {
                        $user->setmassage("<div class=\"errorMsg\">invalid email</div>");
                    } else {
                        if (validatePassword($user->getpass())) {
                            $user->setmassage("<div class=\"errorMsg\">password is very short it must 8 characters</div>");
                        } else {
                            if (validateAddress($user->getaddress())) {
                                $user->setmassage("<div class=\"errorMsg\">Address is very short it must 4 characters</div>");
                            } else {
                                if (validateDistrict($user->getdistrict())) {
                                    $user->setmassage("<div class=\"errorMsg\">District is very short</div>");
                                } else {
                                    if ($user->getdob() == "") {
                                        $user->setmassage("<div class=\"errorMsg\">Pick your date of birth first</div>");
                                    } else {
                                        $validgender = array('0', '1', '2', '3');
                                        if (!isGender($user->getgender(), $validgender)) {
                                            $user->setmassage("<div class=\"errorMsg\">Unknown gender! please pick valid gender</div>");
                                        } else {
                                            if(validateGender($user->getgender()))
                                            {
                                                $user->setmassage("<div class=\"errorMsg\"></div>");
                                            } else{
                                                if ($user->getgender() == "0") {
                                                    $user->setmassage("<div class=\"errorMsg\">Pick your gender</div>");
                                                } else {
                                                    return true;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    return false;
                }
            }
        }
    }
    private function  isauth(Registermodel $user)
    {

        $uname=sanitise($user->getuname());
        $email=sanitise($user->getemail());
        $query="select username from `User` where username='$uname'";
        if(select($query))
        {
            $user->setmassage('<div class="errorMsg">Username is already exist</div>');
            return false;
        }else{
            $query="select Email from `User` where email='$email'";
            if(select($query)){
                $user->setmassage('<div class="errorMsg">Email is already registered</div>');
                return false;
            }else{
                return true;
            }

        }
    }
    private function authorize(Registermodel $user)
    {
        $fname=$user->getfname();
        $lname=$user->getlname();
        $uname=$user->getuname();
        $email=$user->getemail();
        $pass=$user->getpass();
        $address=$user->getaddress();
        $district=$user->getdistrict();
        $dob=$user->getdob();
        $gender=$user->getgender();
        $email_code=email_code($uname);
        $query="INSERT INTO `user`  VALUES (NULL, '$fname', '$lname', '$uname', '$pass', '$email', '$address', '$district', '$gender','$dob', CURRENT_TIMESTAMP,'$email_code', '0');";
        if(insert($query))
        {
            $query="select `user_id`,`gender` from `user` where email='$email' and password='$pass'";
            if($table=select($query))
            {
                $user_id=$table[0]['user_id'];
                $gender=$table[0]['gender'];
                switch ($gender)
                {
                    case '1':
                        $query="INSERT INTO `userprofile`  VALUES (NULL, 'Image/avatar.jpg','',$user_id,CURRENT_TIMESTAMP);";
                        break;
                    case '2':
                        $query="INSERT INTO `userprofile`  VALUES (NULL, 'Image/avatar-female.jpg','',$user_id,CURRENT_TIMESTAMP);";
                        break;
                    case '0':
                        $query="INSERT INTO `userprofile`  VALUES (NULL, 'Image/avatar.jpg','',$user_id,CURRENT_TIMESTAMP);";
                        break;

                }

                if(insert($query)){
                    if(eMail(OUREMAIL,$email,REGISTERBODY,$email_code)){
                        $user->setmassage("<div class=\"Succ\">Register Successfully</div>");
                    }else {
                        $user->setmassage('<div class="errorMsg">Email Code not Send</div>');
                    }
                }
            }
        }else{
            $user->setmassage('<div class="errorMsg">SomeThing! went wrong</div>');
        }
}

}
?>