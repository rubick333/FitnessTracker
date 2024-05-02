import UIKit

class ParentVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGesture(view: self.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            self.navigationController?.navigationBar.isHidden = true
        }
    }
}

