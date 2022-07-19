<?php
require '../Config.tpl';
require '../Db/dbfunctions.tpl';
require '../Genralfunctions/functions.tpl';
require '../Session/session.tpl';
require '../Model/Loginmodel.tpl';
require '../Model/Homemodel.tpl';
require '../Model/Profilemodel.tpl';
require '../Controller/Logincontroller.tpl';
require '../Controller/Homecontroller.tpl';
require '../Controller/Profilecontroller.tpl';
require '../Html/HtmlFunc.tpl';

    getheader('Profile');
?>
  <?php
  $pm=new Profilemodel();
  $pm->setemail($_SESSION[EMAIL]);
  $pm->setpass($_SESSION[PASSWORD]);
  $pm->setLimit(15);
  $pc=new Profilecontroller();
    if ($_SERVER['REQUEST_METHOD']=='GET')
    {
        if(isset($_GET['user'])){
            if(!empty($_GET['user']))
            {
                $pm->setUsername($_GET['user']);
                echo $pc->getprofilepage($pm);
            }else{
                header('Location: Profile.php');
                exit();
            }
        }else{
           $username=getusername($pm->getemail(),$pm->getpass());
           $pm->setUsername($username);
           echo $pc->getprofilepage($pm);
        }
    }
    else{
        $username=getusername($pm->getemail(),$pm->getpass());
        $pm->setUsername($username);
        echo $pc->getprofilepage($pm);
    }
  ?>
<script type="text/javascript" src="Scripts/Profile.js"></script>
<?php
    getfooter();
?>
