<?php
require "../Config.tpl";
require "../Genralfunctions/functions.tpl";
require "../Db/dbfunctions.tpl";
require '../Session/session.tpl';
require '../Html/HtmlFunc.tpl';
require '../Genralfunctions/homefunctions.tpl';
require '../Model/Loginmodel.tpl';
require '../Model/Homemodel.tpl';
require '../Controller/Logincontroller.tpl';
require '../Controller/Homecontroller.tpl';
getheader('Home');
getnav($_SESSION[EMAIL],$_SESSION[PASSWORD]);
?>
<div class="row home-main">
    <div class="col-12 active-frnds col-lg-2"></div>
    <div class="col-12 PosterMain col-lg-6">
        <div class="row">
            <div class="col-12">
                <div class="post">
                    <textarea  placeholder="Post Here" name="txtpost" id="txtpost"></textarea>
                    <input type="button" id="uplodepost"  value="Post" class="btn btn-default">
                    <div class="postfotter" id="postMsg">
                    </div>
                </div>
            </div>
        </div>
        <div class="row ">
            <input id="postlimit" type="hidden" value="15">
            <input id="prelimit" type="hidden" value="0">
            <div class="col-12" id="allpostes">
                <?php
                  echo getallpostes(15);
                ?>
            </div>
        </div>
       <div class="row">
           <div class="col-12">
               <input onclick="LOADMORE()" class="btn btn-light" id="loadmore" value="Load More" type="button">
           </div>
       </div>
    </div>
    <div class="col-12 side-div col-lg-4">
        <input id="msglimit" type="hidden" value="25">
        <div id="side-div">

        </div>
    </div>
</div>
<script type="text/javascript" src="Scripts/Home.js"></script>
<?php
getfooter();
?>