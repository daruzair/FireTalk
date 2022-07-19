<?php
require '../Genralfunctions/functions.tpl';
require '../Model/Loginmodel.tpl';
require '../Model/Activemodel.tpl';
require '../Controller/Logincontroller.tpl';
require '../Controller/Activecontroller.tpl';
require '../Config.tpl';
require "../Db/dbfunctions.tpl";


if($_SERVER['REQUEST_METHOD']=='POST'&& isset($_POST['ACTIVE']))
{
    $_POST = sanitise_Array($_POST);
    $_POST = remove_html_tages_array($_POST);
    $_POST= escape_string_array($_POST);

    if (isset($_POST['EMAIL']) && isset($_POST['PASS'])&& isset($_POST['CODE'])&& $_POST['ACTIVE']==='active')
    {
        $email = $_POST["EMAIL"];
        $pass = encrypt($_POST["PASS"]);
        $email_code = $_POST["CODE"];
        $am=new Activemodel();
        $am->setemail($email);
        $am->setEmailCode($email_code);
        $am->setpass($pass);
        $ac=new Activecontroller();
        $ac->Active($am);
        echo $am->getmassage();
    }elseif (isset($_POST['EMAIL']) && isset($_POST['PASS']) && $_POST['ACTIVE']==='resend') {
        $email = $_POST["EMAIL"];
        $pass = encrypt($_POST["PASS"]);
        $am=new Activemodel();
        $am->setemail($email);
        $am->setpass($pass);
        $ac=new Activecontroller();
        $ac->Resend($am);
        echo $am->getmassage();

    }
}
?>