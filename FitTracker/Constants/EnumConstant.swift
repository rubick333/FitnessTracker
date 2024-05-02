import Foundation

enum TableViewCellIdentifier{
    
    static let fitnessOptionListCell = "FitnessOptionListCell"
    
}

enum URLEndPoint{
    
    private static let basePath = "https://fitness-calculator.p.rapidapi.com/"
    
    static let urlBMI = basePath + "bmi"
    static let urlDailyCaloryRequirement = basePath + "dailycalorie"
    static let urlBurntCaloryFromActivity = basePath + "burnedcalorie"
    static let urlBodyFatPercent = basePath + "bodyfat"
    static let urlIdealWeight = basePath + "idealweight"
    static let urlMacroCalculator = basePath + "macrocalculator"
    
}

enum ErrorMessage{
    static let errorMessage = "Something went wrong, Please try again later."
    static let emptyFieldMessage = "please fill all the fields."
}
