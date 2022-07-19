<?php
    require '../Config.tpl';
    require '../Genralfunctions/functions.tpl';
    require '../Db/dbfunctions.tpl';
    require '../Model/Loginmodel.tpl';
    require '../Model/Homemodel.tpl';
    require '../Controller/Logincontroller.tpl';
    require '../Controller/Homecontroller.tpl';
    if($_SERVER['REQUEST_METHOD']=='POST')
    {
        $_POST=sanitise_Array($_POST);
        $_POST=escape_string_array($_POST);
        if(isset($_POST['EMAIL']) && isset($_POST['PASS']) && isset($_POST['LIMIT']) && isset($_POST['HOME']))
        {
            $_POST=remove_html_tages_array($_POST);
            if($_POST['HOME']==="GETALLPOST")
            {
                $hm=new Homemodel();
                $hm->setemail($_POST['EMAIL']);
                $hm->setpass($_POST['PASS']);
                $hm->setLimit($_POST["LIMIT"]);
                $hc=new Homecontroller();
                $hc->getallpost($hm);
                echo $hm->getmassage();
            }
        }
        if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
            && isset($_POST['POST']) && isset($_POST['HOME']))
        {
            if($_POST['HOME']==="UPLODEPOST")
            {
                $hm=new Homemodel();
                $hm->setemail($_POST['EMAIL']);
                $hm->setpass($_POST['PASS']);
                $hm->setPost($_POST['POST']);
                $hc=new Homecontroller();
                $hc->uplodepost($hm);
                echo $hm->getmassage();
            }

        }
        if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
            && isset($_POST['POST_ID']) && isset($_POST['HOME']))
        {
            if($_POST['HOME']==="LIKE")
            {
                $hm=new Homemodel();
                $hm->setemail($_POST['EMAIL']);
                $hm->setpass($_POST['PASS']);
                $hm->setPostId($_POST['POST_ID']);
                $hc=new Homecontroller();
                $hc->like($hm);
                echo $hm->getmassage();
            }elseif ($_POST['HOME']==="LIKECOUNT"){
                $hm=new Homemodel();
                $hm->setemail($_POST['EMAIL']);
                $hm->setpass($_POST['PASS']);
                $hm->setPostId($_POST['POST_ID']);
                $hc=new Homecontroller();
                $hc->likecount($hm);
                echo $hm->getmassage();
            }

        }
        if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
            && isset($_POST['POST_ID']) && isset($_POST['HOME'])&& isset($_POST['COMMENT'])){
            if($_POST['HOME']==='UPLODECOMMENT'){
                $hm=new Homemodel();
                $hm->setemail($_POST['EMAIL']);
                $hm->setpass($_POST['PASS']);
                $hm->setPostId($_POST['POST_ID']);
                $hm->setComment($_POST['COMMENT']);
                $hc=new Homecontroller();
                $hc->uplodecomment($hm);
                echo $hm->getmassage();

            }

        }
        if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
            && isset($_POST['POST_ID']) && isset($_POST['HOME'])){
            if($_POST['HOME']==='COUNTCOMMENT'){
                $hm=new Homemodel();
                $hm->setemail($_POST['EMAIL']);
                $hm->setpass($_POST['PASS']);
                $hm->setPostId($_POST['POST_ID']);
                $hc=new Homecontroller();
                $hc->commentcount($hm);
                echo $hm->getmassage();

            }

        }
        if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
            && isset($_POST['LIMIT']) && isset($_POST['HOME']))
        {
            if($_POST['HOME']==="GETMSGDFRND")
            {
                $hm=new Homemodel();
                $hm->setemail($_POST['EMAIL']);
                $hm->setpass($_POST['PASS']);
                $hm->setLimit($_POST['LIMIT']);
                $hc=new Homecontroller();
                $hc->getmsgdfrnd($hm);
                echo $hm->getmassage();
            }

        }
        if ( isset($_POST['HOME']))
        {
            if($_POST['HOME']==="SETTINGS")
            {
                $hm=new Homemodel();
                $hc=new Homecontroller();
                $hc->getsettings($hm);
                echo $hm->getmassage();
            }

        }
        if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
            && isset($_POST['POST_ID']) && isset($_POST['HOME']))
        {
            if($_POST['HOME']==="SHARE")
            {
                $hm=new Homemodel();
                $hm->setemail($_POST['EMAIL']);
                $hm->setpass($_POST['PASS']);
                $hm->setPostId($_POST['POST_ID']);
                $hc=new Homecontroller();
                $hc->share($hm);
                echo $hm->getmassage();
            }

        }
    }
?>