secrets engines area plugins used by Vault to handle sensitive data
- store
- generate
- Encrypt

# Identity Engine
- maintians clients for Vault
- enable by default and cannot be disable or enable multiple

# cubbyhole
- enable by default and cannot be disable or enable multiple
- created per service token
- ONLY accessile by token

Secrets categories
Dynamic vs static secrets
static: store exiting data securely / manually lifecycle management / key/value engine
dynamic: generate data on demand / lease issued for each secret / automatic lifecycle management / consul engine

Transit Engine
Encryption as a service
does Not store data
supported action : encrypt/decrypt ; sign & verify ; generate hashes ; create random bytes
engine manage keys

e.g
vault secrets list
vault secrets enable [options] TYPE
vault secrets enable -path=GloboKV kv
vault secrets tune [option] PATH
vault secrets move [options] SOURCE DEST
vault secrets disable [options] PATH

# interacting with secrets engine
- authenticate with policy
- access through cli, ui or api
- standard commands - red, list, wreite and delete
- kv value uses: vault kv

e.g.
vault write ROLE_PATH [SETTINGS K=V]
vault wriet consul/roles/my-roles name=my-role policies=consul-policy

# interacting with kv engine

vault kv delete [PATH_to_token]
vault kv undelete [PATH_to_token]
vault kv destroy [PATH_to_token]
vault kv metadata delete [PATH_to_token]  #remove metadata will delete everything include

becoz delete is not destroy and can be retrieve back. 

# Response wrapping
<!-- request wrapping for any command -->
vault command -wrap-ttl=<duration> PATH
vault kv get -wrap-ttl=<duration> testKV/apikeys/d101

<!-- unwrap using the issued token -->
vault unwrap [options] [TOKEN]
vault unwrap xxxxx

vault lease renew [OPTION] ID
vault lease revoke [OPTION] ID
