
locals {
  github_owner = "traP-jp"
}


provider "github" {
  owner = local.github_owner

}

module "teams" {
  for_each = local.teams
  source   = "./modules/teams"

  github_owner = local.github_owner
  team_name    = each.key
  members      = each.value.members
  maintainers  = each.value.maintainers
}

module "members" {
  source = "./modules/members"

  github_owner = local.github_owner
  members      = local.members
}
