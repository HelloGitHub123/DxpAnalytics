//
//  DxpTraceManager.h
//  DxpAnalyticsSDK
//
//  Created by 李标 on 2025/11/1.
//  包装 DXPAnalyticsLib

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, TraceType) {
	TraceType_None            = -1, // Do not embed any points.
	TraceType_Sensors         = 1,  // Sensors Alone
	TraceType_GoogleAnalytics = 2,  // Google Analytics only
	TraceType_All             = 3,  // Sensors and Google Analytics participate in tagging
};

@interface DxpTraceManager : NSObject

/// eg: Singleton
+ (DxpTraceManager *)shareInstance;

/// eg:Initialize the SDK
/// @param traceType Set up the channel type for tracking points
/// The default is TraceType_None.
- (void)initTraceType:(TraceType)traceType;

/// eg:Enable debug logs  YES: Open    NO: close(default)
/// Regarding Sensors
- (void)openLog:(BOOL)isOpen;

/// eg:Return to Tracking Channel Type
- (TraceType)getCurrentTraceType;

/// eg:Initialize the Sensors SDK
/// @param sensorsDataUrl (Required) Tracking Code Reporting Address
/// @param channel (Optional) Key values contained within public attributes
/// Regarding Sensors
- (void)initSensorsDataUrl:(NSString *)sensorsDataUrl channel:(NSString *)channel;

/// eg:Event Tracking Method
/// @param traceName  (Required) Tracking Point Name
/// @param properties (Optional) Parameter Name (Dictionary type eg: @{key1:value1, key2:value2, ..... keyn:valuen}  )
///  Regarding Sensors And Google
- (void)traceDataReport:(NSString *)traceName properties:(NSDictionary *)properties;

/// eg: Set User Properties
/// @param sensorsProperties (Required)  Sensors User Attribute Values  (Dictionary type eg: @{key1:value1, key2:value2, ..... keyn:valuen}  )
/// @param propertiesName (Required) Google Analytics User Attribute Name
/// @param propertiesValue (Required) Google Analytics User Attribute Values
/// Regarding Sensors And Google
- (void)setUserProfileProperties:(NSDictionary *)sensorsProperties gaPropertiesName:(NSString *)propertiesName gaPropertiesValue:(NSString *)propertiesValue;

/// eg: Set the public properties of the event
/// @param properties  (Dictionary type eg: @{key1:value1, key2:value2, ..... keyn:valuen}  )
/// Regarding Sensors
- (void)setRegisterSuperProperties:(NSDictionary *)properties;

/// eg:Delete the public property registration
/// @param key (Required) The property key to be deleted
/// Regarding Sensors
- (void)setUnregisterSuperProperty:(NSString *)key;

/// eg:Return the currently registered public property
/// Regarding Sensors
- (NSDictionary *)getCurrentSuperProperties;

/// eg:Logout, clear the current user's loginId
/// Regarding Sensors
- (void)logout;

/// eg:Log in and set the current user's loginId
/// @param loginId (Required) user id
/// Regarding Sensors
- (void)login:(NSString *)loginId;

@end

NS_ASSUME_NONNULL_END
