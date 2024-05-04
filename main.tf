
locals {
  github_owner = "traP-jp"
}


provider "github" {
  owner = local.github_owner

}

module "teams" {
  source = "./modules/teams/multi"

  teams = local.teams


  github_owner = local.github_owner
}

module "members" {
  source = "./modules/members"

  github_owner = local.github_owner
  members      = local.members
}
