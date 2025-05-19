# AWS IaC with Terragrunt + EC2 + Ansible + Monitoring

This project demonstrates how to provision AWS infrastructure using Terragrunt and Terraform within the Free Tier (t2.micro), without any manual steps in the AWS Console.

## Overview

- Create a **VPC** with a public subnet.
- Launch a **t2.micro EC2 instance** inside the VPC.
- Use **Ansible** to install a simple Flask application on the EC2 instance.
- Configure **Prometheus** and **Grafana** to monitor the EC2 instance (CPU, memory, etc.).

## Key Features

- Infrastructure as Code (IaC) with **Terragrunt** and **Terraform**.
- Fully automated deployment — no manual AWS Console actions.
- Simple Flask app deployment via **Ansible**.
- Monitoring setup with **Prometheus + Grafana** for resource metrics.

## Getting Started

1. Configure AWS CLI with credentials (`aws configure`).
2. Run Terragrunt to provision infrastructure.
3. Use Ansible to deploy the Flask app and monitoring agents.
4. Access Grafana dashboard to visualize metrics.

## Requirements

- Terraform & Terragrunt
- AWS CLI configured
- Ansible installed

---

Feel free to expand this README as the project grows!
