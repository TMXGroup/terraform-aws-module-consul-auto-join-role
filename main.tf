terraform {
  required_version = ">= 0.11.5"
}

data "aws_iam_policy_document" "assume_role" {
  count = "${var.create ? 1 : 0}"

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "consul" {
  count = "${var.create ? 1 : 0}"

  name_prefix        = "${var.name}-"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role.json}"
}

data "aws_iam_policy_document" "consul" {
  count = "${var.create ? 1 : 0}"

  statement {
    sid       = "AllowSelfAssembly"
    effect    = "Allow"
    resources = ["*"]

    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "ec2:DescribeVpcs",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeInstanceAttribute",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstances",
      "ec2:DescribeTags",
    ]
  }
  statement {
    effect    = "Allow"
    resources = ["*"]
    actions = ["s3:List*"]
  }
  statement {
    effect    = "Allow"
    resources = [
      "arn:aws:s3:::taps3-hashi-install-binaries/*"
      ]
    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
  }
  statement {
    effect    = "Allow"
    resources = [
      "arn:aws:s3:::hashi-consul-snapshots/*"
      ]
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]
  }
}

resource "aws_iam_role_policy" "consul" {
  count = "${var.create ? 1 : 0}"

  name_prefix = "${var.name}-"
  role        = "${aws_iam_role.consul.id}"
  policy      = "${data.aws_iam_policy_document.consul.json}"
}

resource "aws_iam_instance_profile" "consul" {
  count = "${var.create ? 1 : 0}"

  name_prefix = "${var.name}-"
  role        = "${aws_iam_role.consul.name}"
}
