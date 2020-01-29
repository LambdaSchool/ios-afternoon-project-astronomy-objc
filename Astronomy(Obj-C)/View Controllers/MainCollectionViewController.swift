//
//  MainCollectionViewController.swift
//  Astronomy(Obj-C)
//
//  Created by Jon Bash on 2020-01-27.
//  Copyright © 2020 Jon Bash. All rights reserved.
//

import UIKit

private let reuseIdentifier = "PhotoCell"

class MainCollectionViewController: UICollectionViewController {

    private let solLabel = UILabel()

    private let photoController = PhotoController()
    private var currentSolIndex: Int = 0
    private var currentSol: Sol?
    private var photoReferences: [PhotoReference] = []


    // MARK: - View Setup / Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitleView()
        fetchManfest()
    }

    private func configureTitleView() {
        let font = UIFont.systemFont(ofSize: 30)
        let attributes = [NSAttributedString.Key.font: font]

        let prevTitle = NSAttributedString(string: "<", attributes: attributes)
        let prevButton = UIButton(type: .system)
        prevButton.accessibilityIdentifier = "MainCollectionViewController.PreviousSolButton"
        prevButton.setAttributedTitle(prevTitle, for: .normal)
        prevButton.addTarget(self, action: #selector(goToPreviousSol(_:)), for: .touchUpInside)

        let nextTitle = NSAttributedString(string: ">", attributes: attributes)
        let nextButton = UIButton(type: .system)
        nextButton.setAttributedTitle(nextTitle, for: .normal)
        nextButton.addTarget(self, action: #selector(goToNextSol(_:)), for: .touchUpInside)
        nextButton.accessibilityIdentifier = "MainCollectionViewController.NextSolButton"

        let stackView = UIStackView(arrangedSubviews: [prevButton, solLabel, nextButton])
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem

        navigationItem.titleView = stackView
    }

    private func fetchManfest() {
        photoController.fetchMissionManifest { error in
            if let error = error {
                NSLog("Error fetching mission manifest: \(error)")
                return
            }
            if let sol10Index = self.photoController.sols.firstIndex(where: { $0.marsSol == 10 }) {
                self.currentSolIndex = sol10Index
                self.setCurrentSol()
            }
        }
    }

    private func updateViews() {
        if let sol = currentSol {
            solLabel.text = "Sol \(sol.marsSol)"
        }
        if collectionView.numberOfItems(inSection: 0) > 0 {
            collectionView.scrollToItem(
                at: IndexPath(item: 0, section: 0),
                at: .top,
                animated: true)
        }
        collectionView.reloadData()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return photoReferences.count
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                 for: indexPath) as? PhotoCollectionViewCell
            else { return UICollectionViewCell() }
        return cell
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        didEndDisplaying cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let cell = cell as? PhotoCollectionViewCell else { return }
        self.photoController.cancelPhotoFetch(for: cell.photoRef)
        cell.photoRef = nil
        cell.imageView?.image = nil
    }

    override func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        guard let photoCell = cell as? PhotoCollectionViewCell else { return }

        let photoRef = photoReferences[indexPath.row]
        photoCell.photoRef = photoRef

        photoController.fetchPhoto(for: photoRef) { image, error in
            if let error = error {
                NSLog("Error fetching photo: \(error)")
                return
            }
            guard photoCell.photoRef == photoRef else { return }
            DispatchQueue.main.async {
                photoCell.imageView?.image = image
            }
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoDetailSegue",
            let detailVC = segue.destination as? PhotoDetailViewController,
            let indexPath = collectionView.indexPathsForSelectedItems?.first,
            let cell = collectionView.cellForItem(at: indexPath) as? PhotoCollectionViewCell {

            let photoRef = photoReferences[indexPath.row]
            detailVC.photoRef = photoRef
            detailVC.image = cell.imageView?.image
            detailVC.sol = currentSol
            print("Segueing to detailVC for photoRefID \(photoRef.photoID)")
        }
    }

    // MARK: - Private Helpers

    @objc
    private func goToPreviousSol(_ sender: Any) {
        currentSolIndex = (currentSolIndex <= 0) ? 0 : currentSolIndex - 1
        setCurrentSol()
    }

    @objc
    private func goToNextSol(_ sender: Any) {
        currentSolIndex = (currentSolIndex >= photoController.sols.count - 1)
            ? photoController.sols.count
            : currentSolIndex + 1
        setCurrentSol()
    }

    private func setCurrentSol() {
        if currentSolIndex < photoController.sols.count && currentSolIndex >= 0 {
            let sol = photoController.sols[currentSolIndex]
            currentSol = sol
            photoReferences = []
            self.photoController.fetchPhotoReferences(for: sol) { photoRefs, error in
                guard sol == self.currentSol else {
                    return // if the sol has already changed, this instance of the closure is now moot
                }
                if let error = error {
                    NSLog("Error fetching photoRefs: \(error)")
                    return
                }
                self.photoReferences = photoRefs ?? []
                DispatchQueue.main.async { self.collectionView.reloadData() }
            }
            DispatchQueue.main.async { self.updateViews() }
        }
    }
}
