<?php
session_start();
if(!(isset($_SESSION[EMAIL])&& isset($_SESSION[PASSWORD])))
{
    header('Location: ../Login.php?Err=Login_First');
    exit();
}else {
        $_SESSION=sanitise_Array($_SESSION);
        $_SESSION=remove_html_tages_array($_SESSION);
        $e = $_SESSION[EMAIL];
        $p = $_SESSION[PASSWORD];
        $query = "SELECT * FROM `user` where email='$e' and password='$p'and active_user='1'";
        $row;
        if (!($row=select($query))) {
            session_unset();
            session_destroy();
            header('Location: ../Login.php?Err=Login_First');
            exit();
        }
        ?>
    <input id="user_id" type="hidden" value="<?php echo $row[0]['user_id']?>">
    <input id="email" type="hidden" value="<?php echo $row[0]['email']?>">
    <input id="pass" type="hidden" value="<?php echo $row[0]['password']?>">
<?php
}
?>