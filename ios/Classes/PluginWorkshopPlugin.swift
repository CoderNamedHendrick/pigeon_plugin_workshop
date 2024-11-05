import Flutter
import UIKit

public class PluginWorkshopPlugin: NSObject, FlutterPlugin, ArithmeticHostApi {

    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger()
        let api = PluginWorkshopPlugin.init()
        ArithmeticHostApiSetup.setUp(binaryMessenger: messenger, api: api)
    }
    
    public func detachFromEngine(for registrar: any FlutterPluginRegistrar) {
        ArithmeticHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: nil)
    }
    
    func performArithmeticOperation(input1: Double, input2: Double, operation: ArithmeticOperation) throws -> Double {
        switch(operation) {
        case .add:
            return input1 + input2
        case .subtract:
            return input1 - input2
        case .multiply:
            return input1 * input2
        case .divide:
            if (input2 == 0.0) {
                throw PluginPigeonError(code: "DIVISION_BY_ZERO", message: "Cannot divide by zero", details: nil)
            }
            
            return input1 / input2
        }
    }
}
