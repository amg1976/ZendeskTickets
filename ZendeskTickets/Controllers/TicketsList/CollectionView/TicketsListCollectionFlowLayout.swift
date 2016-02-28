//
//  TicketsListCollectionFlowLayout.swift
//  ZendeskTickets
//
//  Created by Adriano Goncalves on 28/02/2016.
//  Copyright © 2016 Adriano Goncalves. All rights reserved.
//

import UIKit

class TicketsListViewCollectionFlowLayout: UICollectionViewFlowLayout {
   
   override var itemSize: CGSize {
      set {}
      get { return UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad ? CGSize(width: 200, height: 100) : CGSize(width: UIScreen.mainScreen().bounds.width, height: 50) }
   }
   
}