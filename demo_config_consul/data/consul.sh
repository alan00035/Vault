consul agent -bootstrap -config-file="consul-config.hcl" -bind=127.0.0.1

#run this on a seperae terminal
consul acl bootstrap

#set value
export CONSUL_HTTP_TOKEN=SECRETID_VALUE

#windos
$env:CONSUL_HTTP_TOKEN="SECRETID_VALUE"

#create a policy and role for new tokens
consul acl policy create -name=web -rules @web-policy.hcl


#configure
consul path-help consul/

consult path-help consul/config/access

vault write consul/config/access address="127.0.0.1:8200" token-$CONSUL_HTTP_TOKEN

#add a role to provision token with a ttl of an hour and a max of 2hs
vault write consul/roles/web name=web policies=web ttl=3600 max_ttl=7200

#check token status
consul acl token list -format=json | jq .[].AccessorID