import UIKit

class RefuelingTableViewCell: UITableViewCell {
    @IBOutlet private weak var fuelQuantityLabel: UILabel!
    @IBOutlet private weak var fuelTypeLabel: UILabel!
    @IBOutlet private weak var costLabel: UILabel!
    @IBOutlet private weak var odometerLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var refuelingStackView: UIStackView!
    @IBOutlet private weak var refuelingImageView: UIImageView!
    
    func configure(with item: HistoryDTO) {
        fuelQuantityLabel.text = "Количество заправленных литров: " + (item.fuelQuantity ?? "-")
        fuelTypeLabel.text = item.fuelType
        costLabel.text = (item.cost ?? "-") + " бел.руб"
        odometerLabel.text = (item.odometer ?? "-") + " км"
        dateLabel.text = item.dateString
        refuelingImageView.image = UIImage(systemName: "fuelpump.fill")
        refuelingStackView.layoutIfNeeded()
    }
}
