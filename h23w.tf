module "h23w_parent_team" {
  source = "./modules/teams"

  team_name   = "hackathon_23_winter"
  members     = local.h23w_parent.members
  maintainers = local.h23w_parent.maintainers
  description = "2023冬ハッカソン"
}

module "h23w_children_teams" {
  for_each = local.h23w_children
  source   = "./modules/teams"

  team_name   = each.key
  members     = each.value.members
  maintainers = each.value.maintainers
  description = contains(keys(each.value), "description") ? each.value.description : ""

  parent_id = module.h23w_parent_team.team_id
}

locals {
  h23w_parent = {
    members = [
      "zer0-star", "itt828", "eyemono-moe", "Kaki256", "oER4",
      "mehm8128", "mathsuky", "ikura-hamu", "hayatroid", "alter334",
      "comavius", "ramdos0207", "pirosiki197", "Pugma", "yukikurage",
    ]
    maintainers = ["Takeno-hito", "kaitoyama", "H1rono"]
  }

  h23w_children = {
    "h23w_01" = {
      members     = []
      maintainers = ["zer0-star", "H1rono", "itt828", "mehm8128", "ikura-hamu"]
    }

    "h23w_03" = {
      members     = ["comavius"]
      maintainers = ["Kaki256", "oER4", "alter334", "ramdos0207", "Pugma"]
    }

    "h23w_10" = {
      members     = []
      maintainers = ["eyemono-moe", "mathsuky", "hayatroid", "pirosiki197"]
    }

    "h23w_12" = {
      members     = ["taxfree-python"]
      maintainers = ["iChemy", "Aketami23"]
    }
  }
}
