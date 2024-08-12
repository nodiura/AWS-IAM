   variable "policies" {
      type = map(string)
   }
   resource "aws_iam_policy" "access_policies" {
      for_each = var.policies
      name     = each.key
      policy   = each.value
   }
   