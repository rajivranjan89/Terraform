provider "aws"{
  region =""
  access-key="" 
  secret-key=""
}

# Not good practice to store secret key in state file, possible option is either passing as ENV variable or passing the key as prompt while executing the state apply command.

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}

