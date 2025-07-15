# Terraform Best Practices

- Use `terraform workspace` to separate dev, stage, and prod environments.
- Use remote state (see backend.tf) for collaboration and state locking.
- Never commit secrets or sensitive values to version control.
- Use `sensitive = true` for outputs that contain secrets. 