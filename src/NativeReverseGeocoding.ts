import { TurboModuleRegistry, type TurboModule } from 'react-native';

export type Address = {
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

export interface Spec extends TurboModule {
  reverseGeocode(latitude: number, longitude: number): Promise<Address[]>;
}

export default TurboModuleRegistry.get<Spec>('ReverseGeocoding');
