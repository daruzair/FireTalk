<?php
    function getheader($title){
        ?>
        <html>
            <head>
                <title><?php echo TITLE.' | '. $title?></title>
                <base href="<?php echo WEBPATH ?>">
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <link href="Css/Main.css" rel="stylesheet" type="text/css">
                <script src="Scripts/jquery.js"  type="text/javascript"></script>
                <script src="Scripts/Main.js"  type="text/javascript"></script>
                <link href="Css/bootstrap.css" rel="stylesheet" type="text/css">
                <link href="Css/FontAwesome/css/font-awesome.css" rel="stylesheet" type="text/css">
            </head>
            <body class="container">
        <?php
    }
    function getfooter(){
        ?>
        </body>
        </html>
        <?php
    }
    function getloder()
    {
        ?>
            <div>
                <img src="Image/loder.gif" id="loder"></img>
            </div>
        <?php
    }
    function getdob(){?>
        <div  id="dinput">
            <select name="day" id="DAY">
                <option  value="">day</option>
                <?php
                for($i=1; $i<=31;$i++)
                { ?>
                    <option value="<?php echo $i ?>"><?php echo $i ?></option>
                <?php } ?>
            </select>
            <select name="month" id="MONTH">
                <option value="">month</option>
                <?php
                for($i=1; $i<=12;$i++)
                { ?>
                    <option value="<?php echo $i ?>"<?php $i ?>"><?php echo $i ?></option>
                <?php } ?>
            </select>
            <select name="year" id="YEAR">
                <option value="">year</option>
                <?php
                for($i=1900; $i<=2019;$i++ )
                { ?>
                    <option value="<?php echo $i ?>"><?php echo $i ?></option>
                <?php } ?>
            </select>
        </div>
        <?php
    }
    function getMsg(){
        ?>
        <div class="Msg" id="Msg"></div>
        <?php
    }
    function getnav(string $email,string $pass)
    {
        ?>
        <header class="row header">
            <div class="col-12 col-sm-2 ">
                <div class="logo"><span style="color: red;" >F</span>ire<span style="color: red">T</span>alk</div>
            </div>
            <div class="col-10 col-sm-6 ">
                <form class="search-form" method="post">
                    <div class="src-input"><input type="text" placeholder="Search"></div>
                    <div class="src-btn"><button value="Search" type="submit"><i class="fa fa-search"></i> </button></div>
                </form>
            </div>
            <div class="col-2 col-sm-4 ">
                <ul class="side-nav">
                    <li id="bar" class="bar"><a href="#"> <i class="fa fa-bars"></i></a></li>
                    <li id="msg" onclick="javascript:getmsgdfrnd()"><i class="fa fa-envelope"></i></li>
                    <li id="notify"><i class="fa fa-bell"></i></li>
                    <li id="setting" onclick="javascript:getsetting()"><i class="fa fa-gear"></i></li>
                    <li id="logout"><a href="View/logout.php"><i class="fa fa-sign-out"></i></a></li>
                    <li id="user"><a href="View/Profile.php"><img class="msg-img" src="<?php
                        $query=" select `profile_image` from `userprofile` inner join `user` on `user`.`user_id`=
                          `userprofile`.`user_id` where `user`.`email`='$email' and `user`.`password`='$pass'";
                        if($table=select($query))
                        {
                            echo $table[0]['profile_image'];
                        }?>"></a></li>
                </ul>
            </div>
        </header>
        <?php
    }
?>
