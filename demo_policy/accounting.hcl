path "secrets/accounting/data/*" {
    capabilities = ["create","read","update","delete","list"]
}

path "accounting/metadata/data/*"{
    capabilities=["list"]
}

path "accounting/data/apitokens/privileged*"{
    capabilities=["deny"]
}

path "accounting/metadata/apitokens/privileged*"{
    capabilities=["deny"]
}