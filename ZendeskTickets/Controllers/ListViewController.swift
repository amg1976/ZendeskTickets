//
//  ViewController.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class ListViewControllerFlowLayout: UICollectionViewFlowLayout {

   override var itemSize: CGSize {
      set {}
      get { return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad ? CGSize(width: 200, height: 100) : CGSize(width: UIScreen.mainScreen().bounds.width, height: 50) }
   }

}

class ListViewController: UIViewController {

   private var collectionView: UICollectionView?
   
   override func loadView() {
      
      let view = UIView(frame: CGRect.zero)
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = UIColor.blueColor()
      
      let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: ListViewControllerFlowLayout())
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      collectionView.backgroundColor = UIColor.clearColor()
      view.addSubview(collectionView)
      
      let dictViews = ["collection":collectionView]
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      
      self.view = view
      self.collectionView = collectionView
      
   }
}

extension ListViewController: UICollectionViewDataSource {

   func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      return 1
   }
   
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 0
   }
   
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier("", forIndexPath: indexPath)
      return cell
   }

}
