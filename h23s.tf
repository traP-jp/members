module "h23s_parent_team" {
  source = "./modules/teams"

  team_name   = "hackathon_23_spring"
  members     = local.h23s_parent.members
  maintainers = local.h23s_parent.maintainers

  github_owner = local.github_owner
}

module "h23s_children_teams" {
  for_each = local.h23s_children
  source   = "./modules/teams"

  team_name   = each.key
  members     = each.value.members
  maintainers = each.value.maintainers

  parent_id = module.h23s_parent_team.team_id

  github_owner = local.github_owner
}


locals {
  h23s_parent = {
    members = [
      "trasta298", "saitenntaisei", "kenken714", "Galvatron4", "kisepichu",
      "topaz13", "Sokugame", "cp-20", "oribe1115", "abap34", "itt828",
      "NagatsukiSep", "SSlime-s", "Kaki256", "aya-se", "ras0q", "toshi-pono",
      "mehm8128", "Irori235", "Apple000001", "mathsuky", "SakuAs0",
      "ikura-hamu", "iChemy", "Sotatsu57", "Luftalian", "mizoreyuki8",
      "karo1111111", "Ayaka-mogumogu", "hayatroid", "alter334", "ramdos0207",
      "pirosiki197", "24take", "Hueter57", "Kein1048596", "Pugma", "usomatsu",
      "Yuki-Ots", "SakanoYuito", "hinamas2004", "sumirinn", "kamaboko720",
      "Aketami23", "tobuhitodesu", "Wertsatz", "eran1515", "Akira-256",
      "penguin23-001", "emura0", "Nzt3-gh", "Kuryu025"
    ]
    maintainers = ["Takeno-hito", "H1rono"]
  }

  h23s_children = {
    "h23s_01" = {
      members     = []
      maintainers = ["aya-se", "mathsuky", "ikura-hamu", "pirosiki197", "Akira-256"]
    }
    "h23s_04" = {
      members     = ["NagatsukiSep", "hinamas2004"]
      maintainers = ["SakuAs0"]
    }
    "h23_06" = {
      members     = []
      maintainers = ["kenken714", "H1rono", "Kaki256", "sumirinn", "kamaboko720"]
    }
    "h23s_07" = {
      members     = ["Galvatron4", "eran1515", "penguin23-001"]
      maintainers = ["topaz13", "Kein1048596", "tobuhitodesu"]
    }
    "h23s_08" = {
      members     = []
      maintainers = ["kisepichu", "SSlime-s", "Ayaka-mogumogu", "hayatroid", "Nzt3-gh"]
    }
    "h23s_11" = {
      members     = []
      maintainers = ["trasta298", "iChemy", "karo1111111", "ramdos0207", "Yuki-Ots"]
    }
    "h23s_14" = {
      members     = ["Aketami23"]
      maintainers = ["saitenntaisei", "itt828", "Hueter57"]
    }
    "h23s_15" = {
      members     = []
      maintainers = ["oribe1115", "Sotatsu57", "Luftalian", "Pugma", "Wertsatz"]
    }
    "h23s_17" = {
      members     = ["abap34", "24take", "usomatsu", "emura0"]
      maintainers = ["toshi-pono"]
    }
    "h23s_20" = {
      members     = ["Sokugame", "Irori235"]
      maintainers = ["mehm8128", "Apple000001", "SakanoYuito"]
    }
    "h23s_26" = {
      members     = ["cp-20", "mizoreyuki8", "alter334", "Kuryu025"]
      maintainers = ["ras0q"]
    }
  }
}
