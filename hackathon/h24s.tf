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
      "alex3333python", "alter334", "aster34", "ayanakm", "blancnoir256", "ErrorSyntax1",
      "Futadaruma", "eyerust", "H1rono", "hatchch", "hyde616", "itt828", "jippo-m", "kamecha",
      "karo1111111", "kn-tech", "Kuh456", "Liscome", "Luftalian", "Luke256", "mathsuky", "mehm8128",
      "motoki317", "mtaku3", "nagaeki", "Nattuki", "nokhnaton", "noya2ruler", "ogu-kazemiya",
      "Pentakon", "pippi0057", "pirosiki197", "PL-38", "Pugma", "reiroop", "riku6174", "Series-205",
      "Synori", "trasta298", "ultsaza", "zer0-star"
    ]
    maintainers = ["Takeno-hito", "kaitoyama", "H1rono", "ikura-hamu"]
  }

  h24s_children = {
    "h24s_04" = {
      members = []
      maintainers = [
        "alter334", "hyde616", "kn-tech", "mehm8128", "noya2ruler"
      ]
    }
    "h24s_10" = {
      members = []
      maintainers = [
        "jippo-m", "Luftalian", "nokhnaton", "ogu-kazemiya", "pippi0057", "pirosiki197"
      ]
    }
    "h24s_13" = {
      members = []
      maintainers = [
        "Futadaruma", "mathsuky", "motoki317", "riku6174", "Series-205"
      ]
    }
    "h24s_14" = {
      members = []
      maintainers = [
        "alex3333python", "eyerust", "Nattuki", "reiroop", "ultsaza", "zer0-star"
      ]
    }
    "h24s_16" = {
      members = []
      maintainers = [
        "aster34", "ayanakm", "mtaku3", "nagaeki", "Pugma", "trasta298"
      ]
    }
    "h24s_17" = {
      members     = ["ErrorSyntax1", "Liscome", "PL-38"]
      maintainers = ["itt828", "H1rono"]
    }
    "h24s_21" = {
      members     = []
      maintainers = ["Synori", "Luke256", "hatchch", "Pentakon"]
    }
    "h24s_32" = {
      members = []
      maintainers = [
        "blancnoir256", "kamecha", "karo1111111", "Kuh456", "mirin-mochigome", "YMAC-STICK"
      ]
    }
  }
}
