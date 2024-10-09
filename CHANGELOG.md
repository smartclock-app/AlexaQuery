# Changelog

## [1.0.0] - 2024-07-10

## [1.1.0] - 2024-07-14

## [1.1.1] - 2024-07-14

## [1.2.0] - 2024-09-01

## [1.2.1] - 2024-09-01

## [1.2.2] - 2024-10-05

## [2.0.0] - 2024-10-06

INTERFACE CHANGED:

- client.getQueue now takes device name as argument instead of serial/type.
- client.getDevices no longer filters devices.

## [2.1.0] - 2024-10-07

Added Device.empty() factory and accompanying Device.isEmpty getter.
This accounts for cases where the Device list in the config is empty.

## [2.2.0] - 2024-10-09

Added ability to change logger function (defaults to print with AlexaQuery\[$level\] prefix)
