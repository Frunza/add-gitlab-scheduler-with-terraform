# Add GitLab scheduler with Terraform

## Scenario

If you are using `GitLab`, how can you add pipeline schedulers via `Terraform`?

I assume that you already know how to create a `Terraform` project for `GitLab` and run `Terraform` inside a container. Take a look at [Configure Docker container with Terraform](https://github.com/Frunza/configure-docker-container-with-terraform) otherwise.

## Prerequisites

A Linux or MacOS machine for local development. If you are running Windows, you first need to set up the *Windows Subsystem for Linux (WSL)* environment.

You need `docker cli` and `docker-compose` on your machine for testing purposes, and/or on the machines that run your pipeline.
You can check both of these by running the following commands:
```sh
docker --version
docker-compose --version
```

One or more `GitLab` repositories for testing purposes.

## Implementation

In `GitLab` you can create a pipeline scheduler by navigating to the *Build* menu on the left and choosing *Pipeline schedules*; from here you have the option to create a new scheduler. The exact parameters you see on that screen can be configured in `Terraform`:
```sh
resource "gitlab_pipeline_schedule" "scheduler" {
  project     = "123"
  description = "Used to schedule builds"
  ref         = "refs/heads/main"
  cron        = "0 1 * * *"
}
```
The _project_ parameter refers to the `GitLab` repository ID. To find out the ID of a `GitLab` repository, navigate to the *settings* of the repository and choose the *general* section.

## Usage

Navigate to the root of the git repository and run the following command:
```sh
sh update.sh 
```

The following happens:
1) the first command builds the docker image and tags it as *gitlabterraformcontainer*
2) the docker image copies the `Terraform` project to an appropriate location.
3) the second command uses docker-compose to create and run the container. The container runs
```sh
terraform init && terraform validate && terraform apply -auto-approve
```
