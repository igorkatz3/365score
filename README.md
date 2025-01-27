# 365score
See below the 365score assestments with terrarorm code. I added to the tf code the cloudwatch alert to monitor if the (ec2 instance/ pod) is healthy.
It's very low healthy monitoring, but the datadog or coralogix alert might be better.

terraform init 
terraform apply -var-file=variables-dev.tfvars 

Run output:

[ec2-user@ip-10-0-2-52 365score]$ terraform apply -var-file=variables-dev.tfvars

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_cloudwatch_metric_alarm.alert will be created
  + resource "aws_cloudwatch_metric_alarm" "alert" {
      + actions_enabled                       = true
      + alarm_description                     = "Number of healthy nodes in Target Group"
      + alarm_name                            = "dev-alert"
      + arn                                   = (known after apply)
      + comparison_operator                   = "LessThanThreshold"
      + dimensions                            = (known after apply)
      + evaluate_low_sample_count_percentiles = (known after apply)
      + evaluation_periods                    = 1
      + id                                    = (known after apply)
      + metric_name                           = "HealthyHostCount"
      + namespace                             = "AWS/ApplicationELB"
      + period                                = 60
      + statistic                             = "Average"
      + tags_all                              = {
          + "Env" = "dev"
        }
      + threshold                             = 1
      + treat_missing_data                    = "missing"
    }

  # aws_eip.nat will be created
  + resource "aws_eip" "nat" {
      + allocation_id        = (known after apply)
      + arn                  = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = "vpc"
      + id                   = (known after apply)
      + instance             = (known after apply)
      + ipam_pool_id         = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + ptr_record           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags_all             = {
          + "Env" = "dev"
        }
      + vpc                  = (known after apply)
    }

  # aws_internet_gateway.internet_gateway will be created
  + resource "aws_internet_gateway" "internet_gateway" {
      + arn      = (known after apply)
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "internet_gateway"
        }
      + tags_all = {
          + "Env"  = "dev"
          + "Name" = "internet_gateway"
        }
      + vpc_id   = (known after apply)
    }

  # aws_lb.elb will be created
  + resource "aws_lb" "elb" {
      + arn                                                          = (known after apply)
      + arn_suffix                                                   = (known after apply)
      + dns_name                                                     = (known after apply)
      + dns_record_client_routing_policy                             = "any_availability_zone"
      + enable_cross_zone_load_balancing                             = false
      + enable_deletion_protection                                   = false
      + enable_zonal_shift                                           = false
      + enforce_security_group_inbound_rules_on_private_link_traffic = (known after apply)
      + id                                                           = (known after apply)
      + internal                                                     = false
      + ip_address_type                                              = (known after apply)
      + load_balancer_type                                           = "network"
      + name                                                         = "dev-alb"
      + name_prefix                                                  = (known after apply)
      + security_groups                                              = (known after apply)
      + subnets                                                      = (known after apply)
      + tags                                                         = {
          + "Name" = "dev-alb"
        }
      + tags_all                                                     = {
          + "Env"  = "dev"
          + "Name" = "dev-alb"
        }
      + vpc_id                                                       = (known after apply)
      + zone_id                                                      = (known after apply)

      + subnet_mapping (known after apply)
    }

  # aws_lb_listener.listener_443 will be created
  + resource "aws_lb_listener" "listener_443" {
      + arn                                                                   = (known after apply)
      + id                                                                    = (known after apply)
      + load_balancer_arn                                                     = (known after apply)
      + port                                                                  = 443
      + protocol                                                              = "TCP"
      + routing_http_request_x_amzn_mtls_clientcert_header_name               = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_issuer_header_name        = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_leaf_header_name          = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_serial_number_header_name = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_subject_header_name       = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_validity_header_name      = (known after apply)
      + routing_http_request_x_amzn_tls_cipher_suite_header_name              = (known after apply)
      + routing_http_request_x_amzn_tls_version_header_name                   = (known after apply)
      + routing_http_response_access_control_allow_credentials_header_value   = (known after apply)
      + routing_http_response_access_control_allow_headers_header_value       = (known after apply)
      + routing_http_response_access_control_allow_methods_header_value       = (known after apply)
      + routing_http_response_access_control_allow_origin_header_value        = (known after apply)
      + routing_http_response_access_control_expose_headers_header_value      = (known after apply)
      + routing_http_response_access_control_max_age_header_value             = (known after apply)
      + routing_http_response_content_security_policy_header_value            = (known after apply)
      + routing_http_response_server_enabled                                  = (known after apply)
      + routing_http_response_strict_transport_security_header_value          = (known after apply)
      + routing_http_response_x_content_type_options_header_value             = (known after apply)
      + routing_http_response_x_frame_options_header_value                    = (known after apply)
      + ssl_policy                                                            = (known after apply)
      + tags                                                                  = {
          + "Name" = "dev-alb-listener"
        }
      + tags_all                                                              = {
          + "Env"  = "dev"
          + "Name" = "dev-alb-listener"
        }
      + tcp_idle_timeout_seconds                                              = (known after apply)

      + default_action {
          + order            = (known after apply)
          + target_group_arn = (known after apply)
          + type             = "forward"
        }

      + mutual_authentication (known after apply)
    }

  # aws_lb_listener.listener_80 will be created
  + resource "aws_lb_listener" "listener_80" {
      + arn                                                                   = (known after apply)
      + id                                                                    = (known after apply)
      + load_balancer_arn                                                     = (known after apply)
      + port                                                                  = 80
      + protocol                                                              = "TCP"
      + routing_http_request_x_amzn_mtls_clientcert_header_name               = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_issuer_header_name        = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_leaf_header_name          = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_serial_number_header_name = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_subject_header_name       = (known after apply)
      + routing_http_request_x_amzn_mtls_clientcert_validity_header_name      = (known after apply)
      + routing_http_request_x_amzn_tls_cipher_suite_header_name              = (known after apply)
      + routing_http_request_x_amzn_tls_version_header_name                   = (known after apply)
      + routing_http_response_access_control_allow_credentials_header_value   = (known after apply)
      + routing_http_response_access_control_allow_headers_header_value       = (known after apply)
      + routing_http_response_access_control_allow_methods_header_value       = (known after apply)
      + routing_http_response_access_control_allow_origin_header_value        = (known after apply)
      + routing_http_response_access_control_expose_headers_header_value      = (known after apply)
      + routing_http_response_access_control_max_age_header_value             = (known after apply)
      + routing_http_response_content_security_policy_header_value            = (known after apply)
      + routing_http_response_server_enabled                                  = (known after apply)
      + routing_http_response_strict_transport_security_header_value          = (known after apply)
      + routing_http_response_x_content_type_options_header_value             = (known after apply)
      + routing_http_response_x_frame_options_header_value                    = (known after apply)
      + ssl_policy                                                            = (known after apply)
      + tags                                                                  = {
          + "Name" = "dev-alb-listener"
        }
      + tags_all                                                              = {
          + "Env"  = "dev"
          + "Name" = "dev-alb-listener"
        }
      + tcp_idle_timeout_seconds                                              = (known after apply)

      + default_action {
          + order            = (known after apply)
          + target_group_arn = (known after apply)
          + type             = "forward"
        }

      + mutual_authentication (known after apply)
    }

  # aws_lb_target_group.tg will be created
  + resource "aws_lb_target_group" "tg" {
      + arn                                = (known after apply)
      + arn_suffix                         = (known after apply)
      + connection_termination             = (known after apply)
      + deregistration_delay               = "300"
      + id                                 = (known after apply)
      + ip_address_type                    = (known after apply)
      + lambda_multi_value_headers_enabled = false
      + load_balancer_arns                 = (known after apply)
      + load_balancing_algorithm_type      = (known after apply)
      + load_balancing_anomaly_mitigation  = (known after apply)
      + load_balancing_cross_zone_enabled  = (known after apply)
      + name                               = "dev-tg"
      + name_prefix                        = (known after apply)
      + port                               = 80
      + preserve_client_ip                 = (known after apply)
      + protocol                           = "TCP"
      + protocol_version                   = (known after apply)
      + proxy_protocol_v2                  = false
      + slow_start                         = 0
      + tags                               = {
          + "Name" = "dev-tg"
        }
      + tags_all                           = {
          + "Env"  = "dev"
          + "Name" = "dev-tg"
        }
      + target_type                        = "instance"
      + vpc_id                             = (known after apply)

      + health_check {
          + enabled             = true
          + healthy_threshold   = 3
          + interval            = 30
          + matcher             = "200"
          + path                = "/"
          + port                = "traffic-port"
          + protocol            = "HTTP"
          + timeout             = 5
          + unhealthy_threshold = 2
        }

      + stickiness (known after apply)

      + target_failover (known after apply)

      + target_group_health (known after apply)

      + target_health_state (known after apply)
    }

  # aws_nat_gateway.gw will be created
  + resource "aws_nat_gateway" "gw" {
      + allocation_id                      = (known after apply)
      + association_id                     = (known after apply)
      + connectivity_type                  = "public"
      + id                                 = (known after apply)
      + network_interface_id               = (known after apply)
      + private_ip                         = (known after apply)
      + public_ip                          = (known after apply)
      + secondary_private_ip_address_count = (known after apply)
      + secondary_private_ip_addresses     = (known after apply)
      + subnet_id                          = (known after apply)
      + tags_all                           = {
          + "Env" = "dev"
        }
    }

  # aws_route53_record.dev will be created
  + resource "aws_route53_record" "dev" {
      + allow_overwrite = (known after apply)
      + fqdn            = (known after apply)
      + id              = (known after apply)
      + name            = "dev.com"
      + type            = "A"
      + zone_id         = (known after apply)

      + alias {
          + evaluate_target_health = true
          + name                   = (known after apply)
          + zone_id                = (known after apply)
        }
    }

  # aws_route53_zone.private will be created
  + resource "aws_route53_zone" "private" {
      + arn                 = (known after apply)
      + comment             = "Managed by Terraform"
      + force_destroy       = false
      + id                  = (known after apply)
      + name                = "dev.com"
      + name_servers        = (known after apply)
      + primary_name_server = (known after apply)
      + tags_all            = {
          + "Env" = "dev"
        }
      + zone_id             = (known after apply)

      + vpc {
          + vpc_id     = (known after apply)
          + vpc_region = (known after apply)
        }
    }

  # aws_route_table.privat_routing will be created
  + resource "aws_route_table" "privat_routing" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                 = "0.0.0.0/0"
              + nat_gateway_id             = (known after apply)
                # (11 unchanged attributes hidden)
            },
        ]
      + tags             = {
          + "Name" = "private_routing"
        }
      + tags_all         = {
          + "Env"  = "dev"
          + "Name" = "private_routing"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.public_routing will be created
  + resource "aws_route_table" "public_routing" {
      + arn              = (known after apply)
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                 = "0.0.0.0/0"
              + gateway_id                 = (known after apply)
                # (11 unchanged attributes hidden)
            },
        ]
      + tags             = {
          + "Name" = "Public Route"
        }
      + tags_all         = {
          + "Env"  = "dev"
          + "Name" = "Public Route"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.private_subnet1 will be created
  + resource "aws_route_table_association" "private_subnet1" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.public_subnet1 will be created
  + resource "aws_route_table_association" "public_subnet1" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.public_subnet2 will be created
  + resource "aws_route_table_association" "public_subnet2" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.sg will be created
  + resource "aws_security_group" "sg" {
      + arn                    = (known after apply)
      + description            = "dev-sg"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = (known after apply)
      + name                   = "dev-sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "dev-sg"
        }
      + tags_all               = {
          + "Env"  = "dev"
          + "Name" = "dev-sg"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group_rule.ingress["443"] will be created
  + resource "aws_security_group_rule" "ingress" {
      + cidr_blocks              = [
          + "192.168.0.0/16",
        ]
      + description              = "Allow traffic on port 443"
      + from_port                = 443
      + id                       = (known after apply)
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 443
      + type                     = "ingress"
    }

  # aws_security_group_rule.ingress["80"] will be created
  + resource "aws_security_group_rule" "ingress" {
      + cidr_blocks              = [
          + "192.168.0.0/16",
        ]
      + description              = "Allow traffic on port 80"
      + from_port                = 80
      + id                       = (known after apply)
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 80
      + type                     = "ingress"
    }

  # aws_subnet.private_subnet1 will be created
  + resource "aws_subnet" "private_subnet1" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "192.168.10.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "private_subnet_1"
        }
      + tags_all                                       = {
          + "Env"  = "dev"
          + "Name" = "private_subnet_1"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.public_subnet1 will be created
  + resource "aws_subnet" "public_subnet1" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1a"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "192.168.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "Public_Subnet1"
        }
      + tags_all                                       = {
          + "Env"  = "dev"
          + "Name" = "Public_Subnet1"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_subnet.public_subnet2 will be created
  + resource "aws_subnet" "public_subnet2" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = "us-east-1b"
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "192.168.2.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = true
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "Public_Subnet2"
        }
      + tags_all                                       = {
          + "Env"  = "dev"
          + "Name" = "Public_Subnet2"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.my_vpc will be created
  + resource "aws_vpc" "my_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "192.168.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = true
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "dev-vpc"
        }
      + tags_all                             = {
          + "Env"  = "dev"
          + "Name" = "dev-vpc"
        }
    }

  # aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4 will be created
  + resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
      + arn                    = (known after apply)
      + cidr_ipv4              = "0.0.0.0/0"
      + id                     = (known after apply)
      + ip_protocol            = "-1"
      + security_group_id      = (known after apply)
      + security_group_rule_id = (known after apply)
      + tags_all               = {
          + "Env" = "dev"
        }
    }

Plan: 23 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_eip.nat: Creating...
aws_vpc.my_vpc: Creating...
aws_eip.nat: Creation complete after 1s [id=eipalloc-0120253a6d7df24e8]
aws_vpc.my_vpc: Still creating... [10s elapsed]
aws_vpc.my_vpc: Creation complete after 11s [id=vpc-04a72423b5e13f47d]
aws_subnet.public_subnet1: Creating...
aws_subnet.private_subnet1: Creating...
aws_route53_zone.private: Creating...
aws_security_group.sg: Creating...
aws_lb_target_group.tg: Creating...
aws_subnet.public_subnet2: Creating...
aws_internet_gateway.internet_gateway: Creating...
aws_internet_gateway.internet_gateway: Creation complete after 1s [id=igw-07c90e887bb515456]
aws_route_table.public_routing: Creating...
aws_lb_target_group.tg: Creation complete after 1s [id=arn:aws:elasticloadbalancing:us-east-1:926788090244:targetgroup/dev-tg/5e4f68282a166e38]
aws_security_group.sg: Creation complete after 2s [id=sg-059f4318ff394193d]
aws_security_group_rule.ingress["443"]: Creating...
aws_route_table.public_routing: Creation complete after 1s [id=rtb-0f0d6a1b927b90f46]
aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4: Creating...
aws_security_group_rule.ingress["80"]: Creating...
aws_vpc_security_group_egress_rule.allow_all_traffic_ipv4: Creation complete after 0s [id=sgr-0a0fd8714a3164a73]
aws_security_group_rule.ingress["443"]: Creation complete after 0s [id=sgrule-2472616712]
aws_security_group_rule.ingress["80"]: Creation complete after 0s [id=sgrule-3093892472]
aws_subnet.public_subnet1: Still creating... [10s elapsed]
aws_route53_zone.private: Still creating... [10s elapsed]
aws_subnet.private_subnet1: Still creating... [10s elapsed]
aws_subnet.public_subnet2: Still creating... [10s elapsed]
aws_subnet.public_subnet1: Creation complete after 11s [id=subnet-06e432b8a5e6a6707]
aws_subnet.public_subnet2: Creation complete after 11s [id=subnet-00e11a461441daeb1]
aws_lb.elb: Creating...
aws_route_table_association.public_subnet2: Creating...
aws_route_table_association.public_subnet1: Creating...
aws_subnet.private_subnet1: Creation complete after 11s [id=subnet-029d4caae3d924fe6]
aws_nat_gateway.gw: Creating...
aws_route_table_association.public_subnet1: Creation complete after 1s [id=rtbassoc-09cb321a68b4fcde5]
aws_route_table_association.public_subnet2: Creation complete after 1s [id=rtbassoc-007b0d6f382802068]
aws_route53_zone.private: Still creating... [20s elapsed]
aws_lb.elb: Still creating... [10s elapsed]
aws_nat_gateway.gw: Still creating... [10s elapsed]
aws_route53_zone.private: Still creating... [30s elapsed]
aws_lb.elb: Still creating... [20s elapsed]
aws_nat_gateway.gw: Still creating... [20s elapsed]
aws_route53_zone.private: Still creating... [40s elapsed]
aws_lb.elb: Still creating... [30s elapsed]
aws_nat_gateway.gw: Still creating... [30s elapsed]
aws_route53_zone.private: Still creating... [50s elapsed]
aws_lb.elb: Still creating... [40s elapsed]
aws_nat_gateway.gw: Still creating... [40s elapsed]
aws_route53_zone.private: Still creating... [1m0s elapsed]
aws_lb.elb: Still creating... [50s elapsed]
aws_nat_gateway.gw: Still creating... [50s elapsed]
aws_route53_zone.private: Still creating... [1m10s elapsed]
aws_lb.elb: Still creating... [1m0s elapsed]
aws_nat_gateway.gw: Still creating... [1m0s elapsed]
aws_route53_zone.private: Creation complete after 1m19s [id=Z07772033L1FA1UGZ7Q8Q]
aws_lb.elb: Still creating... [1m10s elapsed]
aws_nat_gateway.gw: Still creating... [1m10s elapsed]
aws_lb.elb: Still creating... [1m20s elapsed]
aws_nat_gateway.gw: Still creating... [1m20s elapsed]
aws_lb.elb: Still creating... [1m30s elapsed]
aws_nat_gateway.gw: Still creating... [1m30s elapsed]
aws_lb.elb: Still creating... [1m40s elapsed]
aws_nat_gateway.gw: Still creating... [1m40s elapsed]
aws_lb.elb: Still creating... [1m50s elapsed]
aws_nat_gateway.gw: Still creating... [1m50s elapsed]
aws_lb.elb: Still creating... [2m0s elapsed]
aws_nat_gateway.gw: Still creating... [2m0s elapsed]
aws_nat_gateway.gw: Creation complete after 2m4s [id=nat-0150aa980aac89473]
aws_route_table.privat_routing: Creating...
aws_route_table.privat_routing: Creation complete after 1s [id=rtb-07b5e20634cd7a3ea]
aws_route_table_association.private_subnet1: Creating...
aws_route_table_association.private_subnet1: Creation complete after 0s [id=rtbassoc-0b9805527698ca5c3]
aws_lb.elb: Still creating... [2m10s elapsed]
aws_lb.elb: Still creating... [2m20s elapsed]
aws_lb.elb: Still creating... [2m30s elapsed]
aws_lb.elb: Creation complete after 2m32s [id=arn:aws:elasticloadbalancing:us-east-1:926788090244:loadbalancer/net/dev-alb/866ae69da3f93c2f]
aws_lb_listener.listener_80: Creating...
aws_lb_listener.listener_443: Creating...
aws_cloudwatch_metric_alarm.alert: Creating...
aws_route53_record.dev: Creating...
aws_lb_listener.listener_80: Creation complete after 0s [id=arn:aws:elasticloadbalancing:us-east-1:926788090244:listener/net/dev-alb/866ae69da3f93c2f/42e35f783e7bf6d8]
aws_cloudwatch_metric_alarm.alert: Creation complete after 0s [id=dev-alert]
aws_lb_listener.listener_443: Creation complete after 0s [id=arn:aws:elasticloadbalancing:us-east-1:926788090244:listener/net/dev-alb/866ae69da3f93c2f/563f9f862e6e3b1f]
aws_route53_record.dev: Still creating... [10s elapsed]
aws_route53_record.dev: Still creating... [20s elapsed]
aws_route53_record.dev: Creation complete after 23s [id=Z07772033L1FA1UGZ7Q8Q_dev.com_A]

Apply complete! Resources: 23 added, 0 changed, 0 destroyed.

==================

ssh ec2-user@54.162.247.12 -i ~/.ssh/dev-key.pem


List the AWS services used region wise.

[ec2-user@ip-10-0-2-52 scripts]$ python3 services_list.py
Services in use at us-east-1:
  - cloudwatch
  - ec2
  - elasticloadbalancing
  - events
  - payments
  - route53
  - s3

List each service in detail, like EC2, RDS etc:

[ec2-user@ip-10-0-2-52 scripts]$ python3 list_details_service_us-east1.py

Listing resources for region: us-east-1

EC2 Instances:
  - {'InstanceId': 'i-0a5c84d30efb4b974', 'State': 'running', 'InstanceType': 't2.micro', 'LaunchTime': '2025-01-19 09:25:22'}

S3 Buckets:
  - igork-bucket
  - terraform-state-dev365

RDS Instances:
  No resources found.

Lambda Functions:
  No resources found.
=============
