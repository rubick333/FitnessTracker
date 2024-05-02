import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        configureWindow(scene: scene)
    }
    
    private func configureWindow(scene:UIScene?){
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = ViewControllerProvider.navController
        self.window = window
        window.makeKeyAndVisible()
    }

   
}

