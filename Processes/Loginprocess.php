<?php
    require "../Model/Loginmodel.tpl";
    require "../Controller/Logincontroller.tpl";
    require "../Db/dbfunctions.tpl";
    require "../Genralfunctions/functions.tpl";
    require "../Config.tpl";
    if($_SERVER['REQUEST_METHOD']=='POST'&& isset($_POST['LOGIN']))
    {
        if(isset($_POST['EMAIL'])&&isset($_POST['PASS'])) {
            $lm = new Loginmodel();
                    $_POST=sanitise_Array($_POST);
                    $_POST=remove_html_tages_array($_POST);
                    $_POST=escape_string_array($_POST);
                    $email = $_POST['EMAIL'];
                    $pass = $_POST['PASS'];
                    $pass=encrypt($pass);
                    $lm->setemail($email);
                    $lm->setpass($pass);
                    $lc = new Logincontroller();
                    $lc->login($lm);

            echo $lm->getmassage();
        }
    }