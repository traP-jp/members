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

variable "secret" {
  type        = bool
  description = "Secret team is not visible for organization members."
  default     = false
}

variable "description" {
  type        = string
  description = "Team description"
  default     = ""
}
