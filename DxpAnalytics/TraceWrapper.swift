//
//  TraceWrapper.swift
//  DxpAnalytics
//
//  Created by 李标 on 2025/11/9.
//

import Foundation

@objc open class TraceWrapper: NSObject {
	
	@objc public static let shared = TraceWrapper()
	
	private let objcInstance = DxpTraceManager.shareInstance()
	
	public override init() {
		super.init()
	}
	
	/// eg:Initialize the SDK
	/// @param traceType Set up the channel type for tracking points
	/// The default is TraceType_None.
	@objc public func initTraceType(type: TraceType) -> Void {
		objcInstance.initTraceType(type)
	}
	
	/// eg:Enable debug logs  YES: Open    NO: close(default)
	/// Regarding Sensors
	@objc public func openLog(isOpen:Bool) -> Void {
		objcInstance.openLog(isOpen)
	}
	
	/// eg:Return to Tracking Channel Type
	@objc public func getCurrentTraceType() ->Void {
		objcInstance.getCurrentTraceType()
	}
	
	/// eg:Initialize the Sensors SDK
	/// @param sensorsDataUrl (Required) Tracking Code Reporting Address
	/// @param channel (Optional) Key values contained within public attributes
	/// Regarding Sensors
	@objc public func initSensorsDataUrl(sensorsDataUrl:String, channel:String) -> Void {
		objcInstance.initSensorsDataUrl(sensorsDataUrl, channel: channel)
	}
	
	/// eg:Event Tracking Method
	/// @param traceName  (Required) Tracking Point Name
	/// @param properties (Optional) Parameter Name (Dictionary type eg: @{key1:value1, key2:value2, ..... keyn:valuen}  )
	///  Regarding Sensors And Google
	@objc public func traceDataReport(traceName:String, properties:Dictionary<String, Any>) -> Void {
		objcInstance.traceDataReport(traceName, properties: properties)
	}
	
	/// eg: Set User Properties
	/// @param sensorsProperties (Required)  Sensors User Attribute Values  (Dictionary type eg: @{key1:value1, key2:value2, ..... keyn:valuen}  )
	/// @param propertiesName (Required) Google Analytics User Attribute Name
	/// @param propertiesValue (Required) Google Analytics User Attribute Values
	/// Regarding Sensors And Google
	@objc public func setUserProfileProperties(sensorsProperties:Dictionary<String, Any>, propertiesName:String, propertiesValue:String) -> Void {
		
		objcInstance.setUserProfileProperties(sensorsProperties, gaPropertiesName: propertiesName, gaPropertiesValue: propertiesValue)
	}
	
	/// eg: Set the public properties of the event
	/// @param properties  (Dictionary type eg: @{key1:value1, key2:value2, ..... keyn:valuen}  )
	/// Regarding Sensors
	@objc public func setRegisterSuperProperties(properties:Dictionary<String, Any>) -> Void {
		objcInstance.setRegisterSuperProperties(properties);
	}
	
	/// eg:Delete the public property registration
	/// @param key (Required) The property key to be deleted
	/// Regarding Sensors
	@objc public func setUnregisterSuperProperty(key:String)-> Void {
		objcInstance.setUnregisterSuperProperty(key)
	}
	
	/// eg:Return the currently registered public property
	/// Regarding Sensors
	@objc public func getCurrentSuperProperties () -> [String: Any] {
		let properties = objcInstance.getCurrentSuperProperties()
		guard let stringKeyProperties = properties as? [String: Any] else {
			return [:]
		}
		return stringKeyProperties
	}
	
	/// eg:Logout, clear the current user's loginId
	/// Regarding Sensors
	@objc public func logout() -> Void {
		objcInstance.logout()
	}
	
	/// eg:Log in and set the current user's loginId
	/// @param loginId (Required) user id
	/// Regarding Sensors
	@objc public func login(loginId:String) -> Void {
		objcInstance.login(loginId)
	}
	
}
