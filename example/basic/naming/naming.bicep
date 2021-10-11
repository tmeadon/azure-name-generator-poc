param env string
param loc string
param app string

output vnet string = replace(replace(replace('vnet-{env}-{loc}-{app}', '{env}', env), '{loc}', loc), '{app}', app)
output storage string = replace(replace(replace('stg{env}{loc}{app}', '{env}', env), '{loc}', loc), '{app}', app)
output vm string = replace(replace(replace('vm{env}{loc}{app}', '{env}', env), '{loc}', loc), '{app}', app)

