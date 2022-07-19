<?php
 class Homemodel extends Loginmodel {
     private $Post;
     private $limit;
     private $post_id;
     private $comment;
     public function getComment()
     {
         return $this->comment;
     }
     public function setComment($comment)
     {
         $this->comment = $comment;
     }
     public function setPostId($post_id)
     {
         $this->post_id = $post_id;
     }
     public function getPostId()
     {
         return $this->post_id;
     }
     public function getLimit()
     {
         return $this->limit;
     }
     public function setLimit($limit)
     {
         $this->limit = $limit;
     }
     public function getPost()
     {
         return $this->Post;
     }
     public function setPost($Post)
     {
         $this->Post = $Post;
     }
 }