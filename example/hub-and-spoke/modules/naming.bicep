param namingComponents object

output bastion string = replace(replace(replace('bst-{env}-{location}-{app}', '{env}', namingComponents.env), '{location}', namingComponents.location), '{app}', namingComponents.app)
output vnet string = replace(replace(replace('vnet-{env}-{location}-{app}', '{env}', namingComponents.env), '{location}', namingComponents.location), '{app}', namingComponents.app)
output firewallPip string = replace(replace(replace('fw-{env}-{location}-{app}-pip', '{env}', namingComponents.env), '{location}', namingComponents.location), '{app}', namingComponents.app)
output bastionPip string = replace(replace(replace('bst-{env}-{location}-{app}-pip', '{env}', namingComponents.env), '{location}', namingComponents.location), '{app}', namingComponents.app)
output firewall string = replace(replace(replace('fw-{env}-{location}-{app}', '{env}', namingComponents.env), '{location}', namingComponents.location), '{app}', namingComponents.app)

