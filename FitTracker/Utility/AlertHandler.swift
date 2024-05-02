import UIKit

class AlertHandler{
    
    private static func createAlert(with title:String,message:String, arrAction:[UIAlertAction],on vc:UIViewController){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            arrAction.forEach { action in
                alert.addAction(action)
            }
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    static func errorAlert(on vc:UIViewController,message:String){
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        createAlert(with: "Error", message: message, arrAction: [dismissAction], on: vc)
    }
    
}
