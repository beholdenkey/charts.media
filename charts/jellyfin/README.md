# jellyfin

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 10.8.10](https://img.shields.io/badge/AppVersion-10.8.10-informational?style=flat-square)

Jellyfin Helm chart
**Homepage:** <https://jellyfin.org>

## Values

| Key                                           | Type   | Default                                  | Description                                                                                                                               |
| --------------------------------------------- | ------ | ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| additionalPorts                               | list   | `[]`                                     | Additional port definitions for the pod                                                                                                   |
| additionalServicePorts                        | list   | `[]`                                     | Additional port definitions for the service                                                                                               |
| affinity                                      | object | `{}`                                     | Affinity for the pod assignment                                                                                                           |
| autoscaling.enabled                           | bool   | `false`                                  |                                                                                                                                           |
| autoscaling.maxReplicas                       | int    | `100`                                    |                                                                                                                                           |
| autoscaling.minReplicas                       | int    | `1`                                      |                                                                                                                                           |
| autoscaling.targetCPUUtilizationPercentage    | int    | `80`                                     |                                                                                                                                           |
| autoscaling.targetMemoryUtilizationPercentage | int    | `80`                                     |                                                                                                                                           |
| dnsConfig                                     | object | `{}`                                     | DNS configuration for the pod                                                                                                             |
| dnsPolicy                                     | string | `"ClusterFirst"`                         | DNS policy for the pod                                                                                                                    |
| env                                           | object | `{}`                                     | Non-sensitive environment variables to be set in the pods. See the [application docs](https://docs.linuxserver.io/images/docker-jellyfin) |
| extraVolumeMounts                             | object | `{}`                                     | Arbitrary extra volume mounts for the pod                                                                                                 |
| extraVolumes                                  | list   | `[]`                                     | Arbitrary extra volume definitions for the pod                                                                                            |
| fullnameOverride                              | string | `""`                                     | String to fully override fullname template with a string                                                                                  |
| hostNetwork                                   | bool   | `false`                                  | Use host network                                                                                                                          |
| hostPort.enabled                              | bool   | `false`                                  | Use host port for the application                                                                                                         |
| hostPort.port                                 | int    | `8096`                                   | Host port to bind to                                                                                                                      |
| image.pullPolicy                              | string | `"IfNotPresent"`                         | Image pull policy                                                                                                                         |
| image.repository                              | string | `"docker.io/linuxserver/jellyfin"`       | Image repository                                                                                                                          |
| image.tag                                     | string | `""`                                     | Image tag (if not specified, defaults to the chart's appVersion)                                                                          |
| imagePullSecrets                              | list   | `[]`                                     | Image pull secrets                                                                                                                        |
| ingress.annotations                           | object | `{}`                                     | Annotations for the ingress                                                                                                               |
| ingress.className                             | string | `""`                                     | Ingress class name                                                                                                                        |
| ingress.enabled                               | bool   | `false`                                  | Expose the app using an ingress                                                                                                           |
| ingress.hosts                                 | list   | see [values.yaml](values.yaml)           | Ingress hosts configuration                                                                                                               |
| ingress.tls                                   | list   | `[]`                                     | The TLS configuration for the Ingress                                                                                                     |
| initContainers                                | list   | `[]`                                     | Init containers                                                                                                                           |
| livenessProbe                                 | object | `{}`                                     | Pod liveness probe                                                                                                                        |
| nameOverride                                  | string | `""`                                     | String to partially override fullname template with a string (will prepend the release name)                                              |
| nodeSelector                                  | object | `{}`                                     | The node selector for the deployment                                                                                                      |
| persistence.config.accessModes                | list   | `["ReadWriteOnce"]`                      | Config: Access modes for the claim                                                                                                        |
| persistence.config.annotations                | object | `{}`                                     | Config: Annotations for the claim                                                                                                         |
| persistence.config.customVolume               | object | `{}`                                     | Config: Alternative data volume definition (e.g. nfs, hostPath). Used when `persistence.config.isPvc` is `false`                          |
| persistence.config.enabled                    | bool   | `true`                                   | Config: Enable persistence                                                                                                                |
| persistence.config.existingClaim              | string | `""`                                     | Config: Name of the existing claim to be used for config                                                                                  |
| persistence.config.isPvc                      | bool   | `true`                                   | Config: Persistence type is pvc. When `false`, data volume definition is read from `persistence.config.customVolume`                      |
| persistence.config.size                       | string | `"2Gi"`                                  | Config: Size for the claim                                                                                                                |
| persistence.config.storageClass               | string | `""`                                     | Config: Storage class for the volume                                                                                                      |
| persistence.data.accessModes                  | list   | `["ReadWriteOnce"]`                      | Data: Access modes for the claim                                                                                                          |
| persistence.data.annotations                  | object | `{}`                                     | Data: Annotations for the claim                                                                                                           |
| persistence.data.customVolume                 | object | `{}`                                     | Data: Alternative data volume definition (e.g. nfs, hostPath). Used when `persistence.data.isPvc` is `false`                              |
| persistence.data.enabled                      | bool   | `false`                                  | Data: Enable persistence                                                                                                                  |
| persistence.data.existingClaim                | string | `""`                                     | Data: Name of the existing claim to be used                                                                                               |
| persistence.data.isPvc                        | bool   | `true`                                   | Data: Persistence type is pvc. When `false`, data volume definition is read from `persistence.data.customVolume`                          |
| persistence.data.size                         | string | `"64Gi"`                                 | Data: Size for the claim                                                                                                                  |
| persistence.data.storageClass                 | string | `""`                                     | Data: Storage class for the data volume                                                                                                   |
| podAnnotations                                | object | `{}`                                     | Annotations for the pods                                                                                                                  |
| podSecurityContext                            | object | `{}`                                     | Security context for the pods                                                                                                             |
| port                                          | int    | `8096`                                   |                                                                                                                                           |
| readinessProbe                                | object | `{"httpGet":{"port":"http"}}`            | Pod readiness probe                                                                                                                       |
| replicaCount                                  | int    | `1`                                      | Number of replicas to run. Chart is not designed to scale horizontally, use at your own risk                                              |
| resources                                     | object | `{}`                                     | The resource requests and limits of the container                                                                                         |
| secretEnv                                     | object | `{}`                                     | Sensitive environment variables to be set in the pods. See the [application docs](https://docs.linuxserver.io/images/docker-jellyfin)     |
| securityContext                               | object | `{"capabilities":{"add":["NET_ADMIN"]}}` | Security context for the container. NET_ADMIN capability is required for the VPN to work properly.                                        |
| service.port                                  | int    | `8096`                                   | Port for the service to use                                                                                                               |
| service.type                                  | string | `"ClusterIP"`                            | Type of the service                                                                                                                       |
| serviceAccount.annotations                    | object | `{}`                                     | Annotations to add to the service account                                                                                                 |
| serviceAccount.create                         | bool   | `true`                                   | Specifies whether a service account should be created                                                                                     |
| serviceAccount.name                           | string | `""`                                     | The name of the service account to use. If not set and create is true, a name is generated using the fullname template                    |
| sidecarContainers                             | list   | `[]`                                     | Sidecar containers                                                                                                                        |
| strategy                                      | object | `{"type":"Recreate"}`                    | Deployment strategy                                                                                                                       |
| tolerations                                   | list   | `[]`                                     | Tolerations for the pod assignment                                                                                                        |

> **Tip**
> You can use the default [values.yaml](values.yaml)

> **Note**
> The chart offers a neutral configuration approach by directly passing environment variables into the container via the env and secretEnv settings. This eliminates the need to individually map each configuration parameter to a specific chart parameter, thereby offering greater flexibility in configuration.

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

### Upgrading to a New Major Release Version

A transition to a new major version of the chart (e.g., from 1.2.0 to 2.0.0) signifies the presence of breaking changes that are incompatible with previous versions and may require manual intervention.

### Transitioning from Version 1.x to 2.x

In Version 2.x, the application architecture has been updated to use a Deployment model instead of a StatefulSet.

The `values` section has undergone significant refactoring, particularly in the `persistence` subsection.

Due to these changes, it is highly recommended to initiate the upgrade with a fresh install.

## Maintainers

| Name          | Email                    | Url |
| ------------- | ------------------------ | --- |
| Justin Bailey | <justthered63@gmail.com> |     |

## Source Code

- <https://github.com/linuxserver/docker-jellyfin>
- <https://hub.docker.com/r/linuxserver/jellyfin>
- <https://github.com/beholdenkey/charts.jellyfin>
