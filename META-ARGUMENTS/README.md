In Terraform, meta-arguments are special arguments that can be used with any resource, data source, module, or provisioner to control how Terraform creates, updates, or manages infrastructure. They are not specific to a provider.

Below is a clear overview of the main Terraform meta-arguments, with explanations and examples.

 1. **count`- **Explanation**: The `count` meta-argument allows you to create multiple instances of a resource based on a specified number or a list of items.
- **Example**:
  ```hcl
  resource "aws_instance" "example" {
    count         = 3
    ami           = "ami-0c55b159cbfafe1f0"
    instance_type = "t2.micro"
  }
  ```
  