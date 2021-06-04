#import "VuduMojoAppPlugin.h"
#if __has_include(<vudu_mojo_app/vudu_mojo_app-Swift.h>)
#import <vudu_mojo_app/vudu_mojo_app-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "vudu_mojo_app-Swift.h"
#endif

@implementation VuduMojoAppPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftVuduMojoAppPlugin registerWithRegistrar:registrar];
}
@end
