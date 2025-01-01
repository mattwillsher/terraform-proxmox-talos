
module "cluster" {
  source = "../.."

  talos_version = "v1.9.1"

  cluster_name = "basic-example"

  datastore_id = "local-lvm"

  controlplane = {
    machine_count = 3
    memory        = 2048
    tags          = ["controlplane"]
  }

  workers = {
    default = {
      machine_count     = 3
      memory_size_in_mb = 2048
      tags              = ["worker"]
      disks = [
        { size = 20 }, # root
        { size = 10 }  # data
      ]
    }
  }

  vip_address = "192.168.28.130"

  tags = ["kubernetes", "basic-example"]
}

resource "local_file" "kubeconfig" {
  content              = module.cluster.kubeconfig_raw
  filename             = "kubeconfig"
  directory_permission = "0700"
  file_permission      = "0600"
}

resource "local_file" "talosconfig" {
  content              = module.cluster.talos_client_configuration.talos_config
  filename             = "talosconfig"
  directory_permission = "0700"
  file_permission      = "0600"
}
