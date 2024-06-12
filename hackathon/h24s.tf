module "h24s_parent_team" {
  source = "../modules/teams"

  team_name   = "hackathon_24_spring"
  members     = local.h24s_parent.members
  maintainers = local.h24s_parent.maintainers
  description = "2024春ハッカソン"
}

module "h24s_children_teams" {
  for_each = local.h24s_children
  source   = "../modules/teams"

  team_name   = each.key
  members     = each.value.members
  maintainers = each.value.maintainers
  description = contains(keys(each.value), "description") ? each.value.description : ""

  parent_id = module.h24s_parent_team.team_id
}

locals {
  h24s_parent = {
    members = [
      "blancnoir256", "ErrorSyntax1", "Liscome", "H1rono", "itt828", "kamecha", "karo1111111",
      "Kuh456", "PL-38", "Pugma"
    ]
    maintainers = ["Takeno-hito", "kaitoyama", "H1rono", "ikura-hamu"]
  }

  h24s_children = {
    "h24s_17" = {
      members     = ["ErrorSyntax1", "Liscome", "PL-38"]
      maintainers = ["itt828", "H1rono"]
    }
    "h24s_32" = {
      members = []
      maintainers = [
        "blancnoir256", "kamecha", "karo1111111", "Kuh456", "mirin-mochigome", "YMAC-STICK"
      ]
    }
  }
}
