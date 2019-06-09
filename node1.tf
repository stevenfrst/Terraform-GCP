# Create a new instance
resource "google_compute_instance" "node1" {
   name = "k8snode1"
   machine_type = "n1-standard-1"
   zone = "asia-southeast1-b"
   boot_disk {
      initialize_params {
      image = "ubuntu-1804-lts"
   }
}
metadata = {
        startup-script = <<SCRIPT
        apt-get -y update
        apt-get -y install nginx
        export HOSTNAME=$(hostname | tr -d '\n')
        export PRIVATE_IP=$(curl -sf -H 'Metadata-Flavor:Google' http://metadata/computeMetadata/v1/instance/network-interfaces/0/ip | tr -d '\n')
        echo "Welcome to $HOSTNAME - $PRIVATE_IP" > /usr/share/nginx/www/index.html
        service nginx start
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
