<?php
class Logincontroller
{
    public function login(Loginmodel $loguser)
    {
        if($this->isvalid($loguser))
        {
            if($this->auth($loguser))
            {
                $this->authorize($loguser);
            }
        }
    }
    protected function isvalid( Loginmodel $loguser)
    {
        if(empty($loguser->getemail()))
        {
            $loguser->setmassage("<div class=\"errorMsg\">Please Enter Email</div>");
        }else {
            if (strlen($loguser->getemail()) < 5) {
                $loguser->setmassage("<div class=\"errorMsg\">Email is very short it must atleast 5 characters</div>");
            } else {
                if (!preg_match(PATTERN, $loguser->getemail())) {
                    $loguser->setmassage("<div class=\"errorMsg\">Invalid Email Please Check And Try Again</div>");
                } else {
                    if(empty($loguser->getpass())){
                        $loguser->setmassage("<div class=\"errorMsg\">Please Enter Password</div>");
                    }else {
                        if (strlen($loguser->getpass()) < 8) {
                            $loguser->setmassage("<div class=\"errorMsg\">password is very short it must 8 characters</div>");
                        } else {
                            return true;
                        }
                    }
                }
            }
        }
       return false;
    }
    protected function auth(Loginmodel $loguser)
    {
        $email=$loguser->getemail();
        $pass=$loguser->getpass();
        $query="select user_id from user where email='$email' and password='$pass'";
        if(select($query)){
            return true;
        }else{
            $loguser->setmassage('<div class="errorMsg">Incorrect Email/Password</div>');
            return false;
        }
    }
    protected function authorize(Loginmodel $loguser)
    {
        $email=$loguser->getemail();
        $pass=$loguser->getpass();
            $query="select active_user from user where email='$email' and password='$pass'";
        if($result=select($query)){
           $active_user= $result[0]['active_user'];
           switch ($active_user){
               case'0':
                   $loguser->setmassage('verify');
                   break;
               case'1':
                   session_start();
                   $_SESSION[EMAIL]=$loguser->getemail();
                   $_SESSION[PASSWORD]=$loguser->getpass();
                   $loguser->setmassage('success');
                   break;
               case'2':
                   $loguser->setmassage('<div class="errorMsg">Your Account is Disabled</div>');
                   break;
               default:
                   $loguser->setmassage('<div class="errorMsg">Sorry! SomeThing is Wrong</div>');
                   break;
           }

        }else{
            $loguser->setmassage('<div class="errorMsg">Incorrect Email/Password</div>');
        }
        return true;

    }

}