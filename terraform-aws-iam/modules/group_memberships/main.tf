   variable "group_user_map" {
      type = map(list(string))
   }
   resource "aws_iam_group_membership" "group_memberships" {
      for_each = var.group_user_map
      group    = each.key
      users    = each.value
   }
   