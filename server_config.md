## What is Vault
secrets lifecycle manager
written in Go
multiple operating system
same binary for clinet/server
everything through the API

Concepts
**Authentication 
**Policy
**Secrets - plug in
** audit

## Interacting with Vault
dl vault -> start vault -> access to it

# installation
*windows - use chocolatey
choco install vault

*mac - use hombrew
brew tap hashicorp/tap
brew install haishcorp/tap/vault

*linux - any package manaer
curl 
sudo 

# Use dev mode
- running on localhost without ssl
- in memory storage
- starts unsealed
- UI enabled
- key/value secrets engine enables

how to start dev server
# launch valut in dev mode
$ vault server -dev

$ vault server -config=config_file.hcl  # full mode


# store vault server address in env vriable
* linux /mac OS
export VAULT_ADDR =http://127.0.0.1:8200

* windows
$env:VAULT_ADDR="http://127.0.0.1:8200"

basic command
vault server -dev

# need to set up env to HTTP
PowerShell:
    $env:VAULT_ADDR="http://127.0.0.1:8200"
cmd.exe:
    set VAULT_ADDR=http://127.0.0.1:8200

vault login

only way to interact with Vault is Vault api
token required, curl with x-vault-token header

curl --header "x-Vault-token: $root_token" --request GET \
$VAULT_ADDR/v1/sys/host -info


# Authentication Methods
Provided by Plug-in
multiple methods allowed
external sources: LDAP, GH, IAM, etc
userpass and appRole are internal
token method is enabled by default
mounted on the path/auth
used to obtain a token

## how to choose auth method
Q: who is going to access Vault ? human? service account?
how are they going to access it ? external?
what do they use today ?  gh? cert?

options:
username & password - meant for human operators

## configure an auth method
all methods area enabled on /sys/auth
methods are enabled on a path  - default to method name
methods can be tuned and confgured

Command
vault auth 
vault auth enable [options] type
vault auth enalbe -path=globopass userpass
vault auth tune [options] Path
vault auth tune -description='first userpass' globopass/
vault auth disable [options] PATH
vault auth disable globopass/

----
### Use case

1. Enable userpass and app role

$vault auth enable userpass
Success! Enabled userpass auth method at: userpass/

$vault auth enable -path=GlobalAppRole/ approle
Success! Enabled approle auth method at: GlobalAppRole/

2. configure both methods - all path base

e.g userpass
create a key pair user/password
$vault write auth/userpass/users/user1 password=adm123

e.g approle
vault write auth/GlobalAppRole/role/webapp role_name="webapp" secret_id_num_users=1 secret_id_ttl=2h



3. log in with both methods
Login using a token
Login using an auth method
e.g. vault login -mehtod=userpass username=xxx

e.g. how to use approle
1. define the role id - [make sure its on the root permission - use token to login first]

$vault read auth/GlobalAppRole/role/webapp/role-id  
Key        Value
---        -----
role_id    d2b1b776-44bf-a4e7-fb59-17dd02122c5b

2. get the secret_id, since we are generating data, write is used instead of read

$vault write -force auth/GlobalAppRole/role/webapp/secret-id
Key                   Value
---                   -----
secret_id             d9c9cb7d-c961-4f71-2e31-bc12767e5de3
secret_id_accessor    c22c71d6-d0d6-a711-fdfc-d392c4a01e5e
secret_id_ttl         2h

3. login 
$vault write auth/GlobalAppRole/login role_id=d2b1b776-44bf-a4e7-fb59-17dd02122c5b secret_id=d9c9cb7d-c961-4f71-2e31-bc12767e5de3


4. disable one
$vault auth disable GlobalAppRole/
