terraform {
  backend "s3" {
    bucket         = "new-tetris-bucket-123456789012"
    region         = "us-east-1"
    key            = "Chatbot-UI/EKS-TF/terraform.tfstate"
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
}
