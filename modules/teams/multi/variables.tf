variable "github_owner" {
  description = "The owner of the GitHub organization."
  type        = string
}

variable "teams" {
  type = map(object({
    members     = list(string)
    maintainers = list(string)
    parent_id   = optional(string)
  }))
}
