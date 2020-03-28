build {
  sources = [
    "source.qemu.base_single"
  ]

  provisioner "shell" {
    execute_command = "{{ .Vars }} sudo -E bash '{{ .Path }}'"
    inline = [
      "apt-get update",
      "apt-get -y install software-properties-common",
      "apt-add-repository -yu ppa:ansible/ansible",
      "apt-get -y install ansible",
      "echo 'UseDNS no' >> /etc/ssh/sshd_config"
    ]
  }

  provisioner "ansible-local" {
    playbook_file = "ansible-local/playbook.yml"
    playbook_dir = "ansible-local"
  }
}
