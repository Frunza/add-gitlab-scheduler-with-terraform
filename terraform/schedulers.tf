resource "gitlab_pipeline_schedule" "scheduler" {
  project     = "123"
  description = "Used to schedule builds"
  ref         = "refs/heads/main"
  cron        = "0 1 * * *"
}
