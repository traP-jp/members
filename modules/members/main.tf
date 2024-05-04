resource "github_membership" "member" {
  for_each = toset(var.members)

  username = each.key
}
