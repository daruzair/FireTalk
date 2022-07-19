<?php
class Loginmodel
{
    /*----------------------------setters--------------------------*/
    private $email;
    private $pass;
    private $massage;
    private $email_code;
    public function setEmailCode(String $email_code)
    {
        $this->email_code = $email_code;
    }
    public function setemail( string $email)
    {
        $this->email=$email;
    }
    public function setpass(string $pass)
    {
        $this->pass=$pass;
    }
    public function setmassage(string $massage){
        $this->massage=$massage;
    }
    /*-------------------------------getters-------------------------*/
    public function getemail()
    {
        return $this->email;
    }
    public function getpass()
    {
        return $this->pass;
    }
    public function getmassage()
    {
        return $this->massage;
    }
    public function getEmailCode()
    {
        return $this->email_code;
    }

}
?>