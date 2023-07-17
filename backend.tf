terraform {
backend "s3" {
bucket = "ramrnd"
key    = "variables.tfstate"
region = "us-east-1"
}
}