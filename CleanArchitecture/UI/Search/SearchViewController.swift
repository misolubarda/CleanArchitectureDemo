//
//  SearchViewController.swift
//  CleanArchitecture
//
//  Created by Lubarda, Miso on 9/30/18.
//  Copyright © 2018 Lubarda, Miso. All rights reserved.
//

import UIKit

protocol SearchViewControllerDelegate: class {
    func searchViewControllerDidRequestSearch(with term: String)
}

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!

    weak var delegate: SearchViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }

    @IBAction func searchButtonTouchedUpInside(_ sender: UIButton) {
        guard let term = searchTextField.text, !term.isEmpty else { return }
        delegate?.searchViewControllerDidRequestSearch(with: term)
    }
}
