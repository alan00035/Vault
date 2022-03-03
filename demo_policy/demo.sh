# create policy
# generate a token with a policy
# update the policy
# delete the policy

# set up the vault env first, expect only default & root
vault policy list

# create a new policy 
vault policy write secrets_mgt  secrets_mgt.hcl


# create some tokens under the path to access to 
vault secrets enable -path=accounting -version=2 kv
vault kv put accounting/apitokens/d101 token=123456
vault kv put accounting/apitokens/d102 token=123456
vault kv put accounting/apitokens/d103 token=123456
vault kv put accounting/apitokens/privileged/p101 token=123456

# Q create a policy access to the regular token and exclude from priviledge one
applied accounting.hcl from cli or console

# assign the police
# associate directly with a token
vault token create -policy="secrets_magt"

# assign to a user in userpass
vault write auth/userpass/users/username token_policies="secrets_mgt"

# assign to an entity in identity
vault write identity/entiey/name/username policies="secrete_mgt"