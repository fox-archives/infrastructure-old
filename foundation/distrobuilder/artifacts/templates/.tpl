# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

# The loopback network interface
auto lo
iface lo inet loopback

{% if config_get("user.isStatic", "") == "confirmed" %}allow-hotplug eth0
iface eth0 inet static
  address {{ config_get("user.ifupdown.address", "defaultAddress") }}
  gateway  {{ config_get("user.ifupdown.gateway", "defaultGateway") }}
  dns-nameservers  {{ config_get("user.ifupdown.dnsNameservers", "defaultDnsNameservers") }}{% else %}auto eth0
iface eth0 inet dhcp{% endif %}

# other thing

source /etc/network/interfaces.d/*.cfg
