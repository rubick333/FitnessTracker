import UIKit
import DropDown

enum Gender:String{
    case male = "male"
    case female = "female"
}

enum ActivityLevel: Int, CustomStringConvertible {
    case level_1 = 0, level_2, level_3, level_4, level_5, level_6
    
    var description: String {
        get {
            switch self {
            case .level_1:
                "Sedentary: little or no exercise"
            case .level_2:
                "Exercise 1-3 times/week"
            case .level_3:
                "Exercise 4-5 times/week"
            case .level_4:
                "Daily exercise or intense exercise 3-4 times/week"
            case .level_5:
                "Intense exercise 6-7 times/week"
            case .level_6:
                "Very intense exercise daily, or physical job"
            }
        }
    }
}

class CalculateDailyCaloryRequirementVC: ParentVC {

    //MARK: IBOutlets
    
    //input stack components
    @IBOutlet weak var txtFieldAge: UITextField!
    @IBOutlet weak var txtFieldHeight: UITextField!
    @IBOutlet weak var txtFieldWeight: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    @IBOutlet weak var txtFieldActivityLevel: UITextField!
    
    //output stack components
    @IBOutlet weak var lblBMR: UILabel!
    @IBOutlet weak var lblMaintainWeight: UILabel!
    @IBOutlet weak var lblMildWeightLoss: UILabel!
    @IBOutlet weak var lblNormalWeightLoss: UILabel!
    @IBOutlet weak var lblExtremeWeightLoss: UILabel!
    @IBOutlet weak var lblMildWeightGain: UILabel!
    @IBOutlet weak var lblNormalWeightGain: UILabel!
    @IBOutlet weak var lblExtremeWeighGain: UILabel!
    
    //MARK: Properties
    var fitnessOptionResource:FitnessOptionProtocol!
    
    private var dropDownActivityLevel:DropDown? = nil
    private var dropDownGender:DropDown? = nil
    
    private var age:String? = nil
    private var height:String? = nil
    private var weight:String? = nil
    private var gender:String? = nil
    private var activityLevel:String? = nil
    
    //MARK: UIView lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Daily Calory Requirement"
        configureActivityLevelDropDown()
        configureGenderDropDown()
    }
    
    //MARK: API call
    func callGetDailyCaloryRequirementDataAPI(){
        if let age, let height, let weight,let gender, let activityLevel, !age.isEmpty, !height.isEmpty, !weight.isEmpty,!gender.isEmpty, !activityLevel.isEmpty{
            
            let dailyCaloryRequirementRequestModel = DailyCaloryRequirementRequestModel.init(age: age, gender: gender, weight: weight, height: height, activityLevel: activityLevel)
            
            fitnessOptionResource.genericFetchData(for: URLEndPoint.urlDailyCaloryRequirement, requestModel: dailyCaloryRequirementRequestModel) { (responseModel:DailyCaloryRequirementResponseModel?, error:ApiError?) in
                if let responseModel{
                    if(responseModel.statusCode == 200){
                        self.setDailyCaloryRequirementOutputData(dailyCaloryRequirementData: responseModel.dailyCaloryRequirementData)
                    }else{
                        AlertHandler.errorAlert(on: self, message: ErrorMessage.errorMessage)
                    }
                }
                if let error{
                    AlertHandler.errorAlert(on: self, message: ErrorMessage.errorMessage)
                }
            }
        }else{
            AlertHandler.errorAlert(on: self, message: ErrorMessage.emptyFieldMessage)
        }
    }
    
    //MARK: UI Helper Methods
    func configureActivityLevelDropDown(){
        dropDownActivityLevel = DropDown()
        dropDownActivityLevel?.anchorView = txtFieldActivityLevel
        
        DispatchQueue.main.async {[weak self] in
            self?.dropDownActivityLevel?.dataSource = [ActivityLevel.level_1.description,ActivityLevel.level_2.description,ActivityLevel.level_3.description,ActivityLevel.level_4.description,ActivityLevel.level_5.description,ActivityLevel.level_6.description]

            self?.dropDownActivityLevel?.selectionAction = { [weak self] (index:Int,item:String) in
                switch ActivityLevel(rawValue: index){
                case .level_1:
                    self?.activityLevel = "level_1"
                case .level_2:
                    self?.activityLevel = "level_2"
                case .level_3:
                    self?.activityLevel = "level_3"
                case .level_4:
                    self?.activityLevel = "level_4"
                case .level_5:
                    self?.activityLevel = "level_5"
                case .level_6:
                    self?.activityLevel = "level_6"
                case .none:
                    break
                }
                self?.txtFieldActivityLevel.text = item
                self?.txtFieldActivityLevel.resignFirstResponder()
            }
        }
        
    }
    
    func configureGenderDropDown(){
        dropDownGender = DropDown()
        dropDownGender?.anchorView = txtFieldGender
        
        DispatchQueue.main.async {[weak self] in
            self?.dropDownGender?.dataSource = [Gender.male.rawValue,Gender.female.rawValue]

            self?.dropDownGender?.selectionAction = { [weak self] (index:Int,item:String) in
                self?.gender = item
                self?.txtFieldGender.text = item
                self?.txtFieldGender.resignFirstResponder()
            }
        }
    }
    
    func setDailyCaloryRequirementOutputData(dailyCaloryRequirementData:DailyCaloryRequirementData){
        DispatchQueue.main.async { [weak self] in
            self?.lblBMR.text = "BMR : \(Int(dailyCaloryRequirementData.BMR))"
                    
            let goalsData = dailyCaloryRequirementData.goals
            self?.lblMaintainWeight.text = "Calories needed to maintain current weight : \(Int(goalsData.maintainWeight))"
            self?.lblMildWeightLoss.text = "Calories needed to loose \(goalsData.mildWeightLoss.lossWeight) : \(Int(goalsData.mildWeightLoss.calory))"
            self?.lblNormalWeightLoss.text = "Calories needed to loose \(goalsData.normalWeightLoss.lossWeight) : \(Int(goalsData.normalWeightLoss.calory))"
            self?.lblExtremeWeightLoss.text = "Calories needed to loose \(goalsData.extremeWeightLoss.lossWeight) : \(Int(goalsData.extremeWeightLoss.calory))"
            self?.lblMildWeightGain.text = "Calories needed to gain \(goalsData.mildWeightGain.gainWeight) : \(Int(goalsData.mildWeightGain.calory))"
            self?.lblNormalWeightGain.text = "Calories needed to gain \(goalsData.normalWeightGain.gainWeight) : \(Int(goalsData.normalWeightGain.calory))"
            self?.lblExtremeWeighGain.text = "Calories needed to gain \(goalsData.extremeWeightGain.gainWeight) : \(Int(goalsData.extremeWeightGain.calory))"
        }
    }
    
    func clearText(){
        DispatchQueue.main.async{ [weak self] in
            self?.txtFieldAge.text = ""
            self?.txtFieldHeight.text = ""
            self?.txtFieldWeight.text = ""
            self?.txtFieldGender.text = ""
            self?.txtFieldActivityLevel.text = ""
        }
    }
    
    //MARK: IBActions
    @IBAction func btnActionGenerateDCRResult(_ sender: UIButton) {
        dismissKeyboard()
        callGetDailyCaloryRequirementDataAPI()
    }
    @IBAction func btnActionClear(_ sender: UIButton) {
        clearText()
    }
}

//MARK: UITextFieldDelegate
extension CalculateDailyCaloryRequirementVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == txtFieldGender){
            txtFieldGender.resignFirstResponder()
            dropDownGender?.show()
        }else if(textField == txtFieldActivityLevel){
            txtFieldActivityLevel.resignFirstResponder()
            dropDownActivityLevel?.show()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == txtFieldAge){
            age = textField.text
        }else if(textField == txtFieldHeight){
            height = textField.text
        }else if(textField == txtFieldWeight){
            weight = textField.text
        }else if(textField == txtFieldGender){
            dropDownGender?.hide()
        }else if(textField == txtFieldActivityLevel){
            dropDownActivityLevel?.hide()
        }
    }
    
}
