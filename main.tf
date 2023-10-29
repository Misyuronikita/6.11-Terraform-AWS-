provider "aws" {
}

#----------------------
# USERS
#----------------------
resource "aws_iam_user" "user1-1" {
  name = "Givi"
}

resource "aws_iam_user" "user1-2" {
  name = "Selin"
}


resource "aws_iam_user" "user2-1" {
  name = "Slavik"
}

resource "aws_iam_user" "user2-2" {
  name = "Rita"
}

#----------------------
# ACCESS KEYS
#----------------------
resource "aws_iam_access_key" "user-key1-1" {
  user = aws_iam_user.user1-1.name
}

resource "aws_iam_access_key" "user-key1-2" {
  user = aws_iam_user.user1-2.name
}

resource "aws_iam_access_key" "user-key2-1" {
  user = aws_iam_user.user2-1.name
}

resource "aws_iam_access_key" "user-key2-2" {
  user = aws_iam_user.user2-2.name
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

  users = [
    aws_iam_user.user1-1.name,
    aws_iam_user.user1-2.name
  ]

  group = aws_iam_group.developers.name
}

resource "aws_iam_group_membership" "devopses" {
  name = "group-membership-devopses"

  users = [
    aws_iam_user.user2-1.name,
    aws_iam_user.user2-2.name
  ]

  group = aws_iam_group.devopses.name
}
