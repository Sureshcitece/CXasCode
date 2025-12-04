resource "random_uuid" "example_uuid" {}

resource "genesyscloud_script" "NewOrderScript" {
  script_name       = "Example script name ${random_uuid.example_uuid.result}"
  filepath          = "${var.working_dir.script}/MenuScript.script.json"
  file_content_hash = filesha256("${var.working_dir.script}/MenuScript.script.json")
  substitutions = {
    /* Inside the script file, "{{foo}}" will be replaced with "bar" */
    foo = "bar"
  }
}