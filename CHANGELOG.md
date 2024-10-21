# Changelog

## [1.0.0] - 2024-07-10

## [1.1.0] - 2024-07-14

## [1.1.1] - 2024-07-14

## [1.2.0] - 2024-09-01

## [1.2.1] - 2024-09-01

## [1.2.2] - 2024-10-05

## [2.0.0] - 2024-10-06

INTERFACE CHANGED:

- `QueryClient.getQueue` now takes device name as argument instead of serial/type.
- `QueryClient.getDeviceList` no longer filters devices.

## [2.1.0] - 2024-10-07

Added Device.empty factory and accompanying Device.isEmpty getter.
This accounts for cases where the Device list in the config is empty.

## [2.2.0] - 2024-10-09

Added ability to change logger function (defaults to print with AlexaQuery\[$level\] prefix)

## [3.0.0] - 2024-10-21

Each method will now attempt to login, if the client is not already, if `loginToken` is passed to the class initializer.

INTERFACE CHANGED:

- `QueryClient.new` no longer throws if cookie file doesn't exist, instead creates it. (Will still throw if path doesn't exist)
- `QueryClient.getDeviceList` has been renamed to `QueryClient.getDevices`.
- `QueryClient.checkStatus` has been renamed to `QueryClient._checkStatus` and is no longer accessible from outside the class.
