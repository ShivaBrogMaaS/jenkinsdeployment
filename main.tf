locals{
buc=csvdecode(file(var.filename))
}
#Create the bucket policy
resource "aws_s3_bucket" "sample_bucket" {
for_each = { for iron in local.buc : iron.bucket => iron }
bucket = each.value.bucket
#acl    = each.value.acl
#policy = file(each.value.policy)
logging {
target_bucket = each.value.bucket
target_prefix = "log/"
}
}






