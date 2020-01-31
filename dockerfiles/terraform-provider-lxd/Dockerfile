FROM hashicorp/terraform:0.12.20

ARG terraformProviderLxdVersion="v1.3.0"
RUN wget https://github.com/sl1pm4t/terraform-provider-lxd/releases/download/${terraformProviderLxdVersion}/terraform-provider-lxd_${terraformProviderLxdVersion}_linux_amd64.zip
RUN unzip terraform-provider-lxd_${terraformProviderLxdVersion}_linux_amd64.zip
RUN chmod +x terraform-provider-lxd
RUN mkdir -p ~/.terraform.d/plugins
RUN mv terraform-provider-lxd ~/.terraform.d/plugins

# COPY --from=hashicorp/terraform:0.12.20 /bin/terraform /bin/
