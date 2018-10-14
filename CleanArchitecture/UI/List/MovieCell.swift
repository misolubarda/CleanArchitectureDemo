//
//  MovieCell.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 06.10.18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private static var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .long
        return formatter
    }()
    private(set) var posterPath: String?

    override func prepareForReuse() {
        super.prepareForReuse()

        releaseDateLabel.text = nil
        posterImageView.image = nil
    }

    func setup(with title: String, release: Date?, description: String, posterPath: String?) {
        titleLabel.text = title
        descriptionLabel.text = description
        if let release = release {
            releaseDateLabel.text = MovieCell.dateFormatter.string(from: release)
        }
        self.posterPath = posterPath
    }

    func updatePosterImage(_ image: UIImage) {
        posterImageView.image = image
    }
}
