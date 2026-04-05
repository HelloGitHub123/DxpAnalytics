//
//  DxpTraceManager.m
//  DxpAnalyticsSDK
//
//  Created by 李标 on 2025/11/1.
//  单例

#import "DxpTraceManager.h"
#import "GoogleAnalyticsManagement.h"
#import "SensorsManagement.h"

static DxpTraceManager *tokenManager = nil;

@interface DxpTraceManager ()

@property (nonatomic, assign) TraceType traceType;
@property (nonatomic, assign) BOOL isOpenLog;
@end


@implementation DxpTraceManager

// Singleton
+ (DxpTraceManager *)shareInstance {
	static dispatch_once_t oneToken;
	dispatch_once(&oneToken, ^{
		tokenManager = [[DxpTraceManager alloc] init];
	});
	return tokenManager;
}

// Initialize the SDK
- (void)initTraceType:(TraceType)traceType {
	_traceType = traceType;
	
	if (_traceType == TraceType_Sensors) {
		// Sensors
		[GoogleAnalyticsManagement sharedInstance].gaEnable = NO;
		[SensorsManagement sharedInstance].sensorsDataEnabled = YES;
	}
	if (_traceType == TraceType_GoogleAnalytics) {
		// Google Analytics
		[GoogleAnalyticsManagement sharedInstance].gaEnable = YES;
		[SensorsManagement sharedInstance].sensorsDataEnabled = NO;
	}
	if (_traceType == TraceType_All) {
		// All
		[GoogleAnalyticsManagement sharedInstance].gaEnable = YES;
		[SensorsManagement sharedInstance].sensorsDataEnabled = YES;
	}
}

// Enable debug logs  YES:Open  NO:close(default)
- (void)openLog:(BOOL)isOpen {
	_isOpenLog = isOpen;
}

//- (void)setSensorsDataEnabled:(BOOL)isEnabled {
//	[SensorsManagement sharedInstance].sensorsDataEnabled = isEnabled;
//}
//
//- (void)setGaEnable:(BOOL)isEnabled {
//	[GoogleAnalyticsManagement sharedInstance].gaEnable = isEnabled;
//}

// Return to Tracking Channel Type
- (TraceType)getCurrentTraceType {
	return self.traceType;
}

// Initialize the Sensors SDK
- (void)initSensorsDataUrl:(NSString *)sensorsDataUrl channel:(NSString *)channel {
	if (sensorsDataUrl && sensorsDataUrl.length > 0) {
		[SensorsManagement sharedInstanceWithLaunchOptions:[SensorsManagement sharedInstance].launchOptions baseUrl:sensorsDataUrl openLog:_isOpenLog];
		if (channel && channel.length > 0) {
			[[SensorsManagement sharedInstance] setRegisterSuperProperties:@{@"channel": channel}];
		}
	}
}

// Event Tracking Method
- (void)traceDataReport:(NSString *)traceName properties:(NSDictionary *)properties {
	if (traceName.length > 0) {
		[[SensorsManagement sharedInstance] trackWithName:traceName withProperties:properties];
		[[GoogleAnalyticsManagement sharedInstance] logEventWithName:traceName withProperties:properties];
	}
}

// Set User Properties
- (void)setUserProfileProperties:(NSDictionary *)sensorsProperties gaPropertiesName:(NSString *)propertiesName gaPropertiesValue:(NSString *)propertiesValue {
	[[SensorsManagement sharedInstance] setUserProfileProperties:sensorsProperties];
	[[GoogleAnalyticsManagement sharedInstance] setUserProfilePropertiesWithName:propertiesName PropertiesValue:propertiesValue];
}

// Set the public properties of the event
- (void)setRegisterSuperProperties:(NSDictionary *)properties {
	[[SensorsManagement sharedInstance] setRegisterSuperProperties:properties];
}

// Delete the public property registration
- (void)setUnregisterSuperProperty:(NSString *)key {
	[[SensorsManagement sharedInstance] setUnregisterSuperProperty:key];
}

// Return the currently registered public property
- (NSDictionary *)getCurrentSuperProperties {
	NSDictionary *dic = [[SensorsManagement sharedInstance] getCurrentSuperProperties];
	return dic;
}

// Logout, clear the current user's loginId
- (void)logout {
	[[SensorsManagement sharedInstance] logout];
}

// Log in and set the current user's loginId
- (void)login:(NSString *)loginId {
	[[SensorsManagement sharedInstance] login:loginId];
}

@end
