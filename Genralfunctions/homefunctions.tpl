<?php
function getallpostes($limit)
{
    $hm=new Homemodel();
    $hm->setemail($_SESSION[EMAIL]);
    $hm->setpass($_SESSION[PASSWORD]);
    $hm->setLimit($limit);
    $hc=new Homecontroller();
    $hc->getallpost($hm);
    return$hm->getmassage();
}