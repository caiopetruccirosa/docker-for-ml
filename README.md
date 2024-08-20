# docker-for-ml

This repository contains image descriptions for Python environments that can be executed inside a Docker container.

The datasets and work directories are accessed through volume bindings.

## Improvements

**TODO:**

<input type="checkbox" />: Modularize Dockerfile descriptions through base images and specific use case images.

<input type="checkbox" />: Remove unnecessary stuff from scripts.

## Commands

To build the container, execute this command:

```bash
./build_image.sh
```

To run the container, execute this command:

```bash
./run_container.sh
```

> **Observation:**
> If you are running the container remotely and want to access a Jupyter Notebook instance via browser locally, make a SSH tunnel between the `4321` ports:
> ```bash
> ssh -N -L 4321:localhost:4321 <remote_host>
> ```
