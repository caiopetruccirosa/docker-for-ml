# remote-docker-for-ml

The Jupyter Notebook environment is executed inside a Docker container.
The datasets and notebooks folders are accessed through volume bindings.

To build the container, execute this command:

```bash
./build_image.sh
```

To run the container, execute this command:

```bash
./run_container.sh <abs_path_to_notebooks_folder> <abs_path_to_datasets_folder>
```

When running the container remotely, make a SSH tunnel between the `4321` ports:

```bash
ssh -N -L 4321:localhost:4321 <remote_host>
```