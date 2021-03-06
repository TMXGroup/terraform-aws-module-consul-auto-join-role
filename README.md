# AWS Consul Auto-Join Terraform Module (External Fork)

Creates an IAM Role & Instance Profile with the necessary permission required for Consul Auto-Join.

Checkout [examples](./examples) for fully functioning examples.

## Environment Variables

- `AWS_DEFAULT_REGION`
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

## Input Variables

- `create`: [Optional] Create Module, defaults to true.
- `name`: [Optional] Name for resources, defaults to "consul-auto-join-aws".

## Outputs

- `iam_role_id`: IAM Role ID.
- `instance_profile_id`: Instance Profile ID.

## Module Dependencies

_None_

## Authors

HashiCorp Solutions Engineering Team.

## License

Mozilla Public License Version 2.0. See LICENSE for full details.
