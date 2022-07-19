<?php
require '../Config.tpl';
require '../Db/dbfunctions.tpl';
require '../Genralfunctions/functions.tpl';
require '../Model/Loginmodel.tpl';
require '../Model/Homemodel.tpl';
require '../Model/Profilemodel.tpl';
require '../Controller/Logincontroller.tpl';
require '../Controller/Homecontroller.tpl';
require '../Controller/Profilecontroller.tpl';

  if($_SERVER['REQUEST_METHOD']==="POST")
  {
      sanitise_Array($_POST);
      remove_html_tages_array($_POST);
      escape_string_array($_POST);
      //add friend
      if(isset($_POST['EMAIL']) && isset($_POST['PASS']) &&
          isset($_POST['PROFILE'])&& isset($_POST['TO_ID']))
      {
          if($_POST['PROFILE']='ADDFRIEND')
          {
              $pm=new Profilemodel();
              $pm->setemail($_POST['EMAIL']);
              $pm->setpass($_POST['PASS']);
              $pm->setFromId(getid($_POST['EMAIL'],$_POST['PASS']));
              $pm->setToId($_POST['TO_ID']);
              $pc = new Profilecontroller();
              $pc->addfrnd($pm);
              echo $pm->getmassage();
          }
      }
      //insertvalinfo
      if(isset($_POST['EMAIL']) && isset($_POST['PASS']) &&
          isset($_POST['PROFILE'])&&isset($_POST['VALUE'])&&isset($_POST['COLNAME']))
      {
          if($_POST['PROFILE']='insertvalinfo')
          {
              $pm=new Profilemodel();
              $pm->setemail($_POST['EMAIL']);
              $pm->setpass($_POST['PASS']);
              $pm->setValue($_POST['VALUE']);
              switch ($_POST['COLNAME']){

                  case 'ifname':
                      $pm->setColumn('first_name');
                      $pm->setmassage('success');
                      break;
                  case 'ilname':
                      $pm->setColumn('last_name');
                      $pm->setmassage('success');
                      break;
                  case 'iusername':
                      $pm->setColumn('username');
                      $pm->setmassage('success');
                      break;
                  default:
                      $pm->setmassage('fail');
                      break;

          }
          if( $pm->getmassage()=='success') {
              $pm->setValue($_POST['VALUE']);
              $pc = new Profilecontroller();
              $pc->Updatedetail($pm);
              echo $pm->getmassage();
          }elseif ( $pm->getmassage()=='fail')
              echo $pm->getmassage();
          }
      }
      //cover pic database
      if(isset($_POST['EMAIL']) && isset($_POST['PASS']) &&
          isset($_POST['PROFILE'])&&isset($_POST['PATH']))
      {
          if($_POST['PROFILE']=='UPLOADCOVER')
          {
              $path= $_POST['PATH'];
              $path=explode('~',$path);
              if(end($path)=='success') {
                  $pm = new Profilemodel();
                  $pm->setemail($_POST['EMAIL']);
                  $pm->setpass($_POST['PASS']);
                  $pm->setPath($path[0]);
                  $pc = new Profilecontroller();
                  $pc->uplodecovertodatabase($pm);
                  echo $pm->getmassage();
              }
          }
      }
      //profile pic database
      if(isset($_POST['EMAIL']) && isset($_POST['PASS']) &&
          isset($_POST['PROFILE'])&&isset($_POST['PATH']))
        {
            if($_POST['PROFILE']=='UPLOADPROFILE')
            {
               $path= $_POST['PATH'];
               $path=explode('~',$path);
                if(end($path)=='success') {
                    $pm = new Profilemodel();
                    $pm->setemail($_POST['EMAIL']);
                    $pm->setpass($_POST['PASS']);
                    $pm->setPath($path[0]);
                    $pc = new Profilecontroller();
                    $pc->uplodeprofiletodatabase($pm);
                    echo $pm->getmassage();
                }
            }
        }
        //cover pic
      if(isset($_FILES['bannerImage']))
      {
          if($_FILES['bannerImage'])
          {
              $pm=new Profilemodel();
              $pc=new Profilecontroller();
              $pm->setFile($_FILES['bannerImage']);
              $pc->uplodecover($pm);
              echo $pm->getmassage();
          }
      }
      // profile pic
      if(isset($_FILES['profileImage']))
      {
          if($_FILES['profileImage'])
          {
              $pm=new Profilemodel();
              $pc=new Profilecontroller();
              $pm->setFile($_FILES['profileImage']);
              $pc->uplodeprofile($pm);
              echo $pm->getmassage();
          }
      }
      // getallpostes
      if(isset($_POST['EMAIL']) && isset($_POST['PASS']) && isset($_POST['LIMIT']) && isset($_POST['PROFILE']))
      {
          $_POST=remove_html_tages_array($_POST);
          if($_POST['PROFILE']==="GETALLPOST")
          {
              $pm=new Profilemodel();
              $pm->setemail($_POST['EMAIL']);
              $pm->setpass($_POST['PASS']);
              $pm->setLimit($_POST["LIMIT"]);
              $pc=new Profilecontroller();
              $pc->getallpost($pm);
              echo $pm->getmassage();
          }
      }
      // Uplodepost
      if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
          && isset($_POST['POST']) && isset($_POST['PROFILE']))
      {
          if($_POST['PROFILE']==="UPLODEPOST")
          {
              $pm=new Profilemodel();
              $pm->setemail($_POST['EMAIL']);
              $pm->setpass($_POST['PASS']);
              $pm->setPost($_POST['POST']);
              $pc=new Profilecontroller();
              $pc->uplodepost($pm);
              echo $pm->getmassage();
          }

      }
     // Like
      if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
          && isset($_POST['POST_ID']) && isset($_POST['PROFILE']))
      {
          if($_POST['PROFILE']==="LIKE")
          {
              $pm=new Profilemodel();
              $pm->setemail($_POST['EMAIL']);
              $pm->setpass($_POST['PASS']);
              $pm->setPostId($_POST['POST_ID']);
              $pc=new Profilecontroller();
              $pc->like($pm);
              echo $pm->getmassage();
          }elseif ($_POST['PROFILE']==="LIKECOUNT"){
              $pm=new Profilemodel();
              $pm->setemail($_POST['EMAIL']);
              $pm->setpass($_POST['PASS']);
              $pm->setPostId($_POST['POST_ID']);
              $pc=new Profilecontroller();
              $pc->likecount($pm);
              echo $pm->getmassage();
          }

      }
     // Uplode comment
      if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
          && isset($_POST['POST_ID']) && isset($_POST['PROFILE'])&& isset($_POST['COMMENT'])){
          if($_POST['PROFILE']==='UPLODECOMMENT'){
              $pm=new Profilemodel();
              $pm->setemail($_POST['EMAIL']);
              $pm->setpass($_POST['PASS']);
              $pm->setPostId($_POST['POST_ID']);
              $pm->setComment($_POST['COMMENT']);
              $pc=new Profilecontroller();
              $pc->uplodecomment($pm);
              echo $pm->getmassage();

          }

      }
      // cpunt comment
      if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
          && isset($_POST['POST_ID']) && isset($_POST['PROFILE'])){
          if($_POST['PROFILE']==='COUNTCOMMENT'){
              $pm=new Profilemodel();
              $pm->setemail($_POST['EMAIL']);
              $pm->setpass($_POST['PASS']);
              $pm->setPostId($_POST['POST_ID']);
              $pc=new Profilecontroller();
              $pc->commentcount($pm);
              echo $pm->getmassage();

          }

      }
      //Share
      if (isset($_POST['EMAIL']) && isset($_POST['PASS'])
      && isset($_POST['POST_ID']) && isset($_POST['PROFILE']))
     {
      if($_POST['PROFILE']==="SHARE")
      {
          $pm=new Profilemodel();
          $pm->setemail($_POST['EMAIL']);
          $pm->setpass($_POST['PASS']);
          $pm->setPostId($_POST['POST_ID']);
          $pc=new Profilecontroller();
          $pc->share($pm);
          echo $pm->getmassage();
      }

  }
  }
?>