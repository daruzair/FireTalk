<?php
class Profilecontroller extends Homecontroller {
    //add frnd
    public function addfrnd(Profilemodel $profilemodel)
    {
        $from_id=$profilemodel->getFromId();
        $to_id=$profilemodel->getToId();
        $query="SELECT * FROM `friends_list` where from_id='$from_id' and to_id='$to_id' 
        or from_id='$to_id' and to_id='$from_id'";
        if($ta=select($query)){
            switch ($ta[0]['frend_request']){
                case 0:
                    $id=$ta[0]['id'];
                    $query="UPDATE `friends_list` SET `frend_request` = '1' WHERE `friends_list`.`id` = $id;";
                    if(update($query))
                    {
                        $profilemodel->setmassage('success');
                    }
                    else{
                        $profilemodel->setmassage('fail');
                    }
                    break;
                case 1:
                    $query="select *from `friends_list` where to_id='$to_id'";
                    if(!select($query))
                    {
                        $id=$ta[0]['id'];
                        $query="UPDATE `friends_list` SET `frend_request` = '2' WHERE `friends_list`.`id` = $id;";
                        if(update($query))
                        {
                            $profilemodel->setmassage('success');
                        }
                        else{
                            $profilemodel->setmassage('fail');
                        }
                    }else{
                        $id=$ta[0]['id'];
                        $query="UPDATE `friends_list` SET `frend_request` = '0' WHERE `friends_list`.`id` = $id;";
                        if(update($query))
                        {
                            $profilemodel->setmassage('success');
                        }
                        else{
                            $profilemodel->setmassage('fail');
                        }
                    }
                    break;
            }
        }else{
            $query="INSERT INTO `friends_list` (`id`, `from_id`, `to_id`, `frend_request`, `dated`)
             VALUES (NULL, '$from_id', '$to_id', '1', CURRENT_TIMESTAMP);";
            if(insert($query))
            {
                $profilemodel->setmassage('success');
            }
            else{
                $profilemodel->setmassage('fail');
            }
        }
    }
    public function Updatedetail(Profilemodel $profilemodel)
    {
        $value=$profilemodel->getValue();
        $id=getid($profilemodel->getemail(),$profilemodel->getpass());
        $column=$profilemodel->getColumn();
        $query="UPDATE `user` SET `$column` ='$value' WHERE `user`.`user_id` = $id;";
        if(update($query))
        {
            $profilemodel->setmassage('success');
        }else{
            $profilemodel->setmassage($query);
        }
    }
    public function uplodecover(Profilemodel $profilemodel){
        $profilemodel->setPath('Uplodes/Images/cover_pic');
        $file=$profilemodel->getFile();
        $path=$profilemodel->getPath();
        $allowedext=array("jpg","jpeg","png");
        $massage=uplodeFiles($file,$path,'image',$allowedext);
        $profilemodel->setmassage($massage);

    }
    public function uplodeprofile(Profilemodel $profilemodel){
        $profilemodel->setPath('Uplodes/Images/profile_pic');
        $file=$profilemodel->getFile();
        $path=$profilemodel->getPath();
        $allowedext=array("jpg","jpeg","png");
        $massage=uplodeFiles($file,$path,'image',$allowedext);
        $profilemodel->setmassage($massage);
    }
    public function uplodeprofiletodatabase(Profilemodel $profilemodel)
    {
        $email=$profilemodel->getemail();
        $pass=$profilemodel->getpass();
        $path='Uplodes/Images/profile_pic/'.$profilemodel->getPath();
        $user_id=getid($email,$pass);
        $query="UPDATE `userprofile` SET `profile_image`='$path' 
        ,`dated`='CURRENT_TIMESTAMP' WHERE user_id='$user_id'";

        if(update($query)){
            $query="select `profile_image` from userprofile WHERE user_id='$user_id'";
            if($table=select($query))
            {
                $profilemodel->setmassage($table[0]['profile_image']);
            }else{
                $profilemodel->setmassage("");
            }

        }else{
            $profilemodel->setmassage("");
        }
    }
    public function uplodecovertodatabase(Profilemodel $profilemodel)
    {
        $email=$profilemodel->getemail();
        $pass=$profilemodel->getpass();
        $path='Uplodes/Images/cover_pic/'.$profilemodel->getPath();
        $user_id=getid($email,$pass);
        $query="UPDATE `userprofile` SET `cover_img`='$path' 
        ,`dated`='CURRENT_TIMESTAMP' WHERE user_id='$user_id'";

        if(update($query)){
            $query="select `cover_img` from userprofile WHERE user_id='$user_id'";
            if($table=select($query))
            {
                $profilemodel->setmassage($table[0]['cover_img']);
            }else{
                $profilemodel->setmassage("");
            }

        }else{
            $profilemodel->setmassage("");
        }
    }
    public function getprofilepage(Profilemodel $profilemodel){
        $username=$profilemodel->getusername();
        $email=$profilemodel->getemail();
        $pass=$profilemodel->getpass();
        $query="select * from user inner join `userprofile` on `userprofile`.`user_id`=`user`.`user_id` 
           where `user`.`username`='$username'";
        $session_user=getusername($profilemodel->getemail(),$profilemodel->getpass());
        if($table=select($query)){
            ?>
            <div class="row">
                <div class="col-12 bannerImage ">
                    <?php
                        if($username==$session_user)
                        {
                            ?>
                            <div class="bannerForm" >
                                <form id="uplodecover" method = "post" enctype = "multipart/form-data" >
                                    <label for="bannerImage" title = "choose image" ><i class="fa fa-camera" ></i ></label >
                                    <input type = "file" name = "bannerImage" id = "bannerImage" >
                                    <button type = "submit" name = "btnbanner" >
                                        <i class="fa fa-upload" ></i >
                                    </button >
                                </form >
                            </div >
                            <?php
                        }
                    ?>
                    <div id="cover" class=" row cover">
                        <?php
                            if(!empty($table[0]['cover_img']))
                            {
                                ?><img src="<?php echo $table[0]['cover_img'];?>"/><?php
                            }
                        ?>
                    </div>
                </div>
            </div>
            <div class="row  profile-row">
                <div class="profile-pic profileImage" id="profile">
                   <?php if($username==$session_user)
                        {
                            ?>
                        <div class="profileForm" >
                            <form id="uplodeprofile" method = "post" enctype = "multipart/form-data" >
                                <label for="profileImage" title = "choose image" ><i class="fa fa-camera" ></i ></label >
                                <input type = "file" name = "profileImage" id = "profileImage" >
                                <button type = "submit" name = "btnprofile" >
                                    <i class="fa fa-upload" ></i >
                                </button >
                            </form >
                        </div >
                            <?php
                        }?>


                   <div id="profilepic">
                       <img src="<?php echo $table[0]['profile_image'];?>"/>
                   </div>
                </div>
                <div class="col-lg-12">
                    <div class="frnd-bar">
                        <div class="row">
                            <div class="offset-2 col-2">
                                <div class="row">
                                    <div class="col-12">
                                        <div  class="user-name">
                                            <?php echo $table[0]['username']?>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div>
                                            <label id="tfname"><?php echo $table[0]['first_name']?></label>
                                            <label id="tlname"> <?php echo $table[0]['last_name'] ?></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="offset-1 col-7">
                                <div class="row">
                            <?php if($username!=$session_user)
                            {
                                ?>
                                    <div id="addfriend" onclick="javascript:addfrnd(<?php echo $table[0]['user_id'] ?>)" class=" btn-profilr">
                                        <i class="fa fa-user-plus"></i>
                                        <?php
                                        $to_id=$table[0]['user_id'];
                                        $from_id=getid($_SESSION[EMAIL],$_SESSION[PASSWORD]);
                                        $query="SELECT * FROM `friends_list` WHERE `from_id`='$from_id' and to_id='$to_id'";
                                            if($t=select($query))
                                            {
                                                switch ($t[0]['frend_request']){
                                                    case 0:
                                                        echo 'Add Friend';
                                                        break;
                                                    case 1:
                                                        echo 'Cancel Request..';
                                                        break;
                                                    case 2:
                                                        echo 'UnFriend';
                                                        break;
                                                }
                                            }else{
                                                $query="SELECT * FROM `friends_list` WHERE `from_id`='$to_id' and to_id='$from_id'";
                                                if($t=select($query)) {
                                                    switch ($t[0]['frend_request']) {
                                                        case 0:
                                                            echo 'Add Friend';
                                                            break;
                                                        case 1:
                                                            echo 'Confirm Request';
                                                            break;
                                                        case 2:
                                                            echo 'UnFriend';
                                                            break;
                                                    }
                                                }else{
                                                    echo 'Add Friend';
                                                }
                                            }
                                        ?>
                                    </div>

                                    <div class=" btn-profilr ">
                                        <i class="fa fa-user-times"></i> Block
                                    </div>
                                    <div class=" btn-profilr ">
                                        <i class="fa fa- fa-commenting-o"></i> Massage
                                    </div>

                            <?php } ?>
                            <?php if($username==$session_user)
                            {
                                ?>
                                    <div class=" btn-profilr ">
                                        <i class="fa fa-edit"></i> Edit Profile
                                    </div>
                                <?php } ?>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <?php
           $query ="SELECT `first_name`, `last_name`, `username`,`email`, `address`, `district`, `gender`, `dob` FROM `user` where email='$email' and password='$pass'";
           if($table=select($query)) {

                   ?>
                   <div class="row">
                   <div class="col-12 col-lg-3">
                       <?php if($username=$session_user){
                       ?>


                       <div class="info">

                               <label class="labelli">Name</label>
                           <div>
                               <i class="fa fa-user-o"></i>
                               <label id="ifname"><?php echo $table[0]['first_name'] ?></label>
                                <label id="ilname"><?php echo $table[0]['last_name'] ?></label>

                           </div>
                               <label class="labelli">UserName</label>
                           <div>
                               <i class="fa fa-user-circle-o"></i>
                               <div id="iusername">
                                   <?php echo $table[0]['username'] ?>
                               </div>
                           </div>
                               <label class="labelli">Gender</label>
                           <div >
                               <i class="fa fa-genderless"></i>
                               <div id="igender">
                                   <?php if($table[0]['gender']==1){
                                       echo "Male";
                                   }elseif ($table[0]['gender']==2){
                                       echo "FeMale";
                                   }elseif ($table[0]['gender']==0){
                                       echo "Other";
                                   }?>
                               </div>
                           </div>
                           <label class="labelli">bio</label>
                           <div>
                               <i class="fa fa-tags"></i>
                               <div id="ibio">
                                   <div>my bio</div>
                               </div>
                           </div>
                                <label class="labelli">Email</label>
                           <div>
                               <i class="fa fa-envelope-o"></i>
                              <div id="iemail"> <?php echo $table[0]['email'] ?>
                             </div>
                           </div>
                                <label class="labelli">Date Of Birth</label>
                           <div >
                               <i class="fa fa-calendar"></i>
                               <div id="idob"><?php echo $table[0]['dob'] ?></div>
                           </div>
                                 <label class="labelli">AddressLine</label>
                           <div >
                               <i class="fa fa-map-marker"></i>
                               <div id="iaddress" >
                               <?php echo $table[0]['district'] ?>
                                   <?php echo $table[0]['address'] ?>
                                    <?php echo $table[0]['district'] ?>
                               </div>
                           </div>
                       </div>
                       <?php } ?>
                   </div>
                   <?php
               }
               ?>
                <div class="col-12 col-lg-6">
                    <input id="postlimit" type="hidden" value="15">
                    <input id="prelimit" type="hidden" value="0">
                    <div  id="user-postes">
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
                            <div class="col-12" id="allpostes">
                                <?php
                                $this->getallpost($profilemodel);
                                echo $profilemodel->getmassage();
                                ?>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <input onclick="LOADMORE()" class="btn btn-light" id="loadmore" value="Load More" type="button">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-12 col-lg-3">
                    <div class="row">
                        <div class="col-12">
                            <div class="shared_post">
                                <h5>Shared Post</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
<?php
        }
    }
    public function getallpost(Homemodel $homemodel)
    {
        if ($this->isvalid($homemodel)) {
            $this->getpost($homemodel);
        }
    }
    private function getpost(Homemodel $homemodel)
    {
        $Limit=$homemodel->getLimit();

        $query = "select `user`.`user_id`,`user`.`first_name`,`user`.`last_name`,`user`.`username`,
              `user`.`address`,`user`.`district`,`user`.`gender`,`user`.`active_user`,
              `userprofile`.`profile_image`,`postes`.`post_id`,`postes`.`post_content`,`postes`.`dated`
              from `user` inner join `userprofile` on `userprofile`.`user_id`
              =`user`.`user_id` inner join`postes` on `user`.`user_id`=`postes`.`user_id` 
              ORDER by `postes`.`post_id`DESC Limit $Limit";

        $post = '';
        if ($table = select($query)) {
            foreach ( $table as $row)
            {
                $post_id=$row['post_id'];
                $query="select count(*) as `count` from likes where  `post_id`='$post_id' and liked='1'";
                $post .= '<div class="post">
                    <div class="postTitle">
                        <div class="row">
                            <div class="col-2">
                                <a href="View/profile.php?user='.$row['username'].'"> <img src="'.$row['profile_image'].'" class="postimg"></a>
                            </div>
                            <div class="col-10">
                               <a href="View/profile.php?user='.$row['username'].'"> <div class="title">'.
                    $row["first_name"] . " " . $row["last_name"]. '
                                </div>
                                <div class="address">
                                    <i style="font-size: 0.9em; color:#c90000;padding:2px"
                                       class=""></i>'.$row["dated"].'
                                </div></a>
                            </div>
                        </div>
                    </div>
                    <div class="postbody">
                       <div class="row">
                           <div class="col-12">
                                '.$row['post_content'].'
                           </div>
                       </div>
                    </div>
                    <div class="l-c-s">
                        <div class="row">
                            <div class="col-12">          
                                <div id="likecount'.$post_id.'">';
                if($count=select($query))
                {
                    $count=$count[0]['count'];
                    if($count!=0)
                    {
                        $post.= $count;
                        $post.='<i class="black fa fa-thumbs-up"></i></div>';
                    }else{
                        $post.='</div>';
                    }
                }
                $post.='<div id="commentcount'.$post_id.'">';
                $query="select count(*) as `count` from `comments` where  `post_id`='$post_id'";
                if($count=select($query))
                {
                    $count=$count[0]['count'];
                    if($count!=0)
                    {
                        $post.= $count;
                        $post.='<i class="black fa fa-comment"></i></div>';
                    }else{
                        $post.='</div>';
                    }
                }
                $post.='<div id="sharecount'.$post_id.'">';
                $query="select count(*) as `count` from `share` where  `post_id`='$post_id'";
                if($count=select($query))
                {
                    $count=$count[0]['count'];
                    if($count!=0)
                    {
                        $post.= $count;
                        $post.='<i class="black fa fa-share-alt"></i></div>';
                    }else{
                        $post.='</div>';
                    }
                }
                $post.='</div>
                            </div>
                        </div>
                    <div class="postfotter">
                        <div class="row">
                            <div class="col-12">
                                <ul>
                                    <li onclick="javscript:likepost('.$post_id.')">
                                    <i id="like'.$post_id.'" class="';
                $homemodel->setPostId($post_id);
                switch($this->isliked($homemodel))
                {
                    case '2':
                        $post.='black fa fa-thumbs-o-up';
                        break;
                    case '1':
                        $post.='blue fa fa-thumbs-up';
                        break;
                    case '0':
                        $post.='black fa fa-thumbs-o-up';
                        break;
                }
                $post.='"></i> Like</li>
                                    <li class="comment" onclick="javascript:comment('.$post_id.')"><i class="fa fa-comment-o"></i> Comment</li>
                                    <li class="share" onclick="javascript:share('.$post_id.')"><i class="fa fa-share-alt"></i> Share</li>
                                </ul>
                            </div>
                         </div>       
                    </div>
                    <div class="commentexp" id="commentexp'.$post_id.'">
                                   <div class="row">
                                    <div id="comments'.$post_id.'" class="comments">';
                $post.=$this->getcomments($post_id);
                $post.='</div>
                               
                        </div>
                    <div class="row">
                         <div class="col-9"> <textarea placeholder="Comment Here" name="txtcomment" class="txtcomment" id="txtcomment'.$post_id.'"></textarea></div>
                         <div class="col-3"> <input type="button" id="uplodecomment" onclick="javascript:uplodecomment('.$post_id.')" value="Comment" class="btn btn-default"></div>
                   </div>
                 </div>
            </div>';

            }
            $homemodel->setmassage($post);
        }
    }
    public function uplodepost(Homemodel $homemodel){
        if ($this->isvalid($homemodel)) {
            $user_id = getid($homemodel->getemail(), $homemodel->getpass());
            $post = $homemodel->getPost();
            $query = "INSERT INTO `postes` (`post_id`, `user_id`, `post_content`, `dated`) 
        VALUES (NULL, '$user_id', '$post', CURRENT_TIMESTAMP);";
            if (!empty($post)) {
                if (insert($query)) {
                    $homemodel->setmassage('success');
                } else {
                    $homemodel->setmassage('failed');
                }
            }
        }

    }
    public function like(Homemodel $homemodel)
    {
        if ($this->isvalid($homemodel)) {
            $from_id = getid($homemodel->getemail(), $homemodel->getpass());
            $post_id = $homemodel->getPostId();
            switch ($this->isliked($homemodel)) {
                case '2':
                    $query = "INSERT INTO `likes` VALUES (NULL, '$from_id', '$post_id', '1', CURRENT_TIMESTAMP);";
                    if (insert($query)) {
                        $homemodel->setmassage('liked');
                    }
                    break;
                case '1':
                    $query = "UPDATE `likes` SET `liked`='0',`dated`=CURRENT_TIMESTAMP WHERE from_id='$from_id' and post_id='$post_id'";
                    if (update($query)) {
                        $homemodel->setmassage('unliked');
                    }
                    break;
                case '0':
                    $query = "UPDATE `likes` SET `liked`='1',`dated`=CURRENT_TIMESTAMP WHERE from_id='$from_id' and post_id='$post_id'";
                    if (update($query)) {
                        $homemodel->setmassage('liked');
                    }
                    break;
            }
        }
    }
    private function isliked(Homemodel $homemodel)
    {
        if ($this->isvalid($homemodel)) {
            $from_id = getid($homemodel->getemail(), $homemodel->getpass());
            $post_id = $homemodel->getPostId();
            $query = "select `liked` from `likes` where from_id='$from_id' and post_id='$post_id'";
            if ($result = select($query)) {
                return $result[0]['liked'];
            } else {
                return '2';
            }
        }
    }
    public  function uplodecomment(Homemodel $homemodel)
    {
        if ($this->isvalid($homemodel)) {
            $from_id = getid($homemodel->getemail(), $homemodel->getpass());
            $post_id = $homemodel->getPostId();
            $comment = $homemodel->getComment();
            $query = "INSERT INTO `comments`  VALUES (NULL, '$from_id', '$post_id', '$comment', CURRENT_TIMESTAMP);";
            if (!empty($comment)) {
                if (insert($query)) {
                    $homemodel->setmassage($this->getcomments($post_id));
                }
            }
        }
    }
    public function likecount(Homemodel $homemodel)
    {

        $post_id = $homemodel->getPostId();
        $query = "select count(*) as `count` from likes where  `post_id`='$post_id' and liked='1'";
        if ($count = select($query)) {
            $count = $count[0]['count'];
            $homemodel->setmassage($count);
        } else {
            $count = $count[0]['count'];
            $homemodel->setmassage($count);
        }

    }
    public function commentcount(Homemodel $homemodel)
    {
        $post_id=$homemodel->getPostId();
        $query="select count(*) as `count` from comments where  `post_id`='$post_id'";
        if($count=select($query))
        {
            $count=$count[0]['count'];
            $homemodel->setmassage($count);
        }else{
            $count=$count[0]['count'];
            $homemodel->setmassage($count);
        }
    }
    private function getcomments($post_id)
    {
        $query = "select `user`.`user_id`,`user`.`username`,`user`.`first_name`,`user`.`last_name`,`userprofile`.`profile_image`,`comments`.`comment` 
                from `user` inner join `userprofile` on `userprofile`.`user_id` =`user`.`user_id` 
                inner join`comments` on `comments`.`from_id`=`user`.`user_id` 
                where `comments`.`post_id`='$post_id' ORDER by `comments`.`com_id`DESC ";
        $post='';
        if ($table = select($query)) {

            foreach ($table as $row) {

                $post.='<div class="commentfrnd">
                                            <div class="col-12">
                                                <div class="row">
                                                    <div class="col-2"> 
                                                    <a href="View/profile.php?user='.$row['username'].'"><img src="';$post.= $row['profile_image'];
                $post.='"class="commentfrnd-img"></a>
                                                        
                                                    </div>
                                                   <div class="col-10">
                                                   <div class="row">
                                                    <div class="col-12">
                                                    <div class="comment-main">
                                                                <div class="com-title">';
                $post.= $row['first_name'];
                $post.=' ';
                $post.= $row['last_name'];
                $post.='</div>

                                                    <p class=" col-12 comment-body">';
                $post.=$row['comment'];
                $post.='</p></div>
                                                         
</div>
                                                       </div>
                                                   </div>
                                               </div>
                                            </div>
                                        </div>';
            }
        }
        return $post;
    }
    public function share(Homemodel $homemodel)
    {
        $user_id = getid($homemodel->getemail(), $homemodel->getpass());
        $post_id=$homemodel->getPostId();
        $query="INSERT INTO `share`  VALUES (NULL, '$user_id', '$post_id', CURRENT_TIMESTAMP);";
        if ($this->isvalid($homemodel)) {
            if (insert($query)) {
                $query = "select count(*) as `count` from `share` where `post_id`='$post_id'";
                if ($table=select($query)) {
                    $homemodel->setmassage($table[0]['count']);
                }
            }
        }
    }
}