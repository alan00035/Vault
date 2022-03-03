# demo
create a vault service token
obtain tokens from auth methods
create a batch token
renew and revoke tokens
create a periodic token


vault token create -policy=default -ttl=60m

vault token lookup [token_ID]
vault token lookup -accessor [accessor_ID]
vault token revoke -accessor [accessor_ID]


# Service or Batch
Service
fully featured, heavyweight
managed by accessor or ID
written to persistent storage
calculated lifetime
renewable if desired
can create child tokens
default type for most situation
start with "s."in ID


Batch
limited features, lightweight
has no accessor
not written to storage
static lifetime
never renew
no child tokens
explicity in creation
start with "b."in id

## create batch token
vault token create -type=batch -policy=default -ttl=30m



# Token Lifetime
token ttl / max ttl / token renewal / periodic token
*ttl time to live

vault token renew [options] [ACCESSOR | ID] [-increment=<duration>]

vault auth enable -max-lease-ttl=776h userpass