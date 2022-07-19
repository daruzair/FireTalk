<?php
require "../Model/Loginmodel.tpl";
require '../Model/Registermodel.tpl';
require "../Config.tpl";
require "../Controller/Registercontroller.tpl";
require '../Genralfunctions/functions.tpl';
    if($_SERVER['REQUEST_METHOD']=='POST'&&isset( $_POST['REGISTER']))
    {
        if(isset($_POST['FNAME'])&&isset($_POST['LNAME'])&&isset($_POST['UNAME'])&&isset($_POST['EMAIL'])&&isset($_POST['PASS'])&&isset($_POST['ADDRESS'])&&isset($_POST['DISTRICT'])&&isset($_POST['DOB'])&&isset($_POST['GENDER']))
        {
            $rm=new Registermodel();
            $_POST=sanitise_Array($_POST);
            $_POST=remove_html_tages_array($_POST);
            $_POST=escape_string_array($_POST);
                $fname=$_POST['FNAME'];
                $lname=$_POST['LNAME'];
                $uname = $_POST['UNAME'];
                $email = $_POST['EMAIL'];
                $pass = $_POST['PASS'];
                $pass = encrypt($pass);
                $address = $_POST['ADDRESS'];
                $district=$_POST['DISTRICT'];
                $dob = $_POST['DOB'];
                $gender = $_POST['GENDER'];

                $rm->setfname($fname);
                $rm->setlname($lname);
                $rm->setuname($uname);
                $rm->setemail($email);
                $rm->setpass($pass);
                $rm->setaddress($address);
                $rm->setdistrict($district);
                $rm->setdob($dob);
                $rm->setgender($gender);
                $rc = new Registercontroller();
                $rc->Register($rm);
            }else{
                $rm->setmassage('something! wrong');
            }
            echo $rm->getmassage();


    }
?>