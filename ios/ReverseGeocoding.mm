#import "ReverseGeocoding.h"

// When this pod is built as a framework (e.g. via `use_frameworks!`), the
// generated Swift header only lives under the framework's own Headers dir,
// reachable via the angle-bracket form; otherwise it's a plain quoted
// include next to the other generated sources.
#if __has_include(<ReverseGeocoding/ReverseGeocoding-Swift.h>)
#import <ReverseGeocoding/ReverseGeocoding-Swift.h>
#else
#import "ReverseGeocoding-Swift.h"
#endif

@implementation ReverseGeocoding {
    ReverseGeocodingImpl *_impl;
}

- (instancetype)init
{
    if (self = [super init]) {
        _impl = [ReverseGeocodingImpl new];
    }
    return self;
}

RCT_EXPORT_MODULE()

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

#ifdef RCT_NEW_ARCH_ENABLED
- (void)reverseGeocode:(double)latitude
              longitude:(double)longitude
                resolve:(RCTPromiseResolveBlock)resolve
                 reject:(RCTPromiseRejectBlock)reject
{
    [self performReverseGeocode:latitude longitude:longitude resolve:resolve reject:reject];
}

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeReverseGeocodingSpecJSI>(params);
}
#else
// Old architecture (bridge): the method must be exported explicitly.
RCT_REMAP_METHOD(reverseGeocode,
                 reverseGeocode:(double)latitude
                 longitude:(double)longitude
                 resolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject)
{
    [self performReverseGeocode:latitude longitude:longitude resolve:resolve reject:reject];
}
#endif

- (void)performReverseGeocode:(double)latitude
                    longitude:(double)longitude
                      resolve:(RCTPromiseResolveBlock)resolve
                       reject:(RCTPromiseRejectBlock)reject
{
    [_impl reverseGeocodeWithLatitude:latitude
                             longitude:longitude
                               resolve:^(id result) {
        resolve(result);
    }
                                reject:^(NSString *code, NSString *message, NSError *error) {
        reject(code, message, error);
    }];
}

@end
