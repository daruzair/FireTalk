<?php
class Activecontroller extends Logincontroller
{
    public function Resend(Activemodel $activemodel){
        if($this->isvalid($activemodel))
        {
            if($this->getEmailCode($activemodel)) {
                $email = $activemodel->getemail();
                $pass=$activemodel->getpass();
                $query = "SELECT active_user FROM USER WHERE email='$email' and password='$pass'";
                if ($result=select($query)) {
                    if($result[0]['active_user']==='0')
                    {
                        if(eMail(OUREMAIL,$activemodel->getemail(),REGISTERBODY,$activemodel->getEmailCode()))
                        {
                            $activemodel->setmassage("<div class=\"Succ\">Email Code is ReSended</div>");
                        }
                    }elseif($result[0]['active_user']==='1'){
                        $activemodel->setmassage("<div class=\"errorMsg\">Your account is already activated</div>");
                    }
                }else{
                    $activemodel->setmassage("<div class=\"errorMsg\">Email/password is Incorrect</div>");
                }

            }else{
                $activemodel->setmassage("<div class=\"errorMsg\">Email/password is Incorrect</div>");
            }
        }
    }
    private function getEmailCode(Activemodel $activemodel)
    {
        $email = $activemodel->getemail();
        $query = "SELECT email_code FROM USER WHERE email='$email'";
        if ($result=select($query)) {
           $activemodel->setEmailCode($result[0]['email_code']);
           return true;
        }
        return false;
    }
    Public function Active(Activemodel $activemodel)
    {
        $activemodel->setmassage("<div class=\"errorMsg\">Enter Configration code</div>");
        if (empty($activemodel->getEmailCode())) {
            $activemodel->setmassage("<div class=\"errorMsg\">Enter Configration code</div>");
        } else {
           if( $this->isvalid($activemodel))
           {
               if($this->Auth($activemodel))
               {
                   if($this->authorize($activemodel))
                   {
                       if($activemodel->getmassage()==='verify')
                       {
                           return $this->Activate($activemodel);
                       }
                   }

               }
           }
        }
    }
    private function Activate(Activemodel $activemodel)
        {

            $email = $activemodel->getemail();
            $email_code = $activemodel->getEmailCode();
            $pass=$activemodel->getpass();
            $query = "SELECT user_id FROM USER WHERE email='$email'and password='$pass'";
            if (select($query)) {
                $query = "SELECT user_id FROM USER WHERE email='$email'and password='$pass'and email_code='$email_code'";
                if (select($query)) {
                    $query = "SELECT user_id FROM USER WHERE email='$email'and password='$pass' and email_code='$email_code'and active_user='0'";
                    if (select($query)) {
                        $query = "UPDATE `user` SET `active_user`='1' WHERE email='$email' and password='$pass' AND email_code='$email_code'";
                        if (update($query)) {
                            session_start();
                            $_SESSION[EMAIL]=$activemodel->getemail();
                            $_SESSION[PASSWORD]=$activemodel->getpass();
                            $activemodel->setmassage('success');
                            return true;
                        } else {
                            $activemodel->setmassage('<div class="errorMsg">Error in Activation</div>');
                        }
                    } else {
                        $activemodel->setmassage('<div class="errorMsg">Already Activated Account</div>');
                    }
                } else {
                    $activemodel->setmassage('<div class="errorMsg">Activation Code is incorrect</div>');
                }
            }else {
                $activemodel->setmassage('<div class="errorMsg">Incorrect Email/Password</div>');
            }
            return false;
        }
}