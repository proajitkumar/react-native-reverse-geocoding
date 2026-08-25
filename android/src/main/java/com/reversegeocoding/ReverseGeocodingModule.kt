package com.reversegeocoding

import android.location.Geocoder
import android.os.Build
import com.facebook.react.bridge.Arguments
import com.facebook.react.bridge.Promise
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.bridge.WritableArray
import com.facebook.react.bridge.WritableMap
import java.util.Locale

class ReverseGeocodingModule(reactContext: ReactApplicationContext) :
  NativeReverseGeocodingSpec(reactContext) {

  override fun reverseGeocode(latitude: Double, longitude: Double, promise: Promise) {
    val context = reactApplicationContext

    if (!Geocoder.isPresent()) {
      promise.reject("GEOCODER_UNAVAILABLE", "No geocoder service is available on this device")
      return
    }

    try {
      val geocoder = Geocoder(context, Locale.getDefault())

      if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
        geocoder.getFromLocation(latitude, longitude, 1) { addresses ->
          promise.resolve(buildResult(addresses))
        }
      } else {
        @Suppress("DEPRECATION")
        val addresses = geocoder.getFromLocation(latitude, longitude, 1)
        promise.resolve(buildResult(addresses))
      }
    } catch (e: Exception) {
      promise.reject("GEOCODE_FAILED", e.message ?: "Reverse geocoding failed", e)
    }
  }

  private fun buildResult(addresses: List<android.location.Address>?): WritableArray {
    val result = Arguments.createArray()
    val address = addresses?.firstOrNull() ?: return result

    val map: WritableMap = Arguments.createMap()
    map.putString("city", address.locality)
    map.putString("region", address.adminArea)
    map.putString("country", address.countryName)
    map.putString("isoCountryCode", address.countryCode)
    map.putString("postalCode", address.postalCode)
    map.putString("street", address.thoroughfare)
    map.putString("streetNumber", address.subThoroughfare)
    map.putString("subregion", address.subAdminArea)
    map.putString("name", address.featureName)
    map.putString("formattedAddress", buildFormattedAddress(address))

    result.pushMap(map)
    return result
  }

  private fun buildFormattedAddress(address: android.location.Address): String? {
    // getAddressLine(n) is the geocoder backend's own pre-formatted line —
    // it fills in gaps (e.g. house/plot number) that discrete fields like
    // thoroughfare often leave null, especially outside the US.
    val lines = (0..address.maxAddressLineIndex).mapNotNull { address.getAddressLine(it) }
    return lines.takeIf { it.isNotEmpty() }?.joinToString(", ")
  }

  companion object {
    const val NAME = NativeReverseGeocodingSpec.NAME
  }
}
