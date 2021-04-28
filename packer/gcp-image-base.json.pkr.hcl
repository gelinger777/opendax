# This file was autogenerated by the BETA 'packer hcl2_upgrade' command. We
# recommend double checking that everything is correct before going forward. We
# also recommend treating this file as disposable. The HCL2 blocks in this
# file can be moved to other files. For example, the variable blocks could be
# moved to their own 'variables.pkr.hcl' file, etc. Those files need to be
# suffixed with '.pkr.hcl' to be visible to Packer. To use multiple files at
# once they also need to be in the same folder. 'packer inspect folder/'
# will describe to you what is in that folder.

# Avoid mixing go templating calls ( for example ```{{ upper(`string`) }}``` )
# and HCL2 calls (for example '${ var.string_value_example }' ). They won't be
# executed together and the outcome will be unknown.

# All generated input variables will be of 'string' type as this is how Packer JSON
# views them; you can change their type later on. Read the variables type
# constraints documentation
# https://www.packer.io/docs/from-1.5/variables#type-constraints for more info.
variable "account_file" {
  type    = string
  default = ""
}

variable "project_id" {
  type        = string
  default     = ""
  description = "The project ID that will be used to launch instances and store images."
}

variable "zone" {
  type        = string
  default     = "europe-west1-b"
  description = "The zone in which to launch the instance used to create the image."
}

# "timestamp" template function replacement
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/from-1.5/blocks/source
source "googlecompute" "opendax" {
  account_file  = "${var.account_file}"
  disk_size     = 10
  disk_type     = "pd-ssd"
  image_name    = "opendax-base"
  instance_name = "opendax-base"
  machine_type  = "n1-standard-1"
  project_id    = "${var.project_id}"
  source_image  = "debian-9-stretch-v20210217"
  ssh_username  = "deploy"
  zone          = "${var.zone}"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/from-1.5/blocks/build
build {
  sources = ["source.googlecompute.opendax"]

  provisioner "shell" {
    script = "./packer/scripts/install-base.sh"
  }
}