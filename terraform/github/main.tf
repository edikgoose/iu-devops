terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.36.0"
    }
  }
}

provider "github" {
  token = var.token
}

resource "github_repository" "repo" {
  name               = var.repository_name
  description        = var.repository_description
  visibility         = var.repository_visibility
  has_issues         = true
  has_wiki           = true
  auto_init          = true
  license_template   = "mit"
  gitignore_template = "Terraform"
}

resource "github_branch_default" "main" {
  repository = github_repository.repo.name
  branch     = "main"
}

resource "github_branch_protection" "default" {
  repository_id                   = github_repository.repo.id
  pattern                         = github_branch_default.main.branch
  require_conversation_resolution = true
  enforce_admins                  = true

  required_pull_request_reviews {
    required_approving_review_count = 1
  }
}


resource "github_repository" "iu-devops-test-imported-repo" {
  name               = "iu-devops-test-imported-repository"
  description        = "Imported repo"
  visibility         = "public"
}

resource "github_branch_default" "imported_main" {
  repository = github_repository.iu-devops-test-imported-repo.name
  branch     = "main"
}