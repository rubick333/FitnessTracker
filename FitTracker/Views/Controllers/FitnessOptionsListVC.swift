
import UIKit

enum FitnessOptions : String,CaseIterable{
    case calculateBMI = "BMI"
    case calculateBodyFatPercent = "BODY FAT PERCENTAGE"
    case calculateIdealWeight = "IDEAL WEIGHT"
    case dailyCaloryRequirement = "DAILY CALORY REQUIREMENT"
    case caloriesBurntByActivity = "CALORIES BURNT BY ACTIVITY"
    case calculateMacro = "MACRO"
}

class FitnessOptionsListVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tblViewFitnessOptionList: UITableView!
    
    //MARK: Properties
    private let arrOption:[FitnessOptions] = FitnessOptions.allCases
    
    //MARK: UIViewcontroller lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "CALCULATE"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if self.isMovingFromParent {
            self.navigationController?.navigationBar.isHidden = true
            self.navigationItem.hidesBackButton = false
        }
    }
    
}

//MARK: Viewcontroller Navigations
extension FitnessOptionsListVC{
    
    func navigate(to fitnessOption:FitnessOptions){
        
        var vc:UIViewController?
        
        switch fitnessOption {
        case .calculateBMI:
            vc = ViewControllerProvider.calculateBMIVC
        case .calculateBodyFatPercent:
            vc = ViewControllerProvider.calculateFatPercentVC
        case .calculateIdealWeight:
            vc = ViewControllerProvider.calculateIdealWeightVC
        case .dailyCaloryRequirement:
            vc = ViewControllerProvider.calculateDailyCaloryRequirementVC
        case .caloriesBurntByActivity:
            vc = ViewControllerProvider.calculateBMIVC
        case .calculateMacro:
            vc = ViewControllerProvider.calculateBMIVC
        }
        guard let vc else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

//MARK: UITableViewDataSource & UITableViewDelegate Methods
extension FitnessOptionsListVC : UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FitnessOptions.allCases.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.fitnessOptionListCell, for: indexPath) as! FitnessOptionListCell
        let title = arrOption[indexPath.row].rawValue
        cell.set(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedOption = arrOption[indexPath.row]
        navigate(to: selectedOption)
    }
    
}

