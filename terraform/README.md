# Terraform EKS Cluster for Ambience Cloud

This Terraform project provisions a complete Amazon EKS (Elastic Kubernetes Service) cluster named "Ambience Cloud" on AWS, designed to host Elixir Ambience applications with enterprise-grade security and scalability.

## Architecture Overview

The infrastructure includes:

- **EKS Cluster**: Named "Ambience Cloud" with the latest Kubernetes version
- **VPC**: Dedicated Virtual Private Cloud with public and private subnets across multiple AZs
- **Networking**: Internet Gateway, NAT Gateways, and proper routing for secure connectivity
- **Security Groups**: Least-privilege security groups for cluster and node communications
- **IAM Roles**: Properly configured roles for EKS cluster and worker nodes
- **Node Group**: Managed node group with auto-scaling capabilities
- **Encryption**: KMS encryption for cluster secrets
- **Logging**: CloudWatch logging for cluster audit and API logs

## Prerequisites

- [Terraform](https://terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- [kubectl](https://kubernetes.io/docs/tasks/tools/) for cluster management
- AWS account with necessary permissions for EKS, VPC, IAM, and KMS resources

## Required AWS Permissions

Your AWS credentials need the following permissions:
- EKS cluster and node group management
- VPC, subnet, and routing table management
- IAM role and policy management
- KMS key management
- CloudWatch log group management
- EC2 security group management

## Quick Start

1. **Clone and Navigate**:
   ```bash
   git clone <repository-url>
   cd elixir-ambience/terraform
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Review and Customize Variables**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   # Edit terraform.tfvars with your desired values
   ```

4. **Plan the Deployment**:
   ```bash
   terraform plan
   ```

5. **Apply the Configuration**:
   ```bash
   terraform apply
   ```

6. **Configure kubectl**:
   ```bash
   aws eks update-kubeconfig --region us-east-1 --name "Ambience Cloud"
   ```

7. **Verify the Cluster**:
   ```bash
   kubectl get nodes
   kubectl get pods --all-namespaces
   ```

## Configuration

### Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `aws_region` | AWS region for resources | `us-east-1` | No |
| `cluster_name` | Name of the EKS cluster | `Ambience Cloud` | No |
| `cluster_version` | Kubernetes version | `1.28` | No |
| `environment` | Environment name | `dev` | No |
| `vpc_cidr` | CIDR block for VPC | `10.0.0.0/16` | No |
| `node_group_instance_types` | EC2 instance types for nodes | `["t3.medium"]` | No |
| `node_group_desired_capacity` | Desired number of nodes | `2` | No |
| `node_group_max_capacity` | Maximum number of nodes | `4` | No |
| `node_group_min_capacity` | Minimum number of nodes | `1` | No |

### Example terraform.tfvars

```hcl
aws_region     = "us-west-2"
cluster_name   = "Ambience Cloud Production"
environment    = "prod"
cluster_version = "1.28"

# Node group configuration
node_group_instance_types    = ["t3.large", "t3.xlarge"]
node_group_desired_capacity  = 3
node_group_max_capacity      = 6
node_group_min_capacity      = 2

# Network configuration
vpc_cidr = "10.0.0.0/16"
availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]
```

## Outputs

After successful deployment, Terraform provides:

- `cluster_endpoint`: EKS cluster API endpoint
- `cluster_id`: EKS cluster identifier
- `kubeconfig`: Complete kubeconfig for cluster access
- `vpc_id`: VPC identifier
- `private_subnet_ids`: Private subnet identifiers
- `public_subnet_ids`: Public subnet identifiers
- `cluster_connection_instructions`: Step-by-step connection guide

## Security Features

- **Network Isolation**: Private subnets for worker nodes, public subnets for load balancers
- **Security Groups**: Minimal required access between cluster components
- **IAM Roles**: Least-privilege IAM roles for cluster and nodes
- **Encryption**: KMS encryption for Kubernetes secrets at rest
- **Logging**: Comprehensive cluster logging to CloudWatch
- **Version Management**: Pinned provider versions for reproducible deployments

## Connecting Your Application

Once the cluster is ready, you can deploy the Elixir Ambience application:

1. **Build and Push Docker Image** (if not using existing image):
   ```bash
   docker build -t your-registry/elixir-ambience:latest .
   docker push your-registry/elixir-ambience:latest
   ```

2. **Deploy to Kubernetes**:
   ```bash
   kubectl apply -f k8s/
   ```

3. **Expose the Service**:
   ```bash
   kubectl expose deployment elixir-ambience --type=LoadBalancer --port=1740
   ```

## Monitoring and Maintenance

- **Cluster Logs**: Available in CloudWatch under `/aws/eks/Ambience Cloud/cluster`
- **Node Monitoring**: Use `kubectl top nodes` for resource usage
- **Cluster Autoscaling**: Node group automatically scales based on demand
- **Updates**: Use `terraform plan` and `terraform apply` for infrastructure updates

## Cost Optimization

- **Instance Types**: Default uses `t3.medium` for cost efficiency
- **Spot Instances**: Set `node_group_capacity_type = "SPOT"` for cost savings
- **Node Scaling**: Adjust min/max/desired capacity based on workload
- **Resource Cleanup**: Use `terraform destroy` to clean up when not needed

## Troubleshooting

### Common Issues

1. **Permission Denied**: Ensure AWS credentials have required permissions
2. **Subnet Conflicts**: Adjust VPC CIDR if it conflicts with existing networks
3. **Region Availability**: Ensure selected region supports EKS and chosen instance types
4. **Node Group Failed**: Check IAM roles and security group configurations

### Useful Commands

```bash
# Check cluster status
aws eks describe-cluster --name "Ambience Cloud" --region us-east-1

# Get node group status
aws eks describe-nodegroup --cluster-name "Ambience Cloud" --nodegroup-name "Ambience Cloud-node-group" --region us-east-1

# View cluster logs
aws logs describe-log-groups --log-group-name-prefix "/aws/eks/Ambience Cloud"

# Reset kubeconfig
aws eks update-kubeconfig --region us-east-1 --name "Ambience Cloud"
```

## Cleanup

To destroy the infrastructure:

```bash
terraform destroy
```

**Warning**: This will permanently delete all resources. Ensure you have backups of any important data.

## Support

For issues related to:
- **Terraform Configuration**: Check [Terraform EKS Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
- **EKS Cluster**: Refer to [AWS EKS Documentation](https://docs.aws.amazon.com/eks/)
- **Kubernetes**: See [Kubernetes Documentation](https://kubernetes.io/docs/)
- **Elixir Ambience**: Visit [Elixir Ambience Documentation](https://docs.elixirtech.com/Ambience/2024.0/index.html)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make changes and test thoroughly
4. Submit a pull request with detailed description

## License

This project is licensed under the same terms as the parent Elixir Ambience project.