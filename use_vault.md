# Vault Policy
- define permssion in Vault
assignment - token, identity, auth methods
No versioning -overwrite the previous version

specific:
Default policy - create when Vault is create
Root policy - associtate with root token, cannt be removed or changed

default:
default.hcl

#allow tokens to look up their own properties
allow tokens to renew/revoke themselives
allow a token to look up its own capabilities on a path
allow a token to look up its own entity by id or name

Policy Syntax
HCL or JSON
*Path  *Capabilities

e.g.
Path "somepath/in/vault"
1. using the glob "*"
Q: Match "secrets/globo/web1/" and"secrets/globo/webapp/apikeys"

path "secrets/globo/web*"

2. using the path segment match "+"
Q: Match "secrets/globo/webapp1/apikeys" and "secrets/globo/webapp2/apikeys"

path "secrets/globl/+/apikeys"

3. using a parameter

path "secrets/{{identity.entity.name}}/*"

Capability example
1. allow read access
path "secrets/globl/+/apikey" {
    capabilities = ["create", "read","update","delete"]
}


## Assign policy
1. directly on token when created
2. applied throught an auth method
3. assigned to an entities


vault policy list
vault policy read [options] NAME
vault policy write [options] NAME PATH | <stdin>
vault policy write secrets-management secrets-mgmt.hcl
vault policy delete [options] NAME
valut policy NAME fmt