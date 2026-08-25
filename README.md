# react-native-reverse-geocoding

Native reverse geocoding for React Native using CLGeocoder on iOS and android.location.Geocoder on Android — no REST APIs or API keys.

## Installation


```sh
npm install react-native-reverse-geocoding
```


## Usage

```js
import { reverseGeocodeAsync } from 'react-native-reverse-geocoding';

const addresses = await reverseGeocodeAsync(37.4219983, -122.084);
const [address] = addresses;

console.log(address?.formattedAddress);
// e.g. "1600 Amphitheatre Parkway, Mountain View, CA 94043, United States"
```

### `reverseGeocodeAsync(latitude, longitude)`

Resolves an array with zero or one `Address` object (empty when the OS
geocoder finds nothing for that coordinate):

```ts
type Address = {
  city: string | null;
  region: string | null;
  country: string | null;
  isoCountryCode: string | null;
  postalCode: string | null;
  street: string | null;
  streetNumber: string | null;
  subregion: string | null;
  name: string | null;
  formattedAddress: string | null;
};
```

`formattedAddress` is pre-formatted by the OS itself (`Address#getAddressLine`
on Android, `CNPostalAddressFormatter` on iOS) and generally more complete
than joining the individual fields — the discrete fields can be sparse
depending on region (e.g. missing street number).

### Permissions

This module only performs reverse geocoding — it does not read the device's
location. If you're pairing it with a geolocation library, add the usual
location permissions to your app:

- iOS: `NSLocationWhenInUseUsageDescription` in `Info.plist`
- Android: `ACCESS_FINE_LOCATION` (or `ACCESS_COARSE_LOCATION`) in
  `AndroidManifest.xml`

### Notes

- No API key, no billing, no rate-limit tied to your account — this calls
  the OS's own geocoder (Apple's servers on iOS, typically Google Play
  services on Android).
- On Android, `Geocoder.isPresent()` is checked before geocoding; devices
  without it (e.g. some AOSP builds without Play Services) reject with
  `GEOCODER_UNAVAILABLE`.
- Coverage/detail varies by region — this is on-device/OS behavior, not
  something this library controls.


## Contributing

- [Development workflow](CONTRIBUTING.md#development-workflow)
- [Sending a pull request](CONTRIBUTING.md#sending-a-pull-request)
- [Code of conduct](CODE_OF_CONDUCT.md)

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
