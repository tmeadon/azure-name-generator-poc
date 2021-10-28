param namingComponents object

output vnet string = replace(replace(replace('vnet-{env}-{loc}-{app}', '{env}', namingComponents.env), '{loc}', namingComponents.loc), '{app}', namingComponents.app)
output storage string = replace(replace(replace('stg{env}{loc}{app}', '{env}', namingComponents.env), '{loc}', namingComponents.loc), '{app}', namingComponents.app)
output vm string = replace(replace(replace('vm{env}{loc}{app}', '{env}', namingComponents.env), '{loc}', namingComponents.loc), '{app}', namingComponents.app)

