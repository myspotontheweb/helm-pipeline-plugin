# helm-pipeline-plugin

Helm plugin designed to generate the files required for CI/CD

# Installation

```
#
# Install additional software (Subsitute appropriate OS commands)
#
sudo apt-get install -y make git

#
# Install plugin
#
helm plugin install https://github.com/myspotontheweb/helm-pipeline-plugin.git
```

or to update an exiting installation

```
helm plugin update pipeline
```

# Usage

To generate the project files run the plugin as follows

```
helm pipeline generate
```

Can optionally supply an alternative name and container port number for the container

```
helm pipeline generate NAME=my-project PORT=9001 NAMESPACE=desk
```

## Regenerate

To regenerate all the files

```
helm pipeline clean generate NAME=my-project
```

## Starter packs

The plugin uses [helm starter packs](https://helm.sh/docs/developing_charts/#chart-starter-packs) to customize the build and deployment for each technology area.

```
helm pipeline generate NAME=my-project STARTER=go
```

Each starter pack is maintained in it's own repository. The following are currently supported:

* [myspotontheweb/helm-go-starter](https://github.com/myspotontheweb/helm-go-starter) (This is the default)
