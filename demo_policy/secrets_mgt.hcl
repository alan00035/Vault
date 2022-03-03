# manage secrets engines, this is the root permission, it doesNOT work if sudo doesnt involve
path "sys/mounts/*"{
    capabilities = ["create","update","delete","read","list","sudo"]
}

# list the existing engines
path "sys/mounts" {
    capabilities =["read"]
}