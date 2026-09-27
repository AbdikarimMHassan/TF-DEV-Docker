variable "engineer_name" {
  description = "Name to include in the generated greeting file"
  type        = string
  # No default on purpose: this forces you to supply it the same way the
  # real repo forces you to supply per-environment values — via
  # TF_VAR_engineer_name in .env (sourced by entry_point.sh) or via
  # terraform.auto.tfvars. CI supplies its own value as a plain env var
  # in the workflow file (see .github/workflows/pr-checks.yml).
}

variable "hello_there" {
  description = "A string to include in the generated greeting file"
  type        = string
  default     = "Hello there!"
}