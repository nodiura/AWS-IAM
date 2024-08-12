provider "aws" {
  region = "us-east-1"
}
module "users" {
  source     = "./modules/users"
  user_names = [
    "sysadmin1",
    "sysadmin2",
    "dbadmin1",
    "dbadmin2",
    "monitoruser1",
    "monitoruser2",
    "monitoruser3",
    "monitoruser4",
  ]
}
module "groups" {
  source     = "./modules/groups"
  group_names = [
    "SysAdmin",
    "DBAdmin",
    "Monitor",
  ]
}
module "group_memberships" {
  source            = "./modules/group_memberships"
  group_user_map = {
    "SysAdmin" = ["sysadmin1", "sysadmin2"],
    "DBAdmin"  = ["dbadmin1", "dbadmin2"],
    "Monitor"  = ["monitoruser1", "monitoruser2", "monitoruser3", "monitoruser4"],
  }
}
module "access_policies" {
  source = "./modules/access_policies"
  policies = {
    "SysAdminPolicy" = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = "*",
          Resource = "*",
        }
      ]
    }),
    "DBAdminPolicy" = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = "rds:*",
          Resource = "*",
        }
      ]
    }),
    "MonitorPolicy" = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = "ec2:Describe*",
          Resource = "*",
        }
      ]
    }),
  }
}