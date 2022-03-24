# config
Application specific config files/templates live here.

-----

**NOTE**
You SHOULD delete all the files in this directory and add the configuration
files that are specific to YOUR application.

-----

Config files can be of any type that the application requires. Each file is considered a [Jinja2](https://jinja.palletsprojects.com/en/2.11.x/) template and has access to a variety of variables from the `config.yml` file, the other application setup files and secrets stored in Vault.

## Variable Access
All variables in the `params` section of a config file in `config.yml` can be accessed using the `params` base variable. Example: `params.myVar1`

**Secrets** stored in Vault can be accessed using the `secrets` base variable. 
Example: `secrets.myDbPasswd`

For more information on managing secrets in Vault for an application, see the *Managing Secrets* section below.

Variables in the other application YAML files can be accessed using the `app_<NAME>` base variable where `NAME` is the name of the YAML file w/o the `.yml` suffix. 

For example: To access the `users` variable in the `system.yml` file you would
address it as`app_system.users`

## Managing Secrets
Secrets for your application should be stored in Vault. Secrets are stored on a per file basis. Secrets are stored in application specific paths: `secret/applications/<ENV>/<APP>/<FILENAME>`.

* ENV: The environment. dev|qa|stage|perf|prod
* APP: The application name.
* FILENAME: The name of the config file for the application.

For example: The `tsunami-ref-app` (this app) has a config file named `default.json`.
Any secrets for `default.json` should be stored in Vault at the path: `secret/applications/ENV/tsunami-ref-app/default.json`. The filename portion of the Vault path should match the actual name of the file at it's final destination. So, if the config file settings specify a `dest_name`, use `dest_name`; otherwise use the `name` setting.

These secrets can then be referenced in your config file template using the `secrets` variable.
For example, a secret named `apiKey` can be can accessed like this: `secrets.apiKey`

## Special Cases 
### systemd Unit Files
A file with the extension `.service` is assumed to be systemd unit file and will be automatically enabled so that your application starts on boot.
