package com.reversegeocoding

import com.facebook.react.bridge.ReactApplicationContext

class ReverseGeocodingModule(reactContext: ReactApplicationContext) :
  NativeReverseGeocodingSpec(reactContext) {

  override fun multiply(a: Double, b: Double): Double {
    return a * b
  }

  companion object {
    const val NAME = NativeReverseGeocodingSpec.NAME
  }
}
