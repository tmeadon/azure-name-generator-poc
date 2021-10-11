param env string
param location string
param app string

output firewall string = replace(replace(replace('fw-{env}-{location}-{app}', '{env}', env), '{location}', location), '{app}', app)
output firewallPip string = replace(replace(replace('fw-{env}-{location}-{app}-pip', '{env}', env), '{location}', location), '{app}', app)
output vnet string = replace(replace(replace('vnet-{env}-{location}-{app}', '{env}', env), '{location}', location), '{app}', app)
output bastion string = replace(replace(replace('bst-{env}-{location}-{app}', '{env}', env), '{location}', location), '{app}', app)
output bastionPip string = replace(replace(replace('bst-{env}-{location}-{app}-pip', '{env}', env), '{location}', location), '{app}', app)

