output "proxy_instance_ids" {
  value = aws_instance.proxy[*].id
}

output "backend_instance_ids" {
  value = aws_instance.backend[*].id
}
