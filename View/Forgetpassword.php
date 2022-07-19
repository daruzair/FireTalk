<?php
require '../Config.tpl';
require '../Db/dbfunctions.tpl';
require '../Html/HtmlFunc.tpl';
getheader('Forgetpassword')

?>
<div class="row" method="post">
    <div class="offset-4 col-4">
        <div class="Forget-pass-form">
            <h2 class="verify"> Forget Password</h2>
            <?php
            echo getMsg();
            echo getloder();
            ?>
            <form id="Forget-pass-form" method="post">
                <label for="FOR-EMAIL"><i class="fa fa-envelope-square"></i> Enter Email</label>
                <input id="FOR-EMAIL" name="FOR-EMAIL" type="text" placeholder="enter email">
                <label for="FORGET-CODE"><i class="fa fa-barcode"></i> Enter FORGET Code</label>
                <input id="FORGET-CODE" name="FORGET-CODE" type="text" placeholder="enter Forget code">
                <br>
                <br>
                <input id="SUB_BTN" name="SUB_BTN" value="Forget" type="submit">
                <br>
                <br>
                <input id="SUB_BTN" name="SUB_BTN" value="Resend" type="submit">

            </form>
        </div>
    </div>
</div>
