variable "instance_tag"{
  type =object(
    {
      name= string
      foo = number 
    }
    )
}

variable "itemlist"{
  type = list(number)
}
      
