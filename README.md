# helm-pipeline-plugin

Helm plugin designed to generate the files required for CI/CD

# Installation

```
#
# Install additional software (Substitute appropriate OS commands)
#
sudo apt-get install -y make git

#
# Install plugin
#
helm plugin install https://github.com/myspotontheweb/helm-pipeline-plugin.git
```

or to update an existing installation

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
helm pipeline generate NAME=my-project NAMESPACE=myteam PORT=9001
```

## Cleanup

Remove all generated files:

```
$ helm pipeline clean-all
rm -rf chart
rm -f Dockerfile
rm -f .travis.yml
rm -rf /home/mark/.helm/starters/go
```

# Starter packs

The plugin uses [helm starter packs](https://helm.sh/docs/developing_charts/#chart-starter-packs) to customize the build and deployment for each technology area.

```
helm pipeline generate NAME=my-project NAMESPACE=myteam PORT=9001 STARTER=go ORG=myspotontheweb
```

Each starter pack is maintained in it's own repository. The following are currently supported by the author:

* [myspotontheweb/helm-go-starter](https://github.com/myspotontheweb/helm-go-starter) 

## Starter pack structure

A starter pack is expected to contain the normal files associated with a helm chart plus
an additional directory container files used for building and deployment

```
├── charts
├── Chart.yaml
├── README.md
├── templates
│   ├── ..
│   └── ..
├── values.yaml
└── .ci
    ├── Dockerfile
    └── .travis.yml
```
