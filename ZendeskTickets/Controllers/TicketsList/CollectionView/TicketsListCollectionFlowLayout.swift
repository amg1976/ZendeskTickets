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
        get { return UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad ? CGSize(width: 320, height: 200) : CGSize(width: UIScreen.main.bounds.width-16, height: 100) }
    }
    
}
