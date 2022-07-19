<?php
require '../Config.tpl';
session_start();
if(isset($_SESSION[EMAIL])&&isset($_SESSION[PASSWORD])){
        session_unset();
        session_destroy();
        header('Location: ../login.php?Err=Logout_Successfully');
        exit();
}else{
    header('Location: View/Home.php');
    exit();
}

