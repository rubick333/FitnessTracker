import UIKit

class FitnessOptionListCell: UITableViewCell {
    
    @IBOutlet weak var lblTitleFitnessOption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(title:String){
        self.lblTitleFitnessOption.text = title
    }

}
