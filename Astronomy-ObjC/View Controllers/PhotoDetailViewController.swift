//
//  PhotoDetailViewController.swift
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/5/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {

    // MARK: - Properties

    var photo: MarsPhoto! {
        didSet {
            updateViews()
        }
    }


    // MARK: - IBOutlets

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var cameraLabel: UILabel!


    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func updateViews() {

    }


    // MARK: - Actions

    @IBAction func saveToPhotoLibrary(_ sender: UIButton) {

    }
}
