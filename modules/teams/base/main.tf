resource "github_team" "team" {
  name        = var.team_name
  description = "Team for ${var.team_name}"

  parent_team_id = var.parent_id == "" ? null : var.parent_id
}

resource "github_team_membership" "team_members" {
  for_each = toset(var.members)
  team_id  = github_team.team.id

  username = each.value
  role     = "member"
}

resource "github_team_membership" "team_maintainers" {
  for_each = toset(var.maintainers)
  team_id  = github_team.team.id

  username = each.value
  role     = "maintainer"
}
