<?php
function validateEmaill($email)
    {
        if(preg_match(PATTERN,$email)){
            return true;
        }
        return false;
    }
     function validatePassword($password)
     {
         if(strlen($password) < 8){
             return true;
         }
         return false;
    }
     function validateUsername($username)
     {
         if(strlen($username)<5){
             return true;
         }
         return false;

    }
     function validateFirstname($firstname)
     {
         if(strlen($firstname) > 2){
             return true;
         }
         return false;
     }
     function validateLastname($lastname)
     {
        if(strlen($lastname) < 2){
            return true;
        }
        return false;
    }
     function validateAddress($address)
     {
         if(strlen($address) < 3){
             return true;
         }
         return false;
    }
    function validateDistrict($district)
    {
        if(strlen($district) < 2){
            return true;
        }
        return false;
    }
    function validateGender($gender)
    {
        if($gender==''){
            return true;
        }
        return false;
    }
    function isGender($gender,$validateGender)
    {
        if(in_array($gender,$validateGender)){
            return true;
        }
        return false;
    }
     function validateDob($dob)
     {
         if($dob == ""){
             return true;
         }
         return false;
    }
