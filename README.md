# website-deployment-by-AWS-
This project demonstrates the deployment of a Flask application on AWS using Terraform. It covers the setup of a VPC, subnets, security groups, an internet gateway, and an EC2 instance. The Flask application serves a simple web page and is automatically provisioned and configured using Terraform.

## 🌩️ AWS Infrastructure for Flask Application Deployment 🌐
![protera](https://github.com/user-attachments/assets/f39a7b3e-badb-49fa-8e90-bd0955cb4628)

## Features

- 🛡️ **AWS VPC**: Provides a secure and isolated network environment.
- 🏗️ **Subnets**: Configured for public IP assignment.
- 🌍 **Internet Gateway**: Enables internet connectivity.
- 🛤️ **Route Table**: Routes outbound traffic.
- 🔒 **Security Groups**: Manages inbound and outbound traffic rules.
- 🖥️ **EC2 Instance**: Hosts the Flask application.
- 🐍 **Flask Application**: Serves a simple web page using Python.

## Technologies Used

- ☁️ **Cloud Platforms**: AWS
- 🛠️ **Infrastructure as Code**: Terraform
- 💻 **Programming Languages**: Python
- 🌐 **Web Framework**: Flask

## Files Included

- `main.tf`: Contains the Terraform configuration for setting up the AWS infrastructure.
- `app.py`: Flask application code.
- `key.pub`: Public SSH key for accessing the EC2 instance.
- `key`: Private SSH key for accessing the EC2 instance (ensure this file is securely stored and not uploaded to the repository).

## How to Use

1. **Clone the repository**:
   ```sh
   git clone https://github.com/ishagothwad/website-deployment-by-AWS-.git
   cd repo name
   ```

2. **Initialize Terraform**:
   ```sh
   terraform init
   ```
   
3. **Preview the changes Terraform will make**:
   ```sh
   terraform plan
   ```  

4. **Apply the Terraform configuration**:
   ```sh
   terraform apply
   ```

5. **Access the Flask application**:
   - After the resources are created, note the public IP of the EC2 instance from the Terraform output.
   - Open a web browser and navigate to `http://<public-ip>` to see the Flask application.

6. **SSH into the EC2 instance**:
   ```sh
   ssh -i key ubuntu@<public-ip>
   ```

## Cleanup

To destroy all the resources created by Terraform, run:
```sh
terraform destroy
```

## Notes

- 🔑 Ensure your AWS credentials are properly configured before running Terraform commands.
- 🔐 The private key file (`key`) should be kept secure and not shared publicly.

