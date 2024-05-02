import UIKit

class IntroductionVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pushToFitnessOptionList()
        
    }

    private func pushToFitnessOptionList(){
        DispatchQueue.global().asyncAfter(deadline: .now() + 1){
            DispatchQueue.main.async { [weak self] in
                let fitnessOptionsListVC = ViewControllerProvider.fitnessOptionsListVC
                self?.navigationController?.pushViewController(fitnessOptionsListVC, animated: true)
            }
            
        }
    }
    
}

