//

import UIKit
import DropDown

class CalculateIdealWeightVC: ParentVC {

    //MARK: IBOutlets
    
    //input stack components
    @IBOutlet weak var txtFieldGender: UITextField!
    @IBOutlet weak var txtFieldHeight: UITextField!
    
    //output stack components
    @IBOutlet weak var lblHamWiValue: UILabel!
    @IBOutlet weak var lblDevineValue: UILabel!
    @IBOutlet weak var lblMillerValue: UILabel!
    @IBOutlet weak var lblRobinsonValue: UILabel!
    
    //MARK: Properties
    private var dropDownGender:DropDown? = nil
    var fitnessOptionResource:FitnessOptionProtocol!
    
    private var gender:String? = nil
    private var height:String? = nil
    
    //MARK: UIView lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ideal Weight"
        configureGenderDropDown()
    }
    
    //MARK: API call
    func callGetIdealWeightDataAPI(){
        if let gender, let height, !gender.isEmpty, !height.isEmpty{
            
            let idealWeightRequestModel = IdealWeightRequestModel.init(gender: gender, height: height)
            
            fitnessOptionResource.genericFetchData(for: URLEndPoint.urlIdealWeight, requestModel: idealWeightRequestModel) { (responseModel:IdealWeightResponseModel?, error:ApiError?) in
                
                if let responseModel{
                    if(responseModel.statusCode == 200){
                        self.setIdealWeightOutputData(idealWeightData: responseModel.idealWeightData)
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
    
    func setIdealWeightOutputData(idealWeightData:IdealWeightData){
        DispatchQueue.main.async { [weak self] in
            self?.lblHamWiValue.text = "By Hamwi : \(idealWeightData.hamwi)"
            self?.lblDevineValue.text = "By Devine : \(idealWeightData.devine)"
            self?.lblMillerValue.text = "By Miller : \(idealWeightData.miller)"
            self?.lblRobinsonValue.text = "By Robinson : \(idealWeightData.robinson)"
        }
    }
    
    func clearText(){
        DispatchQueue.main.async{ [weak self] in
            self?.txtFieldHeight.text = ""
            self?.lblHamWiValue.text = ""
            self?.lblDevineValue.text = ""
            self?.lblMillerValue.text = ""
            self?.lblRobinsonValue.text = ""
        }
    }
    
    //MARK: IBActions
    @IBAction func btnActionGenerateIdealWeightResult(_ sender: UIButton) {
        dismissKeyboard()
        callGetIdealWeightDataAPI()
    }

    @IBAction func btnActionClear(_ sender: UIButton) {
        clearText()
    }
}

//MARK: UITextFieldDelegate
extension CalculateIdealWeightVC : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == txtFieldGender){
            txtFieldGender.resignFirstResponder()
            dropDownGender?.show()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField == txtFieldGender){
            gender = textField.text
            dropDownGender?.hide()
        }else if(textField == txtFieldHeight){
            height = textField.text
        }
    }
    
}
