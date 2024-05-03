resource "github_membership" "member" {
  for_each = var.members

  username = each.key
}
