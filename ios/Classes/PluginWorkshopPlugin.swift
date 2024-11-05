import Flutter
import UIKit

public class PluginWorkshopPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "plugin_workshop", binaryMessenger: registrar.messenger())
        let instance = PluginWorkshopPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "add":
            let args = call.arguments as! Dictionary<String, Any>
            let a = args["input1"] as! Double
            let b = args["input2"] as! Double
            result(a+b)
        case "subtract":
            let args = call.arguments as! Dictionary<String, Any>
            let a = args["input1"] as! Double
            let b = args["input2"] as! Double
            result(a-b)
        case "multiply":
            let args = call.arguments as! Dictionary<String, Any>
            let a = args["input1"] as! Double
            let b = args["input2"] as! Double
            result(a*b)
        case "divide":
            let args = call.arguments as! Dictionary<String, Any>
            let a = args["input1"] as! Double
            let b = args["input2"] as! Double
            
            if (b == 0) {
                result(FlutterError(code: "DIVISION_BY_ZERO", message: "Cannot divide by zero", details: nil))
                return
            }
            result(a/b)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}
