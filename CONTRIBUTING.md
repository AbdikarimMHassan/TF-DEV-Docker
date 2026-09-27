# Contributing

This repo is a personal practice sandbox that mirrors the real PR/CI workflow
used at PerfectDraft (AB InBev), for hands-on practice with the git +
Terraform + CI loop, without touching any real infrastructure or credentials.

## One-time setup: Docker

The real repo runs Terraform inside a container so every engineer (and CI)
uses the exact same Terraform version and toolchain. This sandbox mirrors
that:

1. Copy the example config files (both gitignored, so your values never get
   committed):
   ```bash
   cp .env_example .env
   # edit .env and set TF_VAR_engineer_name
   ```
   (or, alternatively: `cp terraform/terraform.auto.tfvars_example terraform/terraform.auto.tfvars`
   and edit `engineer_name` there — either channel works, don't need both.)
2. Build the image:
   ```bash
   docker build -t central-workflows-terraform:local -f terraform.Dockerfile .
   ```
3. Run it, mounting the repo in and dropping into a shell. `entry_point.sh`
   is the container's entrypoint — it sources `.env` automatically, so
   `TF_VAR_engineer_name` is already exported by the time you get a prompt:
   ```bash
   docker run -it --rm \
     -v "${PWD}":"${PWD}" \
     --workdir "${PWD}" \
     central-workflows-terraform:local
   ```
4. Inside the container, `cd terraform` and run the usual commands (see
   below). No local Terraform install needed on your host at all.

## Branching

- Default branch: `develop`
- Before starting work, make sure `develop` is up to date:
  ```bash
  git checkout develop
  git pull origin develop
  ```
- Create a working branch named `<prefix>-<ticket-number>-<short-descriptor>`,
  e.g. `pd-1001-add-greeting-var`. Make up a ticket prefix/number for
  practice, there's no real ticketing system behind this.

## Making a change

1. Edit the Terraform files under `terraform/` (e.g. add a variable, change
   the greeting message, add a new `local_file` resource).
2. Test locally before committing, from inside the Docker container (see
   above):
   ```bash
   cd terraform
   terraform fmt -check -recursive
   terraform init
   terraform validate
   terraform plan
   ```
3. Review your own diff (`git diff`) before staging.
4. Stage, commit, and push:
   ```bash
   git add <files>
   git commit -m "clear message describing the change"
   git push -u origin <your-branch-name>
   ```

## Opening a PR

- Open a pull request from your branch into `develop`.
- Fill in the PR template.
- CI (`.github/workflows/pr-checks.yml`) runs automatically and checks:
  - Your branch name matches the required pattern.
  - `terraform fmt`, `terraform validate`, and `terraform plan` all succeed
    — run inside the same `terraform.Dockerfile` image you used locally, so
    a green check locally means the toolchain matches what CI used too.
- Once checks pass, self-review the PR diff on GitHub before treating it as
  ready for "review" (there's no one else on this repo, but practice the
  habit anyway).
