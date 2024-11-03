# Changelog

## 4.0.1

Make `Queue` non-final.
Parse `Memory` from `QueryClient.getMemories`.

## 4.0.0

Added `QueryClient.getMemories` to get the memories (notes) list.

INTERFACE CHANGED:

`QueryClient.getQueue` data changed from Alexa's `/api/np/player` to `/api/np/list-media-sessions`.
This mirrors the data structure of the Alexa app and allows for more accurate queue information.

## 3.0.3

`QueryClient._lastSuccessfulLogin` has been renamed to `QueryClient._lastLogin`.
`QueryClient._lastLogin` is updated on every login attempt, successful or not.
Now the client will only attempt a login if the last login was more than 15 seconds ago.

## 3.0.2

`QueryClient.lastSuccessfulLogin` has been renamed to `QueryClient._lastSuccessfulLogin` and is no longer accessible from outside the class.

## 3.0.1

Ensure `QueryClient._checkStatus` is only being called once within 15 seconds.
This allows multiple multiple methods to share the same login attempt.

## 3.0.0

Each method will now attempt to login, if the client is not already, if `loginToken` is passed to the class initializer.

INTERFACE CHANGED:

- `QueryClient.new` no longer throws if cookie file doesn't exist, instead creates it. (Will still throw if path doesn't exist)
- `QueryClient.getDeviceList` has been renamed to `QueryClient.getDevices`.
- `QueryClient.checkStatus` has been renamed to `QueryClient._checkStatus` and is no longer accessible from outside the class.

## 2.2.0

Added ability to change logger function (defaults to print with AlexaQuery\[$level\] prefix)

## 2.1.0

Added Device.empty factory and accompanying Device.isEmpty getter.
This accounts for cases where the Device list in the config is empty.

## 2.0.0

INTERFACE CHANGED:

- `QueryClient.getQueue` now takes device name as argument instead of serial/type.
- `QueryClient.getDeviceList` no longer filters devices.

## 1.2.2

## 1.2.1

## 1.2.0

## 1.1.1

## 1.1.0

## 1.0.0
