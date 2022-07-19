<?php
    class dbcon
    {
        static function con()
        {
           $con=mysqli_connect(DBHOST,DBUSER,DBPASS,DBNAME);
           if(!mysqli_errno($con))
           {
               return $con;
           }
           return false;
        }
    }
?>