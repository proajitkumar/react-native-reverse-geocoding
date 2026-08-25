package com.reversegeocoding

import com.facebook.react.BaseReactPackage
import com.facebook.react.bridge.NativeModule
import com.facebook.react.bridge.ReactApplicationContext
import com.facebook.react.module.model.ReactModuleInfo
import com.facebook.react.module.model.ReactModuleInfoProvider
import java.util.HashMap

class ReverseGeocodingPackage : BaseReactPackage() {
  override fun getModule(name: String, reactContext: ReactApplicationContext): NativeModule? {
    return if (name == ReverseGeocodingModule.NAME) {
      ReverseGeocodingModule(reactContext)
    } else {
      null
    }
  }

  override fun getReactModuleInfoProvider() = ReactModuleInfoProvider {
    mapOf(
      // Positional args on purpose: ReactModuleInfo's constructor gained/lost a
      // `hasConstants` param across RN versions under the same parameter names
      // in some releases, which breaks named-argument calls. Positional args
      // resolve by arity regardless, so this works across those RN versions
      // whose ReactModuleInfo constructor takes 6 args (no hasConstants).
      ReverseGeocodingModule.NAME to ReactModuleInfo(
        ReverseGeocodingModule.NAME,
        ReverseGeocodingModule.NAME,
        false, // canOverrideExistingModule
        false, // needsEagerInit
        false, // isCxxModule
        true // isTurboModule
      )
    )
  }
}
