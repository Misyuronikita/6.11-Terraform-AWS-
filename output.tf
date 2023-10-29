output "user_arns" {
  value = aws_iam_user.user_names[*].arn
}

output "group-developers" {
  value = aws_iam_group.developers.arn
}

output "group-devopses" {
  value = aws_iam_group.devopses.arn
}
