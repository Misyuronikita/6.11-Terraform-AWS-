output "arn-1-1" {
  value = aws_iam_user.user1-1.arn
}

output "arn-1-2" {
  value = aws_iam_user.user1-2.arn
}

output "arn-2-1" {
  value = aws_iam_user.user2-1.arn
}

output "arn-2-2" {
  value = aws_iam_user.user2-2.arn
}

output "group-developers" {
  value = aws_iam_group.developers.arn
}

output "group-devopses" {
  value = aws_iam_group.devopses.arn
}
