import { Platform } from 'react-native';
import ReverseGeocoding, { type Address } from './NativeReverseGeocoding';

export type { Address };

const LINKING_ERROR =
  `The package 'react-native-reverse-geocoding' doesn't seem to be linked. Make sure: \n\n` +
  Platform.select({ ios: "- You have run 'pod install'\n", default: '' }) +
  '- You rebuilt the app after installing the package\n' +
  '- You are not using Expo Go\n';

/**
 * Reverse-geocodes a coordinate using only native OS geocoding APIs
 * (CLGeocoder on iOS, android.location.Geocoder on Android) — no REST
 * calls, no API keys.
 */
export function reverseGeocodeAsync(
  latitude: number,
  longitude: number
): Promise<Address[]> {
  if (!ReverseGeocoding) {
    throw new Error(LINKING_ERROR);
  }
  return ReverseGeocoding.reverseGeocode(latitude, longitude);
}
