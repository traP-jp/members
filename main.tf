
locals {
  github_owner = "traP-jp"
}

terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~>6.0"
    }
  }

  backend "gcs" {
    bucket = "trap-tfstate"
    prefix = "trap-community-terraform"
    # credentials = "google_credentials.json"
  }
}

provider "github" {
  owner = local.github_owner
}

module "teams" {
  for_each = local.teams
  source   = "./modules/teams"

  team_name   = each.key
  members     = each.value.members
  maintainers = each.value.maintainers
  description = contains(keys(each.value), "description") ? each.value.description : ""
}

module "members" {
  source = "./modules/members"
 
  members = local.members
}

module "hackathon" {
  source = "./hackathon"
}
