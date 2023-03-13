##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

##################################################################################
# RESOURCES
##################################################################################

# INSTANCES #
resource "aws_instance" "nginxs" {
  count                  = var.instance_count
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[(count.index % var.vpc_subnet_count)]
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  depends_on             = [module.web_app_s3]
  /*key_name               = aws_key_pair.tf-key-pair.key_name*/
  iam_instance_profile = module.web_app_s3.instance_profile.name
  user_data = templatefile("${path.module}/startup_script.tpl", {
    s3_bucket_name = module.web_app_s3.web_bucket.id
  })

  tags = local.common_tags

}




/*resource "aws_key_pair" "tf-key-pair" {
  key_name   = "tf-key-pair"
  public_key = tls_private_key.rsa.public_key_openssh
}
resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "tf-key" {
  content  = tls_private_key.rsa.private_key_pem
  filename = "tf-key-pair"
}*/
