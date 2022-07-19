<?php
class Homecontroller extends Logincontroller
{
    public function getmsgdfrnd(Homemodel $homemodel){
        $post='
        <div class="row">
            <div class="msg_frnds">
                <div class="col-12">
                    <div class="row">
                        <div class="col-3">
                            <a href=""><img src="Uplodes/Images/huzaif.jpg" class="msg-img"></a>
                        </div>
                        <div class="col-7">
                            <div class="title">
                                huzaif
                            </div>
                            <div class="address">
                                <i style="font-size: 0.8em" class="fa fa-map-marker"></i> hmt zainakote
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        ';
        $homemodel->setmassage($post);
    }
    public  function  getsettings(Homemodel $homemodel)
    {
        $homemodel->setmassage('<div>Settings</div>');
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
                               <a href="View/profile.php?username='.$row['username'].'"> <div class="title">'.
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
        $query = "select `user`.`user_id`,`user`.`first_name`,`user`.`last_name`,`userprofile`.`profile_image`,`comments`.`comment` 
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
                                                    <a href="View/profile.php?user='.$row['user_id'].'"><img src="';$post.= $row['profile_image'];
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