//
//  TicketsListViewController.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

extension TicketsListViewController {
   
   private func createCollectionView(superView: UIView) -> UICollectionView {
      
      let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: TicketsListViewCollectionFlowLayout())
      collectionView.registerClass(TicketsListCollectionViewCell.self, forCellWithReuseIdentifier: TicketsListCollectionViewCell.identifier)
      collectionView.dataSource = self
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      collectionView.backgroundColor = UIColor.clearColor()
      superView.addSubview(collectionView)
      
      let dictViews: [String:AnyObject] = ["collection":collectionView, "layoutGuide":self.topLayoutGuide]
      superView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      superView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[layoutGuide]-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      
      return collectionView

   }
   
}

class TicketsListViewController: UIViewController {

   private var collectionView: UICollectionView?
   private var viewModel: TicketsListViewModel!
   
   init() {
      self.viewModel = TicketsListViewModel(tickets: [ Ticket(dictionary: ["subject":"This is a subject","id":1,"status":"new"])! ])
      super.init(nibName: nil, bundle: nil)
   }

   required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
   
   override func prefersStatusBarHidden() -> Bool {
      return false
   }
   
   override func loadView() {
      
      let view = UIView(frame: CGRect.zero)
      view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = UIColor.blueColor()
      
      self.view = view
      self.collectionView = createCollectionView(view)
      
   }
   
   override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
      super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
      collectionView?.reloadData()
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
