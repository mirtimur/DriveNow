import UIKit

class ProcurementTableViewCell: UITableViewCell {
    @IBOutlet private weak var noteImageView: UIImageView!
    @IBOutlet private weak var noteLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    func configure(with item: ProcurementDTO) {
        noteLabel.text = item.procurement
        dateLabel.text = item.dateString
        noteImageView.image = UIImage(systemName: "cart")
    }
}
