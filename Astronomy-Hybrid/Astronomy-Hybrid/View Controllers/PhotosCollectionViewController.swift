//
//  PhotosCollectionViewController.swift
//  Astronomy-Hybrid
//
//  Created by Isaac Lyons on 12/16/19.
//  Copyright © 2019 Isaac Lyons. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class PhotosCollectionViewController: UICollectionViewController {
    
    //MARK: Properties
    
    let client = MarsRoverClient()
    var rover: MarsRover? {
        didSet {
            guard let rover = rover else { return }
            
            self.title = "\(rover.name) Rover"
            
            //guard let firstSol = rover.sols.first else { return }
            
            self.client.fetchPhotos(from: rover, onSol: 1) { photos, error in
                if let error = error {
                    NSLog("\(error)")
                    return
                }
                
                guard let photos = photos else {
                    NSLog("No photos returned")
                    return
                }
                
                DispatchQueue.main.async {
                    //print(photos)
                    self.photos = photos
                }
            }
        }
    }
    var photos: [MarsPhotoReference] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let photoFetchQueue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        client.fetchMarsRoverNamed("curiosity") { rover, error in
            if let error = error {
                NSLog("\(error)")
                return
            }
            
            guard let rover = rover else {
                NSLog("No rover returned")
                return
            }
            
            DispatchQueue.main.async {
                print("Rover: \(rover.name)")
                //print("Sols: \(rover.sols)")
                
                self.rover = rover
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(photos.count)
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImageCollectionViewCell else {
            return UICollectionViewCell()
        }
    
        loadImage(forCell: cell, forItemAt: indexPath)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    //MARK: Private
    
    private func loadImage(forCell cell: ImageCollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let photoReference = photos[indexPath.item]
        
        let fetchOperation = LSIFetchPhotoOperation(photoReference: photoReference)
        
        let setCellImage = BlockOperation {
            guard let image = UIImage(data: fetchOperation.imageData ?? Data()) else { return }
            if self.collectionView.indexPath(for: cell) == indexPath {
                cell.imageView.image = image
                print("Cell image set for cell \(indexPath.item)")
            }
        }
        
        setCellImage.addDependency(fetchOperation)
        
        photoFetchQueue.addOperations([fetchOperation], waitUntilFinished: false)
        OperationQueue.main.addOperations([setCellImage], waitUntilFinished: false)
        
    }

}

//MARK: Collection view delegate flow layout

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
}
