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

- (void)reverseGeocode:(double)latitude
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

- (std::shared_ptr<facebook::react::TurboModule>)getTurboModule:
    (const facebook::react::ObjCTurboModule::InitParams &)params
{
    return std::make_shared<facebook::react::NativeReverseGeocodingSpecJSI>(params);
}

+ (NSString *)moduleName
{
  return @"ReverseGeocoding";
}

@end
