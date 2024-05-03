variable "github_owner" {
  description = "The owner of the GitHub organization."
  type        = string
}

variable "members" {
  description = "Organization members GitHub ID"
  type        = list(string)
}
