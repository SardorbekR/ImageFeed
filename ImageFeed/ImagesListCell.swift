import UIKit

final class ImagesListCell: UITableViewCell {
    // MARK: - Static Properties

    static let reuseIdentifier = "ImagesListCell"

    // MARK: - Outlets

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var photoImageView: UIImageView!

    // MARK: - Lifecycle

    override func prepareForReuse() {
        super.prepareForReuse()
        dateLabel.text = nil
        photoImageView.image = nil
        likeButton.isSelected = false
    }

    // MARK: - Configuration

    func configure(dateText: String, image: UIImage?, isLiked: Bool) {
        dateLabel.text = dateText
        photoImageView.image = image
        let heartImageName = isLiked ? "like_button_on" : "like_button_off"
        likeButton.setImage(UIImage(named: heartImageName), for: .normal)
    }
}
