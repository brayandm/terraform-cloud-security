# Create the group
resource "aws_iam_group" "administrators" {
  name = "Administrators"
  path = "/"
}

# Read data of AWS-managed policy
data "aws_iam_policy" "administrator_access" {
  name = "AdministratorAccess"
}

# Attach policy to the group
resource "aws_iam_group_policy_attachment" "administrators" {
  group      = aws_iam_group.administrators.name
  policy_arn = data.aws_iam_policy.administrator_access.arn
}