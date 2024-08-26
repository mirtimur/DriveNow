import UIKit

class ServiceTableViewCell: UITableViewCell {
    @IBOutlet private weak var serviceLabel: UILabel!
    @IBOutlet private weak var odometerLabel: UILabel!
    @IBOutlet private weak var noteLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var serviceImageView: UIImageView!
    @IBOutlet private weak var serviceStackView: UIStackView!
    
    func configure(with item: HistoryDTO) {
        serviceLabel.text = item.serviceType
        odometerLabel.text = (item.odometer ?? "-") + " км"
        noteLabel.text = item.notes
        dateLabel.text = item.dateString
        serviceImageView.image = UIImage(systemName: "gearshape.2.fill")
        serviceStackView.layoutIfNeeded()
    }
}
