<?php
class Profilemodel extends Homemodel {
    private $username;
    private $file;
    private $path;
    private $value;
    private $column;
    private $from_id;
    private $to_id;

    public function setToId($to_id)
    {
        $this->to_id = $to_id;
    }
    public function setFromId($from_id)
    {
        $this->from_id = $from_id;
    }
    public function getToId()
    {
        return $this->to_id;
    }
    public function getFromId()
    {
        return $this->from_id;
    }
    public function setColumn($column)
    {
        $this->column = $column;
    }
    public function getColumn()
    {
        return $this->column;
    }
    public function setValue($value)
    {
        $this->value = $value;
    }
    public function getValue()
    {
        return $this->value;
    }
    public function setPath($path)
    {
        $this->path = $path;
    }
    public function getPath()
    {
        return $this->path;
    }
    public function setFile($file)
    {
        $this->file = $file;
    }
    public function getFile()
    {
        return $this->file;
    }
    public function setUsername($username)
    {
        $this->username = $username;
    }
    public function getUsername()
    {
        return $this->username;
    }

}