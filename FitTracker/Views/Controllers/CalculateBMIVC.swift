import UIKit

class CalculateBMIVC: ParentVC {

    //MARK: IBOutlets
    
    //input stack components
    @IBOutlet weak var txtFieldAge: UITextField!
    @IBOutlet weak var txtFieldHeight: UITextField!
    @IBOutlet weak var txtFieldWeight: UITextField!
    
    //output stack components
    @IBOutlet weak var lblBMIValue: UILabel!
    @IBOutlet weak var lblWeightStatus: UILabel!
    @IBOutlet weak var lblHealthyBMIRange: UILabel!
    
    //MARK: Properties
    var fitnessOptionResource:FitnessOptionProtocol!
    
    private var age:String? = nil
    private var height:String? = nil
    private var weight:String? = nil
    
    //MARK: UIView lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "BMI calculator"
    }
    
    //MARK: API call
    func callGetBMIDataAPI(){
        if let age, let height, let weight, !age.isEmpty, !height.isEmpty, !weight.isEmpty{
            
            let bmiRequestModel = BMIRequestModel.init(age: age, weight: weight, height: height)
            
            fitnessOptionResource.genericFetchData(for: URLEndPoint.urlBMI, requestModel: bmiRequestModel) { [weak self]  (responseModel:BMIResponseModel?, error:ApiError?) in
                guard let self = self else { return }
                if let responseModel{
                    if(responseModel.statusCode == 200){
                        self.setBMIOutputData(bmiData: responseModel.bmiData)
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
    func setBMIOutputData(bmiData:BMIData){
        DispatchQueue.main.async { [weak self] in
            self?.lblBMIValue.text = "BMI : \(bmiData.bmi)"
            self?.lblWeightStatus.text = "Health status : \(bmiData.health)"
            self?.lblHealthyBMIRange.text = "Healthy Range : \(bmiData.healthyBMIRange)"
        }
    }
    
    func clearText(){
        DispatchQueue.main.async{ [weak self] in
            self?.txtFieldAge.text = ""
            self?.txtFieldHeight.text = ""
            self?.txtFieldWeight.text = ""
            self?.lblBMIValue.text = ""
            self?.lblWeightStatus.text = ""
            self?.lblHealthyBMIRange.text = ""
        }
    }
    
    //MARK: IBActions
    @IBAction func btnActionGenerateBMIResult(_ sender: UIButton) {
        dismissKeyboard()
        callGetBMIDataAPI()
    }

    @IBAction func btnActionClear(_ sender: UIButton) {
        clearText()
    }
}

//MARK: UITextFieldDelegate
extension CalculateBMIVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == txtFieldAge){
            age = textField.text
        }else if(textField == txtFieldHeight){
            height = textField.text
        }else if(textField == txtFieldWeight){
            weight = textField.text
        }
    }
    
}
