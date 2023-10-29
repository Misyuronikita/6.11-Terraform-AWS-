provider "aws" {
}

#----------------------
# USERS
#----------------------
resource "aws_iam_user" "user_names" {
  count = length(var.user_names)
  name  = var.user_names[count.index]
}

#----------------------
# ACCESS KEYS
#----------------------
resource "aws_iam_access_key" "user_keys" {
  count = length(aws_iam_user.user_names)
  user  = aws_iam_user.user_names[count.index].name
}

#----------------------
# DATA
#----------------------
data "aws_iam_policy_document" "user-policy-data1" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:StartInstances",
      "ec2:StopInstances"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "user-policy-data2" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
}

#----------------------
# POLICY DESCRIPTIONS
#----------------------
resource "aws_iam_group_policy" "developers" {
  name   = "developers-policy"
  policy = data.aws_iam_policy_document.user-policy-data1.json
  group  = aws_iam_group.developers.name
}

resource "aws_iam_group_policy" "devopses" {
  name   = "devopses-policy"
  policy = data.aws_iam_policy_document.user-policy-data2.json
  group  = aws_iam_group.devopses.name
}

#----------------------
# GROUPS
#----------------------
resource "aws_iam_group" "developers" {
  name = "Developers-Group-Innowise"
}

resource "aws_iam_group" "devopses" {
  name = "DevOps-Group-Innowise"
}

#----------------------
# MEMBERSHIPS
#----------------------
resource "aws_iam_group_membership" "developers" {
  name = "group-membership-developers"

  users = var.developers_group[*]

  group = aws_iam_group.developers.name
}

resource "aws_iam_group_membership" "devopses" {
  name = "group-membership-devopses"

  users = var.devopses_group[*]

  group = aws_iam_group.devopses.name
}
