# Create IAM user
resource "aws_iam_user" "administrator" {
  name = "Administrator"
}

# Create access key for user
resource "aws_iam_access_key" "access-key" {
  user = aws_iam_user.administrator.name
}

# Add user to group
resource "aws_iam_user_group_membership" "addtogroup" {
  user   = aws_iam_user.administrator.name
  groups = [aws_iam_group.administrators.name]
}