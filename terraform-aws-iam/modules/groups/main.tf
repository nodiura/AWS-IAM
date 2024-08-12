   variable "group_names" {
      type = list(string)
   }
   resource "aws_iam_group" "groups" {
      for_each = toset(var.group_names)
      name     = each.key
   }
   