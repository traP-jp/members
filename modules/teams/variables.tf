variable "github_owner" {
  description = "The owner of the GitHub organization."
  type        = string
}

variable "team_name" {
  type        = string
  description = "Team name"
}

variable "members" {
  type        = list(string)
  description = "Organization members GitHub ID"
}

variable "maintainers" {
  type        = list(string)
  description = "Organization maintainers GitHub ID"
}

variable "parent_id" {
  type        = string
  description = "Parent team ID"
  default     = ""
}
