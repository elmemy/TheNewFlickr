//
//  PhotoListTableViewCell.swift
//  TheNewFlickr
//
//  Created by Ahmed Elmemy on 18/07/2021.
//

import Foundation
import UIKit
import Kingfisher

class PhotoListTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descContainerHeightConstraint: NSLayoutConstraint!
    var photoListCellViewModel : PhotoListCellViewModel? {
        didSet {
            nameLabel.text = photoListCellViewModel?.titleText
            descriptionLabel.text = photoListCellViewModel?.descText
            
            
            let processor = DownsamplingImageProcessor(size: mainImageView.bounds.size)
                |> RoundCornerImageProcessor(cornerRadius: 50)
            
            mainImageView.kf.indicatorType = .activity
            
            mainImageView.kf.setImage(
                with: URL(string: photoListCellViewModel?.imageUrl ?? "" ),
                options: [
                    .processor(processor),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }
    }
}
