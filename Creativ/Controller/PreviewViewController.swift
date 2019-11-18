//
//  PreviewViewController.swift
//  Creativ
//
//  Created by Robby Awalul Meviansyah Abdillah on 07/11/19.
//  Copyright © 2019 William Inx. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {

    @IBOutlet weak var feedbackCollectionView: UICollectionView!
    
    let feedbackContents = FeedbackContent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneReview))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.init(hex: "#FFD296FF")
        self.navigationItem.title = "Feedback"
        feedbackCollectionView.delegate = self
        feedbackCollectionView.register(UINib(nibName: "FeedbackHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FeedbackHeaderCollectionReusableView")
        feedbackCollectionView.register(UINib(nibName: "FeedbackCollectionViewCell", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "FeedbackCollectionViewCell")

        // Do any additional setup after loading the view.
        setCollectionViewLayout()
        feedbackContents.createFeedbackSection()
    }
    
    // Unwind back to the All Resume Page
    @objc func doneReview(_ unwindSegue: UIStoryboardSegue) {
        performSegue(withIdentifier: "unwindToHome", sender: self)
    }
    func setCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = layout.minimumInteritemSpacing * 2
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.feedbackCollectionView.frame.width, height: self.feedbackCollectionView.frame.height * 7/11)
        feedbackCollectionView.collectionViewLayout = layout
    }

}

extension PreviewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feedbackContents.titles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("setopbiasa")
        let cell = feedbackCollectionView.dequeueReusableCell(withReuseIdentifier: "FeedbackCollectionViewCell", for: indexPath) as! FeedbackCollectionViewCell
        let cellFeedback = Feedbacks(image: feedbackContents.images[indexPath.row], title: feedbackContents.titles[indexPath.row], overviewText: feedbackContents.overviewTexts[indexPath.row], commentedText: feedbackContents.commentedTexts[indexPath.row], comment: feedbackContents.comments[indexPath.row], recommendation: feedbackContents.recommendations[indexPath.row])
        
        cell.setColor(colorView: &cell.feedbackView)
        cell.setColor(colorView: &cell.notchView)
        cell.setColor(colorView: &cell.commentView)
        cell.setupUI()
        cell.displayFeedbackContent(feedback: cellFeedback)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) ->
        UICollectionReusableView {
        if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "FeedbackHeaderCollectionReusableView", for: indexPath) as? UICollectionReusableView {
            return headerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: 0))?.frame.height ?? collectionView.frame.height / 5)
    }
}
