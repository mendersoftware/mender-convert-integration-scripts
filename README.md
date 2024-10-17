mender-convert-integration-scripts
==================================

Mender is an open source over-the-air (OTA) software updater for embedded Linux devices. Mender comprises a client running at the embedded device, as well as a server that manages deployments across many devices.

This repository contains mender-convert-integration-scripts, which is used to pre-generate binaries as needed for mender-convert.

![Mender logo](https://mender.io/user/pages/resources/06.digital-assets/mender.io.png)

## Getting started

To start using Mender, we recommend that you begin with the Getting started
section in [the Mender documentation](https://docs.mender.io/).

For more detailed information about `mender-convert` please visit the
[Debian family](https://docs.mender.io/2.0/artifacts/debian-family) section in
[the Mender documentation](https://docs.mender.io/).

## Docker environment for mender-convert-integration-scripts

To make using mender-convert-integration-scripts easier, a reference
setup using a Ubuntu 19.04 Docker container is provided.

You need to [install Docker Engine](https://docs.docker.com/install) to use this environment.


### Build the mender-convert container image

To build a container with all required dependencies for mender-convert-integration-scripts,
copy this directory to your workstation and change the current directory to it.

Then run

```bash
./docker-create-integration-binaries
```

This will create a container image that generates the appropriate binaries.  These will be left
in the output/ directory.

## Contributing

We welcome and ask for your contribution. If you would like to contribute to Mender, please read our guide on how to best get started [contributing code or documentation](https://github.com/mendersoftware/mender/blob/master/CONTRIBUTING.md).

## License

Mender is licensed under the Apache License, Version 2.0. See [LICENSE](https://github.com/mendersoftware/mender-crossbuild/blob/master/LICENSE) for the full license text.

## Security disclosure

We take security very seriously. If you come across any issue regarding
security, please disclose the information by sending an email to
[security@mender.io](security@mender.io). Please do not create a new public
issue. We thank you in advance for your cooperation.

## Connect with us

* Join the [Mender Hub discussion forum](https://hub.mender.io)
* Follow us on [Twitter](https://twitter.com/mender_io). Please
  feel free to tweet us questions.
* Fork us on [Github](https://github.com/mendersoftware)
* Create an issue in the [bugtracker](https://tracker.mender.io/projects/MEN)
* Email us at [contact@mender.io](mailto:contact@mender.io)
* Connect to the [#mender IRC channel on Libera](https://web.libera.chat/?#mender)


## Authors

Mender was created by the team at [Northern.tech AS](https://northern.tech), with many contributions from
the community. Thanks [everyone](https://github.com/mendersoftware/mender/graphs/contributors)!

[Mender](https://mender.io) is sponsored by [Northern.tech AS](https://northern.tech).
