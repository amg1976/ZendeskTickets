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
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    override func loadView() {
        self.view = createMainView(withViewModel: viewModel)
        self.collectionView = createCollectionView(parentView: view, viewModel: viewModel)
        self.activityView = createActivityView(parentView: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData(fromViewModel: viewModel)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.reloadData()
    }
    
}

extension TicketsListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.collectionViewNumberOfSections
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.collectionViewNumberOfItems(inSection: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.cellIdentifier, for: indexPath) as! TicketsListCollectionViewCell
        if let model = viewModel.cellViewModel(forIndexPath: indexPath) {
            cell.update(withModel: model)
        }
        return cell
    }
    
}

private extension TicketsListViewController {
    
    func createMainView(withViewModel model: TicketsListViewModel) -> UIView {
        let view = UIView(frame: CGRect.zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = viewModel.viewBackgroundColor
        return view
    }
    
    func createActivityView(parentView superview: UIView) -> UIActivityIndicatorView {
        let activityView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.hidesWhenStopped = true
        superview.addSubview(activityView)
        superview.addConstraint(NSLayoutConstraint(item: activityView, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: superview, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0))
        superview.addConstraint(NSLayoutConstraint(item: activityView, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: superview, attribute: NSLayoutAttribute.centerY, multiplier: 1, constant: 0))

        return activityView
    }
    
    func createCollectionView(parentView superview: UIView, viewModel: TicketsListViewModel) -> UICollectionView {
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: TicketsListViewCollectionFlowLayout())
        collectionView.register(TicketsListCollectionViewCell.self, forCellWithReuseIdentifier: TicketsListCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = viewModel.collectionViewBackgroundColor
        superview.addSubview(collectionView)
        
        let dictViews: [String:AnyObject] = ["collection":collectionView, "layoutGuide":self.topLayoutGuide]
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[layoutGuide]-(0)-[collection]-(0)-|", options: NSLayoutFormatOptions([]), metrics: nil, views: dictViews))
        
        if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
            collectionView.contentInset = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        }
        
        return collectionView
        
    }

    func loadData(fromViewModel viewModel: TicketsListViewModel) {

        activityView?.startAnimating()
        
        viewModel.getTickets { [unowned self] (error) -> Void in
            if error == nil {
                DispatchQueue.main.async(execute: { () -> Void in
                    self.activityView?.stopAnimating()
                    self.collectionView?.reloadData()
                })
            } else {
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.destructive, handler: { [unowned self] (action) -> Void in
                    self.dismiss(animated: true, completion: nil)
                }))
                DispatchQueue.main.async(execute: { () -> Void in
                    self.activityView?.stopAnimating()
                    self.present(alert, animated: true, completion: nil)
                })
            }
        }

    }
    
}
