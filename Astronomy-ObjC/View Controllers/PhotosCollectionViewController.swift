//
//  PhotosCollectionViewController.swift
//  Astronomy-ObjC
//
//  Created by Chad Parker on 8/5/20.
//  Copyright © 2020 Chad Parker. All rights reserved.
//

import UIKit

class PhotosCollectionViewController: UIViewController {

    // MARK: - Properties


    // MARK: - IBOutlets

    @IBOutlet var collectionView: UICollectionView!


    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}
