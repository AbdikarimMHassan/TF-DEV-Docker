# central-workflows (practice sandbox)

A personal sandbox for practicing the exact PR/CI workflow used at work:
`develop` as the default branch, ticket-style branch naming, a PR template,
Terraform run inside a Docker image (`terraform.Dockerfile` +
`entry_point.sh`, same as the real repo), and a GitHub Actions workflow
that runs those same Terraform checks — in that same image — on every pull
request.

No cloud credentials are needed anywhere in this repo, everything uses the
`hashicorp/random` and `hashicorp/local` Terraform providers, which only
touch the local filesystem/runner, never a real cloud account.

See `CONTRIBUTING.md` for the full workflow, including the one-time Docker
setup.
# TF-DEV-Docker
