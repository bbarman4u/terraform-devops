
resource "aws_instance" "app_server" {
  ami           = local.ami_id
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}