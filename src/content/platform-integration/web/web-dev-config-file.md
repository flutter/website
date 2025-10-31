---
title: Set up a web development configuration file
shortTitle: Web development configuration
description: >-
  Centralize web development settings including a development proxy
---

# Set up a web development configuration file
**By Sydney Bao**

Flutter web includes a development server that defaults to
serving your application in the `localhost` domain using HTTP
on a randomly assigned port. While command-line arguments offer
a quick way to modify the server's behavior,
this document focuses on a more structured approach:
defining your server's behavior through a centralized `web_dev_config.yaml` file.
This configuration file allows you to
customize server settings&emdash;host, port, HTTPS settings, and
proxy rules&emdash;ensuring a consistent development environment.

## Create a configuration file

Add a `web_dev_config.yaml` file to the root directory of your Flutter project.
If you haven't set up a Flutter project,
visit [Building a web application with Flutter][] to get started.

[Building a web application with Flutter]: /platform-integration/web/building

## Add configuration settings

### Basic server configuration

You can define the host, port, and HTTPS settings for your development server.

```yaml title="web_dev_config.yaml"
server:
  host: "0.0.0.0" # Defines the binding address <string>
  port: 8080 # Specifies the port <int> for the development server
  https:
    cert-path: "/path/to/cert.pem" # Path <string> to your TLS certificate
    cert-key-path: "/path/to/key.pem" # Path <string> to TLS certificate key
```

### Custom headers

You can also inject custom HTTP headers into the development server's responses.

```yaml title="web_dev_config.yaml"
server:
  headers:
    - name: "X-Custom-Header" # Name <string> of the HTTP header
      value: "MyValue" # Value <string> of the HTTP header
    - name: "Cache-Control"
      value: "no-cache, no-store, must-revalidate"
```

### Proxy configuration

Requests are matched in order from the `web_dev_config.yaml` file.

#### Basic string proxy

Use the `prefix` field for simple path prefix matching.

```yaml title="web_dev_config.yaml"
server:
  proxy:
    - target: "http://localhost:5000/" # Base URL <string> of your backend
      prefix: "/users/" # Path <string>
    - target: "http://localhost:3000/"
      prefix: "/data/"
      replace: "/report/" # Replacement <string> of path in redirected URL (optional)
    - target: "http://localhost:4000/"
      prefix: "/products/"
      replace: ""
```

**Explanation:**

*   A request to `/users/names` is
    forwarded to `http://localhost:5000/users/names`.
*   A request to `/data/2023/` is
    forwarded to `http://localhost:3000/report/2023`
    because `replace: “/report/”` replaces the `/data/` prefix.
*   A request to `/products/item/123` is
    forwarded to `http://localhost:4000/item/123` because `replace: ""`
    removes the `/products/` prefix by replacing it with an empty string.

#### Advanced regex proxy

You can also use the `regex` field for more flexible and complex matching.

```yaml title="web_dev_config.yaml"
server:
  proxy:
    - target: "http://localhost:5000/"
      regex: "/users/(\d+)/$" # Path <string> matches requests like /users/123/
    - target: "http://localhost:4000/"
      regex: "^/api/(v\d+)/(.*)" # Matches requests like /api/v1/users
      replace: "/$2?apiVersion=$1" # Allows capture groups (optional)
```

**Explanation:**

*   A request to `/users/123/` matches the first rule exactly,
    so it is forwarded to `http://localhost:5000/users/123/`.
*   A request to `/api/v1/users/profile/` starts with the second rule path
    so it is forwarded to `http://localhost:4000/users/profile/?apiVersion=v1`.

## Configuration precedence

Remember the order of precedence for settings:

1. **Command-line arguments** (such as `--web-hostname`, `--web-port`)
2. **`web_dev_config.yaml` settings**
3. **Built-in default values**
