import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureWindow()
        InternetHandler.shared.setupReachabilityForInternetConnect()
    
        return true
    }
    
    private func configureWindow(){
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewControllerProvider.navController
        window?.makeKeyAndVisible()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        InternetHandler.shared.removeInternetObserver()
    }

    
}

