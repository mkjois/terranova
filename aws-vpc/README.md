# terranova/aws-vpc

## Getting started

TODO

## Caveats

When you first use this module (i.e. when there's no current state),
for some reason you need to run `apply` three times, like so:

```shell
terraform apply -target data.aws_availability_zones.all -target data.aws_availability_zones.available
terraform apply -target aws_subnet.public -target aws_subnet.private -target aws_subnet.spare
terraform apply
```

After this initial "state creation" you only need to run `apply` once as usual.
