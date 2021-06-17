provider "aws"{
  region =""
}

module "module_name"{
  source = "/"
}
  
  
output "module_var"{
  value = module.module_name.instance
    }
  
 
