variable "instance_id" {
  type = string
}

variable "instance_arn" {
  type = string
}

resource "aws_scheduler_schedule" "ec2_start_schedule" {
  name = "ec2-start-schedule"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression           = "cron(0 14 ? * * *)"  # Her gün saat 14:00
  schedule_expression_timezone  = "Europe/Istanbul"
  description                   = "Start instances event"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:startInstances"
    role_arn = aws_iam_role.scheduler_ec2_role.arn

    input = jsonencode({
      InstanceIds = [var.instance_id]
    })
  }
}

resource "aws_scheduler_schedule" "ec2_stop_schedule" {
  name = "ec2-stop-schedule"

  flexible_time_window {
    mode = "OFF"
  }

  schedule_expression           = "cron(0 15 ? * * *)"  # Her gün saat 15:00
  schedule_expression_timezone  = "Europe/Istanbul"
  description                   = "Stop instances event"

  target {
    arn      = "arn:aws:scheduler:::aws-sdk:ec2:stopInstances"
    role_arn = aws_iam_role.scheduler_ec2_role.arn

    input = jsonencode({
      InstanceIds = [var.instance_id]
    })
  }
}

resource "aws_iam_policy" "scheduler_ec2_policy" {
  name = "scheduler-ec2-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowStopStartInstances",
        Effect = "Allow",
        Action = [
          "ec2:StartInstances",
          "ec2:StopInstances"
        ],
        Resource = [
          var.instance_arn
        ]
      }
    ]
  })
}

resource "aws_iam_role" "scheduler_ec2_role" {
  name = "scheduler-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "scheduler.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "scheduler_ec2_policy_attachment" {
  role       = aws_iam_role.scheduler_ec2_role.name
  policy_arn = aws_iam_policy.scheduler_ec2_policy.arn
}
