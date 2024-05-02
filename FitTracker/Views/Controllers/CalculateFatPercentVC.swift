import UIKit
import DropDown

@propertyWrapper struct InchesToCMConversionPropertyWrapper{

    var incheValue:String?
    
    var wrappedValue: String?{
        get{
            return convertInchesToCM(inches: incheValue ?? "")
        }
        set{
            if let newValue{
                self.incheValue = newValue
            }
        }
    }
    
    func convertInchesToCM(inches:String) -> String{
        guard let strInches = self.incheValue else { return "" }
        guard let valueInInches = Float(strInches) else { return "" }
        let valueInCM = UnitConversionHandler.shared.convertInchesToCm(valueInInches)
        return String(valueInCM)
    }
    
}


class CalculateFatPercentVC: ParentVC {

    //MARK: IBOutlets
    
    //input stack components
    @IBOutlet weak var txtFieldAge: UITextField!
    @IBOutlet weak var txtFieldHeight: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    @IBOutlet weak var txtFieldWeight: UITextField!
    @IBOutlet weak var txtFieldNeck: UITextField!
    @IBOutlet weak var txtFieldWaist: UITextField!
    @IBOutlet weak var txtFieldHip: UITextField!

    //output stack components
    @IBOutlet weak var lblUSNavyBF: UILabel!
    @IBOutlet weak var lblBMIBF: UILabel!
    @IBOutlet weak var lblBodyFatCategory: UILabel!
    @IBOutlet weak var lblBodyFatMass: UILabel!
    @IBOutlet weak var lblLeanBodyMass: UILabel!
    
    //MARK: Properties
    private var dropDownGender:DropDown? = nil
    var fitnessOptionResource:FitnessOptionProtocol!
    
    private var age:String? = nil
    private var height:String? = nil
    private var weight:String? = nil
    private var gender:String? = nil
    @InchesToCMConversionPropertyWrapper private var neck:String?
    @InchesToCMConversionPropertyWrapper private var waist:String?
    @InchesToCMConversionPropertyWrapper private var hip:String?
    
    //MARK: UIView lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Body Fat Percentage"
        configureGenderDropDown()
    }
    
    //MARK: API call
    func callGetBodyFatPercentDataAPI(){
        if let age, let height, let weight,let gender, let neck, let waist, let hip,!age.isEmpty, !height.isEmpty, !weight.isEmpty,!gender.isEmpty, !neck.isEmpty, !waist.isEmpty,!hip.isEmpty{
            
            let bodyFatPercentRequestModel = BodyFatPercentRequestModel.init(age: age, gender: gender, weight: weight, height: height, neck: neck, waist: waist, hip: hip)
            
            fitnessOptionResource.genericFetchData(for: URLEndPoint.urlBodyFatPercent, requestModel: bodyFatPercentRequestModel) { (responseModel:BodyFatPercentResponseModel?, error:ApiError?) in
                if let responseModel{
                    if(responseModel.statusCode == 200){
                        self.setBodyFatPercentOutputData(bodyFatPercentData: responseModel.bodyFatPercentData)
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
    
    func setBodyFatPercentOutputData(bodyFatPercentData:BodyFatPercentData){
        DispatchQueue.main.async { [weak self] in
            self?.lblUSNavyBF.text = "Body Fat Percent (US Navy Method) : \(bodyFatPercentData.bodyFatPercentUSNavyMethod)"
            self?.lblBMIBF.text = "Body Fat Percent (BMI Method) : \(bodyFatPercentData.bodyFatPercentBMIMethod)"
            self?.lblBodyFatCategory.text = "Body Fat Category : \(bodyFatPercentData.bodyFatCategory)"
            self?.lblBodyFatMass.text = "Body Fat Mass : \(bodyFatPercentData.bodyFatMass)"
            self?.lblLeanBodyMass.text = "Lean Body Mass : \(bodyFatPercentData.leanBodyMass)"
        }
    }
    
    func clearText(){
        DispatchQueue.main.async{ [weak self] in
            self?.txtFieldAge.text = ""
            self?.txtFieldHeight.text = ""
            self?.txtFieldWeight.text = ""
            self?.txtFieldNeck.text = ""
            self?.txtFieldWaist.text = ""
            self?.txtFieldHip.text = ""
            self?.lblUSNavyBF.text = ""
            self?.lblBMIBF.text = ""
            self?.lblBodyFatCategory.text = ""
            self?.lblBodyFatMass.text = ""
            self?.lblLeanBodyMass.text = ""
        }
    }
    
    //MARK: IBActions
    @IBAction func btnActionGenerateBFPResult(_ sender: UIButton) {
        dismissKeyboard()
        callGetBodyFatPercentDataAPI()
    }
    @IBAction func btnActionClear(_ sender: UIButton) {
        clearText()
    }
}

//MARK: UITextFieldDelegate
extension CalculateFatPercentVC : UITextFieldDelegate{
    
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
        if(textField == txtFieldAge){
            age = textField.text
        }else if(textField == txtFieldHeight){
            height = textField.text
        }else if(textField == txtFieldWeight){
            weight = textField.text
        }else if(textField == txtFieldGender){
            dropDownGender?.hide()
        }else if(textField == txtFieldNeck){
            neck = textField.text ?? ""
        }else if(textField == txtFieldWaist){
            waist = textField.text ?? ""
        }else if(textField == txtFieldHip){
            hip = textField.text ?? ""
        }
    }
    
}
