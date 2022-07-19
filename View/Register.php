<?php
    require '../Config.tpl';
    require "../Html/HtmlFunc.tpl";
    getheader("Register");
?>
<div class="row">
    <div class="offset-4 col-4">
        <div class="reg-form">
            <h1 class="text-center"><i class="fa fa-user-plus"></i></h1>
            <?php
            echo getMsg();
            echo getloder();
            ?>
            <form  method="post" id="regform">
                <label id="lblFNAME" for="FNAME"><i class="fa fa-user-o"></i> FirstName</label>
                <label id="lblLNAME" for="LNAME"><i class="fa fa-user-o"></i> LastName</label>
                <input id="FNAME" name="FNAME" type="text" placeholder="Firstname" >
                <input id="LNAME" name="LNAME" type="text" placeholder="Lastname" >
                <label for="UNAME"><i class="fa fa-user"></i> Username</label>
                <input id="UNAME" name="UNAME" type="text" placeholder="Username" >
                <label for="EMAIL"><i class="fa fa-envelope-square"></i> Email</label>
                <input id="EMAIL" name="EMAIL" type="text" placeholder="Email" >
                <label for="PASS"><i class="fa fa-lock"></i> Password</label>
               <div class="ll" id="pass-div"> <input id="PASS" name="PASS" type="password" placeholder="Password" ><span id="eye" class="fa fa-eye-slash"></span></div>
                <label for="ADDRESS"><i class="fa fa-address-book"></i> Address</label>
                <input id="ADDRESS" name="ADDRESS" type="text" placeholder="Address" >
                <label for="DISTRICT"><i class="fa fa-address-book-o"></i> District</label>
                <input id="DISTRICT" name="DISTRICT" type="text" placeholder="District" >
                <label for="DOB"><i class="fa fa-calendar-times-o"></i> Date Of Birth</label>
                <?php
                    echo getdob();
                ?>
                <label for="GENDER"><i class="fa fa-user"></i> Gender</label>
                <br>
                    <input type="radio" checked id="MALE" name="gender" >
                    <label>male</label>
                    <input type="radio"id="FEMALE" name="gender">
                    <label >female</label>
                    <input type="radio" id="OTHER"name="gender">
                    <label >other</label>
                <br>
                <br>
                <input id="SUB_BTN" class="SUB_BTN" name="SUB_BTN" value="Register" type="submit">
            </form>
            <a href="login.php">Already have an acount?</a>
            <br>
            <a href="View/Termes.php">Term And Condition</a>
        </div>
    </div>
</div>
    <script src="Scripts/Register.js" type="text/javascript"></script>
<?php
    getfooter();
?>

