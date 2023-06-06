data "aws_iam_policy_document" "rolesanywhere_profile_role_policy_document" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["rolesanywhere.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
      "sts:SetSourceIdentity"
    ]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/x509SAN/URI"
      values = [
        "spiffe://nicholas.home.cluster/ns/*/sa/*"
      ]
    }

    condition {
      test     = "ArnEquals"
      variable = "aws:SourceArn"
      values = [
        aws_rolesanywhere_trust_anchor.trust_anchor.arn
      ]
    }
  }
}

data "aws_iam_policy_document" "rolesanywhere_profile_role_session_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "${aws_s3_bucket.bucket.arn}/*"
    ]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/x509SAN/URI"
      values = [
        "spiffe://nicholas.home.cluster/ns/${var.namespace}/sa/${var.name}"
      ]
    }
  }

  statement {
    effect = "Allow"

    actions = [
      "rds-db:connect"
    ]

    resources = [
      "arn:aws:rds-db:${var.region}:${var.account}:dbuser:${aws_db_instance.database.resource_id}/app-user"
    ]

    condition {
      test     = "StringLike"
      variable = "aws:PrincipalTag/x509SAN/URI"
      values = [
        "spiffe://nicholas.home.cluster/ns/${var.namespace}/sa/${var.name}"
      ]
    }
  }
}



resource "aws_iam_role" "trust_profile_role" {
  name               = "nicholas_meyers_home_k8s_read"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.rolesanywhere_profile_role_policy_document.json

  inline_policy {
    name   = "aws_read"
    policy = data.aws_iam_policy_document.rolesanywhere_profile_role_session_policy_document.json
  }
}

resource "aws_rolesanywhere_profile" "trust_profile" {
  name      = "nicholas_meyers_home_k8s_read"
  enabled   = true
  role_arns = [aws_iam_role.trust_profile_role.arn]
}



