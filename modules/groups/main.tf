resource "genesyscloud_group" "TestGroup" {
  name          = "Test Group"
  description   = "Group for Testers"
  type          = "official"
  visibility    = "public"
  rules_visible = true
  addresses {
    number = "+13174181234"
    type   = "GROUPRING"
  }
  owner_ids      = ["4eff594a-b2f6-494e-804d-bb77780c53d6"]
  member_ids     = ["4eff594a-b2f6-494e-804d-bb77780c53d6"]
  roles_enabled  = true
  calls_enabled  = false
  include_owners = false
}