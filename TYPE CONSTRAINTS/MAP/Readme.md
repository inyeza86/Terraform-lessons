When you should use a map(...)

Use a map when each value needs a name (key) and you want to look things up explicitly.

Think of a map as:

key → value
“Give me this thing by name”

✅ Best use cases for map
1️⃣ Environment-based configuration (VERY common)
variable "instance_types" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    test = "t2.medium"
    prod = "t2.large"
  }
}


Usage:

instance_type = var.instance_types[var.environment]


✔ Clear intent
✔ No guessing
✔ Safe for prod

2️⃣ Region-specific values
variable "ami_ids" {
  type = map(string)
  default = {
    us-east-1 = "ami-0abc123"
    us-west-2 = "ami-0def456"
  }
}

ami = var.ami_ids[var.aws_region]

3️⃣ Feature flags / per-feature settings
variable "features" {
  type = map(bool)
  default = {
    s3_logging   = true
    cloudwatch  = false
    autoscaling = true
  }
}

count = var.features["autoscaling"] ? 1 : 0

4️⃣ Named collections (better than lists)

Instead of:

subnets = ["subnet-a", "subnet-b"]


Use:

subnets = {
  public  = "subnet-a"
  private = "subnet-b"
}


Usage:

subnet_id = var.subnets["public"]


✔ Readable
✔ Self-documenting
✔ No index guessing

5️⃣ Multiple similar resources with for_each
variable "instances" {
  type = map(object({
    instance_type = string
    az            = string
  }))
}

resource "aws_instance" "this" {
  for_each      = var.instances
  instance_type = each.value.instance_type
  availability_zone = each.value.az
}


✔ Stable resource identity
✔ Clear naming
✔ Scales well

❌ When NOT to use a map
🚫 When order matters

Maps are unordered.

var.map["first"]   # fine
var.map[0]         # ❌ invalid

🚫 When values don’t need names

If you’re just looping or passing IDs, use:

set(string) (unique)

list(string) (ordered)

map vs set vs list (mental model)
Type	Think of it as	Use when
string	One value	Single config
list	Ordered sequence	Priority matters
set	Unique bag	Order irrelevant
map	Dictionary	Named lookups
Terraform rule of thumb

If you ever write [0] → use a list
If you ever write ["key"] → use a map

Your EC2 sizing case (best practice)

Instead of a set:

instance_type = var.instance_types[var.environment]

variable "instance_types" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    prod = "t2.large"
  }
}


This avoids accidental scaling mistakes — especially in prod.