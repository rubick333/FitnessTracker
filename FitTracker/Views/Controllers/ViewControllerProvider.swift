import UIKit

class ViewControllerProvider{
    
    private init(){}
    
    static var navController : UINavigationController{
        let navController = UINavigationController.init(rootViewController: introductionVC)
        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.isHidden = true
        return navController
    }
    
    static var introductionVC : IntroductionVC{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IntroductionVC") as! IntroductionVC
        return vc
    }
    
    static var fitnessOptionsListVC : FitnessOptionsListVC{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FitnessOptionsListVC") as! FitnessOptionsListVC
        return vc
    }
    
    static var calculateBMIVC : CalculateBMIVC{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculateBMIVC") as! CalculateBMIVC
        vc.fitnessOptionResource = FitnessOptionResource()
        return vc
    }
    
    static var calculateFatPercentVC : CalculateFatPercentVC{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculateFatPercentVC") as! CalculateFatPercentVC
        vc.fitnessOptionResource = FitnessOptionResource()
        return vc
    }
    
    static var calculateIdealWeightVC : CalculateIdealWeightVC{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculateIdealWeightVC") as! CalculateIdealWeightVC
        vc.fitnessOptionResource = FitnessOptionResource()
        return vc
    }
    
    static var calculateDailyCaloryRequirementVC : CalculateDailyCaloryRequirementVC{
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalculateDailyCaloryRequirementVC") as! CalculateDailyCaloryRequirementVC
        vc.fitnessOptionResource = FitnessOptionResource()
        return vc
    }
}
