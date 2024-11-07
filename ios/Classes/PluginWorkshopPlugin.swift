import Flutter
import UIKit

public class PluginWorkshopPlugin: NSObject, FlutterPlugin, ArithmeticHostApi {
    var apiTimer: Timer? = nil
    var flutterApi: ArithmeticFlutterApi? = nil
    var result: Int64 = 0
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let messenger = registrar.messenger()
        let api = PluginWorkshopPlugin.init()
        ArithmeticHostApiSetup.setUp(binaryMessenger: messenger, api: api)
        api.flutterApi = ArithmeticFlutterApi(binaryMessenger: messenger)
    }
    
    public func detachFromEngine(for registrar: any FlutterPluginRegistrar) {
        ArithmeticHostApiSetup.setUp(binaryMessenger: registrar.messenger(), api: nil)
        self.flutterApi = nil
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
    
    func startTimer() throws {
        apiTimer?.invalidate()
        apiTimer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true, block: { _ in
            self.flutterApi?.onReceiveTimerResult(result: self.result, completion: { result in
                switch(result) {
                case .success():
                    self.result += 1
                case .failure(let errorResult):
                    print("an error occurred: \(errorResult)")
                }
            })
        })
    }
    
    func stopTimer() throws {
        apiTimer?.invalidate()
        apiTimer = nil
        result = 0
        
        self.flutterApi?.onReceiveTimerResult(result: 0, completion: { _  in})
    }
}
