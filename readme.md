# New-NamingBicep.ps1

This script creates a `bicep` module file that can be used to generate Azure resource names based on templates defined in an input file.  The script requires the following parameters:

- `TemplateJsonPath` - the path to an input file which defines name templates for each resource type
- `OutputFile` - the path to output the `bicep` module to (defaults to `naming.bicep`)

The file `name-templates-example.json` shows how the input file should be built - it should contain a single JSON object with a property for each resource type that names are required for.  The value of each property should be a string with tokens that will be replaced by parameters that will be passed into the `bicep` module.  The tokens should be surrounded by curly braces, e.g. `{env}`.  Each resource type defined in the input JSON will result in an output from the `bicep` module.

The resultant `bicep` module will have mandatory parameters for each of the unique tokens in the input file.  For example, take the following input file:

```json
{
    "vm": "vm-{env}-{location}-{app}",
    "storage": "stg{env}{location}{app}"
}
```

This will generate a `bicep` module with the parameters: `env`, `location` and `app`.  Passing the values `prd`, `uks` and `app1` into those parameters (respectively) will result in the following outputs from the module:

- `vm`: `vm-prd-uks-app1`
- `storage`: `stgprduksapp1`

The `example` directory contains an example showing how this can be used.  The file `example/naming/naming.bicep` was produced by running the following command:

```powershell
.\New-NamingBicep.ps1 -TemplateJsonPath .\example\naming\templates.json -OutputFile .\example\naming\naming.bicep
```
