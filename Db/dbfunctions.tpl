<?php
require 'dbcon.tpl';
    function connection()
    {
        return dbcon::con();
    }
    function insert(string $query)
    {
        if(connection())
        {
          $result=mysqli_query(connection(),$query);
          if(!empty($result))
          {
              return true;
          }
          return false;
        }
    }
    function select( string $query){
        $result=mysqli_query(connection(),$query);
        $table=array();
        if(mysqli_num_rows($result)>0)
        {
           while ($row=mysqli_fetch_assoc($result))
           {
               array_push($table,$row);
           }
           return $table;
        }
        return false;
    }
    function update( string $query){
        $result=mysqli_query(connection(),$query);
        return $result;
    }
?>