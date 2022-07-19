<?php
require '../Genralfunctions/functions.tpl';
require '../Db/dbfunctions.tpl';
require '../Config.tpl';
require '../Html/HtmlFunc.tpl';
getheader("Active");
    if($_SERVER['REQUEST_METHOD']=='POST')
    {
        header('Location: ../login.php');
        exit();
    }else if($_SERVER['REQUEST_METHOD']=='GET')
    {
        if(isset($_GET['email']) && isset($_GET['email_code']))
        {
            $_GET=sanitise_Array($_GET);
            $_GET=remove_html_tages_array($_GET);
            $email=$_GET["email"];
            $email_code=$_GET["email_code"];
            $query="SELECT * FROM USER WHERE email='$email'and email_code='$email_code'";
            if(select($query))
            {
                $query="SELECT * FROM USER WHERE email='$email'and email_code='$email_code'and active_user='0'";
                if(select($query))
                {
                    $query="UPDATE `user` SET `active_user`='1' WHERE email='$email' AND email_code='$email_code'";
                    if(update($query))
                    {
                        header('Location: ../Login.php?Succ=Your_Account_is_Activated!_Now_Login_And_Enjoy!');
                        exit();
                    }else{
                        header('Location: ../Login.php?Err=Error_in_Activation');
                        exit();
                    }
                }
                else{
                    header('Location: ../Login.php?Err=Already_Activated_Account');
                    exit();
                }
            }else{
                header('Location: ../Login.php?Err=Activation_Code/Email_is_incorrect');
                exit();
            }

        }else if(isset($_GET['email'])&&isset($_GET['pass'])) {
            $email=$_GET['email'];
            $pass=$_GET['pass'];
                ?>
                <div class="row" method="post">
                    <div class="offset-4 col-4">
                        <div class="Active-form">
                            <h2 class="verify"> Verify Your Account</h2>
                            <?php
                            echo getMsg();
                            echo getloder();
                            ?>
                            <form id="Active-form" method="post">
                                <input id="CON-EMAIL" value="<?php echo $email?>" name="CON-EMAIL" type="hidden"">
                                <input id="PASS" name="PASS" value="<?php echo $pass?>" type="hidden">
                                <label for="email_code"><i class="fa fa-barcode"></i> Enter Activation Code</label>
                                <input id="email_code" name="CON-ACTIVATE" type="text" placeholder="enter activation code">
                                <br>
                                <br>
                                <input id="SUB_BTN" class="SUB_BTN" name="SUB_BTN" value="Activate" type="submit">
                                <br>
                                <br>
                                <input id="resend" class="SUB_BTN" name="SUB_BTN" value="Resend" type="button">

                            </form>
                        </div>
                    </div>
                </div>
                <script src="Scripts/Active.js" type="text/javascript"></script>
                <?php

        }else{
            header('Location: ../login.php');
            exit();
        }
    }else{
        header('Location: ../login.php');
        exit();
    }
?>
<?php
getfooter();
?>
