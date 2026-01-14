import UIKit

final class ImagesListCell: UITableViewCell {
    // MARK: - Static Properties

    static let reuseIdentifier = "ImagesListCell"

    // MARK: - Outlets

    @IBOutlet weak var dateLabel: UILabel?
    @IBOutlet weak var likeButton: UIButton?
    @IBOutlet weak var photoImageView: UIImageView?
}
