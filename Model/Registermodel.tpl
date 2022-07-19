<?php
    class Registermodel extends Loginmodel
    {
        private $fname;
        private $lname;
        private $uname;
        private $address;
        private $district;
        private $dob;
        private $gender;

        /*------------------------------------setters----------------------------------*/
        public function setfname(string $fname){
            $this->fname=$fname;
        }
        public function setlname(string $lname){
            $this->lname=$lname;
        }
        public function setuname(string $uname)
        {
            $this->uname = $uname;
        }
        public function setaddress(string $address)
        {
            $this->address = $address;
        }
        public function setdistrict(string  $district){
            $this->district=$district;
        }
        public function setdob(string $dob)
        {
            $this->dob = $dob;
        }
        public function setgender(string $gender)
        {
            $this->gender = $gender;
        }
        /*--------------------------------------getters----------------------*/
        public function getfname(){
            return $this->fname;
        }
        public function getlname(){
            return $this->lname;
        }
        public function getuname()
        {
            return $this->uname;
        }
        public function getaddress()
        {
            return $this->address;
        }
        public function getdob()
        {
            return $this->dob;
        }
        public function getgender()
        {
            return $this->gender;
        }
        public function getdistrict(){
            return $this->district;
        }
    }
    ?>