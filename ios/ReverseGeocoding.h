#import <React/RCTBridgeModule.h>

#ifdef RCT_NEW_ARCH_ENABLED
#import <ReverseGeocodingSpec/ReverseGeocodingSpec.h>

@interface ReverseGeocoding : NSObject <NativeReverseGeocodingSpec>

@end
#else
@interface ReverseGeocoding : NSObject <RCTBridgeModule>

@end
#endif
