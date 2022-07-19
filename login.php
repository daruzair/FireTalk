<?php
    require 'Config.tpl';
    require 'Db/dbfunctions.tpl';
    require 'Html/HtmlFunc.tpl';
    require 'Genralfunctions/functions.tpl';
    getheader('Login');
?>
<div class="row">
    <div class="offset-xl-4 col-4" >
        <div class="log-form">
            <div id="user-circle" class="text-center"><i class="fa fa-user-circle-o"></i></div>
            <?php
            session_start();
            echo getloder();
            if(isset($_SESSION[EMAIL])&& isset($_SESSION[PASSWORD])){
                $e = $_SESSION[EMAIL];
                $p = $_SESSION[PASSWORD];
                $query = "SELECT * FROM `user` where email='$e' and password='$p'and active_user='1'";
                if((select($query))) {
                    header('Location: View/home.php');
                    exit();
                }
            }
            if($_SERVER['REQUEST_METHOD']=='GET')
            {
                $_GET=sanitise_Array($_GET);
                $_GET=remove_html_tages_array($_GET);
                $_GET=escape_string_array($_GET);
                if(isset($_GET['Err'])) {
                    $_GET['Err']=str_replace('_',' ',$_GET['Err']);
                    $_GET['Err']=str_replace('!','<br>',$_GET['Err']);
                    ?>
                    <div class="Msg" id="Msg"><div class="errorMsg" id="errorMsg"><?php echo $_GET['Err']; ?> </div></div>
                    <?php
                } if (isset($_GET['Succ'])){
                $_GET['Succ']=str_replace('_',' ',$_GET['Succ']);
                $_GET['Succ']=str_replace('!','<br>',$_GET['Succ']);
                    ?>
                    <div class="Msg" id="Msg">
                        <div class="Succ" id="errorMsg"><?php echo $_GET['Succ']; ?></div>
                    </div>
                    <?php
                 }if(!isset($_GET['Err']) || !isset($_GET['Succ']))
                    {
                        echo getMsg();

                    }
            }
             ?>

            <form id="log-forms" method="post">
                <label for="EMAIL"><i class="fa fa-envelope-square"></i> Email</label>
                <input id="EMAIL" name="EMAIL" type="text" placeholder="Email" >
                <label for="PASS"><i class="fa fa-lock"></i> Password</label>
                <div id="pass-div"> <input id="PASS" name="PASS" type="password" placeholder="Password" ><span id="eye" class="fa fa-eye-slash"></span></div>
                <br>
                <input id="SUB_BTN" class="SUB_BTN" name="SUB_BTN"  value="Login" type="submit">
                <input type="checkbox" id="chk">
                <span>Remember Password</span>
            </form>
            <a href="View/Forgetpassword.php">Forget Your Password</a>
            <br>
            <a href="View/Register.php">Create an account</a>
        </div>
    </div>
</div>
<script src="Scripts/login.js" type="text/javascript"></script>
<?php
getfooter();
?>