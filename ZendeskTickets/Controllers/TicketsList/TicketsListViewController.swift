//
//  TicketsListViewController.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class TicketsListViewController: UIViewController {

   private var collectionView: UICollectionView?
   private var viewModel: TicketsListViewModel!
   
   init() {
      self.viewModel = TicketsListViewModel(tickets: [])
      super.init(nibName: nil, bundle: nil)
   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   override func loadView() {
      
      let view = UIView(frame: CGRect.zero)
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = UIColor.blueColor()
      
      let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: TicketsListViewCollectionFlowLayout())
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

extension TicketsListViewController: UICollectionViewDataSource {

   func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      return viewModel.collectionViewNumberOfSections
   }
   
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return viewModel.collectionViewNumberOfItems(section)
   }
   
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCellWithReuseIdentifier(viewModel.cellIdentifier, forIndexPath: indexPath) as! TicketsListCollectionViewCell
      if let model = viewModel.cellViewModelAt(indexPath) {
         cell.update(model)
      }
      return cell
   }

}
