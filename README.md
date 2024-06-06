# traP-jp members

traP-jp Organization のメンバー・チームを管理する Terraform

Terraform v1系を使用しています。

- GitHub Organizationについて https://docs.github.com/ja/organizations/collaborating-with-groups-in-organizations/about-organizations
- Terraformについて https://www.terraform.io/

## ディレクトリ構成

```txt
.
├── README.md
├── docs
│   └── image.png
├── hackathon # ハッカソン用の設定
│   ├── h23s.tf
│   └── h23w.tf
├── main.tf # providerの設定やteams.tf, members.tf, hackathon以下を取り込んでの実行
├── members.tf # orgのメンバー管理
├── modules # モジュール
│   ├── members # orgのメンバー
│   │   ├── main.tf
│   │   ├── provider.tf
│   │   └── variables.tf
│   └── teams # orgのチームとそのメンバー
│       ├── main.tf
│       ├── output.tf
│       ├── provider.tf
│       └── variables.tf
└── teams.tf # 親子関係の無いチーム
```

## 仕組み

Organization のメンバー・チーム情報をコードで一元管理し、反映を GitHub Actions と Google Cloud Storage を用いて行います。

### 流れ

1. mainブランチへのプルリクエストを出すと、GitHub Actions で以下がチェックされる
   1. `terraform validate`
   2. `terraform fmt`
   3. `terraform plan`
2. `plan` の結果が自動的にコメントされる
3. Admin がレビューする
4. マージされたタイミングで `terraform apply` が実行され、変更が反映される

## Contributing Guide

::: warning

Organization の Admin は terraform では管理せず、手動で管理しています。
詳細は「Organization の admin を追加したい」セクションを確認してください。

:::

### Organization のメンバーを編集する

リポジトリルートの[`members.tf`](./members.tf) を編集してください。
`members`の配列の中にGitHubのIDを追加し、横にコメントでtraQのIDを併記してください。
可能ならアルファベット順にすることが望ましいですが、PRの要件とはしません。

```tf
locals {
  members = [
    "ikura-hamu", # ikura-hamu
    "H1rono", # H1rono_K
  ]
}
```

一部コメントで traQ の ID が記載されていないメンバーが居ますが、これは terraform での管理前に追加されたメンバーです。
適宜コメントを追加していただけると助かります。

### 新しくチームを作成する

#### 単独のチームを作成する場合（小規模なプロジェクトなど）

[`teams.tf`](./teams.tf) の `teams` の中に以下のように追記してください。

```tf
"team-name" = {
  members = ["aaa", "bbb"] # チームのメンバーのGitHub ID
  maintainers = ["ccc", "ddd"] # チームのメンテナーGitHub ID
  description = "チームの説明" # optional だがチーム名から推測し辛い場合は記載すること
  secret = false # Organization 内に公開されているチームか否か。デフォルトはfalse（公開）
}
```

`secret` について：チーム情報全体が Public Repository で運用されていることから traP-jp organization でチームを secret にする理由はあまりないと考えていますが、判断は個々人に委ねられます。

#### チームの中にチームを作成する想定の場合　（ハッカソンのチームなど）

チームの数にもよりますが、基本的にファイルを分けて記述してください。

ファイルの記述方法は [`hackathon/h23s.tf`](./hackathon/h23s.tf) を参考にしてください。

ファイルの作成場所は以下に従ってください。

- ハッカソンの設定を追加したい場合：`hackathon` フォルダ内
- それ以外の親子関係のあるチームを作りたい場合：リポジトリルート

記述方法はどちらも基本的に共通です。ただし、**`module` の `source` は相対パス** です。ご注意ください。

##### sample

`xxx-team`というチームの下に`xxx_01`と`xxx_02` というチームを作成する場合（リポジトリルート下に設置）

```tf
module "xxx_parent_team" {
  source = "./modules/teams" # hackathonフォルダの下であれば、 "../modules/teams" にする

  team_name   = "xxx-team" # 親チーム名
  members     = local.xxx_parent.members
  maintainers = local.xxx_parent.maintainers
  description = "親チームの説明"
}

module "xxx_children_teams" {
  for_each = local.xxx_children
  source   = "./modules/teams" # hackathonフォルダの下であれば、 "../modules/teams" にする

  team_name   = each.key
  members     = each.value.members
  maintainers = each.value.maintainers
  description = contains(keys(each.value), "description") ? each.value.description : ""

  parent_id = module.xxx_parent_team.team_id
}

locals {
  xxx_parent = {
    members = ["aaa", "bbb", "ccc", "ddd"] # 親チームのメンバーの GitHub ID
    maintainers = ["eee"] # 子チームのメンバーの GitHub ID
  }

  xxx_children = {
    "xxx_01" = {
      members     = []
      maintainers = ["aaa", "bbb"]
      description = "チーム01"
    }

    "xxx_02" = {
      members     = ["ccc"]
      maintainers = ["ddd"]
      secret = true
    }
  }
}
```

3階層以上の親子関係も作成しようと思えば作成可能です。

### Organizationの admin を追加したい

admin のみ terraform で管理しない運用をするため、煩雑な手順を踏んています。

1. [`members.tf`](./members.tf) から、新しく Admin になるユーザーをコメントアウトし、その上 admin と分かるようにコメントを追記してください。
2. 1 の PR を作成し main に反映させてください。
3. 既存の Admin が github.com の UI 上から新しい admin を招待し、 admin に登録してください。
4. 新しい Admin が所属しているチームについて、チームのmembersに含まれている場合は、tfファイルを編集して、すべてmaintainersにしてください。
   - OrgのAdminはチームに所属すると必ずmaintainerになるという GitHub の仕様に合わせるためです。

### Organizationのadminを普通のmemberにしたい

1. [Organization のメンバーを編集する](#Organization のメンバーを編集する) と同様に [`members.tf`](./members.tf) に追加してください。
2. チームのmaintainerから外したい場合は、それぞれmaintainersからmembersに移動させてください。

## Admin 向け

Terraformのバックエンドとして、SysAd班のGCPアカウントのGoogle Cloud Storageの`trap-tfstate`というバケットを使用しています。

GitHub Actionsには`PERSONAL_TOKEN`と`GOOGLE_BACKEND_CREDENTIALS`の二つのsecretを設定する必要があります。

- `PERSONAL_TOKEN`
  - **Adminの誰かの**GitHubのFine-grained token
  - Organization の members への Read,Write 権限が必要
  - 以下のようになっていれば OK
  ![Organization permissionsのところにRead and Write access to membersと書かれている](docs/image.png)
- `GOOGLE_BACKEND_CREDENTIALS`
  - GCS の credential 情報
