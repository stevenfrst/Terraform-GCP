# Create a new instance
resource "google_compute_instance" "node2" {
   name = "k8snode2"
   machine_type = "n1-standard-1"
   zone = "asia-southeast1-b"
   boot_disk {
      initialize_params {
      image = "ubuntu-1804-lts"
   }
}
metadata = {
        startup-script = <<SCRIPT
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
        add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
        curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
        cat << EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
        deb https://apt.kubernetes.io/ kubernetes-xenial main
        EOF
        apt-get update
        apt-get install -y docker-ce kubelet kubeadm kubectl
        SCRIPT
}
network_interface {
   network = "default"
   access_config {}
}
service_account {
   scopes = ["userinfo-email", "compute-ro", "storage-ro"]
   }
}
