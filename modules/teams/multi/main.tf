resource "github_team" "team" {
  for_each    = var.teams
  name        = each.key
  description = "Team for ${each.key}"

  parent_team_id = each.value.parent_id == "" ? null : each.value.parent_id
}

resource "github_team_members" "team_members" {
  for_each = var.teams

  team_id = github_team.team[each.key].id

  dynamic "members" {
    for_each = toset(each.value.members)
    content {
      username = members.value
      role     = "member"
    }
  }

  dynamic "members" {
    for_each = toset(each.value.maintainers)
    content {
      username = members.value
      role     = "maintainer"
    }
  }
}
