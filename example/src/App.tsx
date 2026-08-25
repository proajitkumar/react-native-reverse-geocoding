import { useState } from 'react';
import {
  ActivityIndicator,
  Button,
  StyleSheet,
  Text,
  View,
} from 'react-native';
import { reverseGeocodeAsync, type Address } from 'react-native-reverse-geocoding';

export default function App() {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [address, setAddress] = useState<Address | null>(null);

  const handlePress = async () => {
    setLoading(true);
    setError(null);
    setAddress(null);
    try {
      // Google's HQ coordinates, just as a smoke test — swap for a real
      // device location (e.g. via @react-native-community/geolocation).
      const results = await reverseGeocodeAsync(37.4219983, -122.084);
      setAddress(results[0] ?? null);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Reverse geocode failed');
    } finally {
      setLoading(false);
    }
  };

  return (
    <View style={styles.container}>
      <Button title="Reverse geocode" onPress={handlePress} disabled={loading} />
      {loading && <ActivityIndicator style={styles.spacing} />}
      {error && <Text style={styles.spacing}>{error}</Text>}
      {address && (
        <Text style={styles.spacing}>
          {address.formattedAddress ?? JSON.stringify(address)}
        </Text>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    padding: 16,
  },
  spacing: {
    marginTop: 12,
  },
});
