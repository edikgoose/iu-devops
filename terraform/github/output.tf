output "repository_full_name" {
  value = github_repository.repo.full_name
}

output "repository_default_branch_name" {
  value = github_branch_default.main.branch
}