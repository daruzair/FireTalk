<?php
function sanitise($value)
{
    $value=stripslashes($value);
    $value=trim($value);
    $value=str_replace('`','',$value);
    $value=str_replace('#','',$value);
    return $value;
}
function sanitise_Array(array $value_arr)
{
    $arr=array();
    foreach($value_arr as $key=>$value)
    {
        $value = stripslashes($value);
        $value = trim($value);
        $value = str_replace('`', '', $value);
        $value = str_replace('#', '', $value);
        $arr=$arr+array($key=>$value);
    }
    return $arr;
}
function remove_html_tages_array(array $value_arr)
{
    $arr=array();
    foreach ($value_arr as $key=>$value)
    {
        $value=strip_tags($value);
        $arr=$arr+array($key=>$value);
    }
    return $arr;
}
function remove_html_tages($value)
{
    return strip_tags($value);
}
function escape_string(string $value){
    return mysqli_real_escape_string(connection(),$value);
}
function escape_string_array(array $value){
    $result=array();
    foreach ($value as $key=>$val) {
        $val= mysqli_real_escape_string(connection(),$val);
        $result=$result+array($key=>$val);
    }
    return $result;
}
function encrypt($value)
{
    for($i=0;$i<60;$i++)
    {
        $value=base64_encode(md5(sha1($value)));
    }
    return $value;
}
function email_code(string $username)
{
    return md5($username.microtime());
}
function eMail(string $from,string $to,string $body,string $email_code)
{
    return true;
   //"http:/".WEBPATH."/view/Active.php?email=$to&&email_code=$email_code";
    //mail($from,$to,$body);
}
function getid(string $email,string $pass)
{
    $query="select user_id from `user` where email='$email' and password='$pass' and active_user='1'";
    if($row=select($query)){
        return $row[0]['user_id'];
    }else{
        return false;
    }
}
function getusername(string $email,string $pass)
{
    $query="select username from `user` where email='$email' and password='$pass' and active_user='1'";
    if($row=select($query)){
        return $row[0]['username'];
    }else{
        return false;
    }
}
function uplodeFiles(array $file,string $path,string $type,array $allowed_extention){
    $type=strtolower($type);
    $filename=$file['name'];
    $filename=explode('.',$filename);
    $fileext=end($filename);
    $fileext=strtolower($fileext);
    $filesize=$file['size'];
    $tem_name=$file['tmp_name'];
    $error=$file['error'];
    $file_type=$file['type'];
    $file_type=strtolower($file_type);
    $file_type=explode('/',$file_type);
    $file_type=$file_type[0];
    $filename=$filename[0];
    $filename=$filename.'.'.uniqid("",true);
    $filename=$filename.'.'.$fileext;

    if(in_array($fileext,$allowed_extention)){
        if($filesize<8000000)
        {
            if($error==0)
            {
                if($file_type===$type)
                {
                    $destination='../'.$path.'/'.$filename;
                    if(move_uploaded_file($tem_name,$destination))
                    {
                        $massage=$filename.'~success';
                    }else{
                        $massage='failed to upload';
                    }
                }else{
                    $massage='you need to upload proper file type';
                }
            }else{
                $massage='failed to upload error='.$error;
            }
        }else{
            $massage='file size is too big';
        }

    }else{
        $massage='you need to upload proper file type';
    }
    return $massage;
}
?>