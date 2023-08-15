resource "aws_dynamodb_table" "subscription_table" {
  name           = "Subscriptions"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "SubscriptionID"
  range_key      = "SubscriberEmail" # Adding a sort key

  attribute {
    name = "SubscriptionID"
    type = "S"
  }
  
  attribute {
    name = "SubscriberEmail"
    type = "S"
  }

  #attribute {
  #  name = "SubscriptionType"
  #  type = "S"
  #}

  #attribute {
  #  name = "StartDate"
  #  type = "S"
  #}

  #attribute {
  #  name = "EndDate"
  #  type = "S"
  #}

  #attribute {
  #  name = "Status"
  #  type = "S" # e.g., Active, Cancelled, Pending
  #}

  tags = {
    Name        = "Subscription Table"
    Environment = "Production"
    Classified  = "Yes"
    PII         = "Yes"
    Service     = "Subscription Service"
    Backup      = "Daily"
    Owner 		  = "Github"
    Compliance  = "GDPR"
  }
}