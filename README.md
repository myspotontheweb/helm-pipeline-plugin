# helm-pipeline-plugin

Helm plugin designed to generate the files required for CI/CD

# Software Dependencies

On Ubuntu

```
sudo apt-get install -y make git gettext-base
```

On Mac

```
brew install make git gettext
```

# Installation

```
helm plugin install https://github.com/myspotontheweb/helm-pipeline-plugin.git
```

or to update an existing installation

```
helm plugin update pipeline
```

# Usage

To generate the project files run the plugin as follows

```
helm pipeline NAME=my-project NAMESPACE=myteam PORT=9001
```

## Recreating files

You can regenerate the files by first deleting them

```
$ helm pipeline clean
rm -rf chart
rm -f Dockerfile
rm -f .travis.yml

$ helm pipeline NAME=my-project NAMESPACE=myteam PORT=9001 STARTER=go ORG=Teamwork
Creating myproject
cat chart/.ci/Dockerfile | envsubst '$NAME $FILTERED_NAME $NAMESPACE $PORT' > Dockerfile
cat chart/.ci/.travis.yml | envsubst '$NAME $FILTERED_NAME $NAMESPACE $PORT' > .travis.yml
```

## Remove caching

Helm chart starter packs are stored under the helm client homedir: ~/.helm/starters

```
$ helm pipeline clean-starter STARTER=go
rm -rf /home/mark/.helm/starters/go
```

# Starter packs

The plugin uses [helm starter packs](https://helm.sh/docs/developing_charts/#chart-starter-packs) to customize the build and deployment for each technology area.

To customize the file generation you can optionally specify the ORG and STARTER settings: 

```
helm pipeline NAME=my-project NAMESPACE=myteam PORT=9001 ORG=myspotontheweb STARTER=go
```

This will tell the plugin to download the default starter pack located here: 

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
