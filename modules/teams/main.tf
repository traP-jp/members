resource "github_team" "team" {
  name        = var.team_name
  description = var.description == "" ? null : var.description
  privacy     = var.secret ? "secret" : "closed"

  parent_team_id = var.parent_id == "" ? null : var.parent_id
}

resource "github_team_members" "team_members" {
  team_id = github_team.team.id

  dynamic "members" {
    for_each = toset(var.members)
    content {
       username = members.value
      role     = "member"
    }
  }

  dynamic "members" {
    for_each = toset(var.maintainers)
    content {
      username = members.value
      role     = "maintainer"
    }
  }
}
