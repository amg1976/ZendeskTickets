//
//  TicketsListViewController.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

extension TicketsListViewController {
   
   private func createCollectionView(superView: UIView, viewModel: TicketsListViewModel) -> UICollectionView {
      
      let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: TicketsListViewCollectionFlowLayout())
      collectionView.registerClass(TicketsListCollectionViewCell.self, forCellWithReuseIdentifier: TicketsListCollectionViewCell.identifier)
      collectionView.dataSource = self
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      collectionView.backgroundColor = viewModel.collectionViewBackgroundColor
      superView.addSubview(collectionView)
      
      let dictViews: [String:AnyObject] = ["collection":collectionView, "layoutGuide":self.topLayoutGuide]
      superView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      superView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[layoutGuide]-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
      
      if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
         collectionView.contentInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
      } else {
         collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
      }
      
      return collectionView

   }
   
}

class TicketsListViewController: UIViewController {

   private var collectionView: UICollectionView?
   private var activityView: UIActivityIndicatorView?
   private var viewModel: TicketsListViewModel!
   private var apiService: ZendeskApiService!
   
   init(apiService: ZendeskApiService) {
      self.apiService = apiService
      self.viewModel = TicketsListViewModel(apiService: apiService)
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
      view.backgroundColor = viewModel.viewBackgroundColor
      
      let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
      activityView.translatesAutoresizingMaskIntoConstraints = false
      activityView.hidesWhenStopped = true
      view.addSubview(activityView)
      view.addConstraint(NSLayoutConstraint(item: activityView, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
      view.addConstraint(NSLayoutConstraint(item: activityView, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))

      self.view = view
      self.collectionView = createCollectionView(view, viewModel: viewModel)
      self.activityView = activityView
      
   }
   
   override func viewWillAppear(animated: Bool) {
      super.viewWillAppear(animated)
      activityView?.startAnimating()
      viewModel.getTickets { [unowned self] (error) -> Void in
         if error == nil {
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
               self.activityView?.stopAnimating()
               self.collectionView?.reloadData()
            })
         } else {
            let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Destructive, handler: { [unowned self] (action) -> Void in
               self.dismissViewControllerAnimated(true, completion: nil)
            }))
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
               self.activityView?.stopAnimating()
               self.presentViewController(alert, animated: true, completion: nil)
            })
         }
      }
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
