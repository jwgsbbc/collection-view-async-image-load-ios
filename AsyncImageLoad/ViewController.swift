//
//  ViewController.swift
//  AsyncImageLoad
//
//  Created by James Shephard on 06/07/2017.
//  Copyright © 2017 James Shephard. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private let imageWidth = 95
    private let imageHeight = 65
    
    private var imageCache = Dictionary<IndexPath, UIImage>()
    
    var imageProvider: ImageProvider?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    public override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "image_and_title", for: indexPath)
        
        guard let imageAndTitleCell = cell as? ImageAndTitleCell else {
            return cell
        }
        
        imageAndTitleCell.title?.text = String(format: "%d:%d", indexPath.section, indexPath.row);
        
        if let image = cachedImage(at: indexPath) {
            imageAndTitleCell.image?.isHidden = false
            imageAndTitleCell.image?.image = image
        }
        else {
            imageAndTitleCell.image?.isHidden = true
        }
        
        return imageAndTitleCell
    }
    
    func cachedImage(at indexPath: IndexPath) -> UIImage? {
        let image = imageCache[indexPath]
        if(image == nil) {
            loadImage(for: indexPath)
            return nil
        }
        else {
            return image
        }
    }
    
    func loadImage(for indexPath: IndexPath) {
        imageProvider?.loadImage(for: indexPath.row, width:imageWidth, height: imageHeight) { image in
            self.imageLoaded(image: image, for: indexPath)
        }
    }
    
    func imageLoaded(image: UIImage, for indexPath: IndexPath) {
        imageCache[indexPath] = image
        self.collectionView?.reloadItems(at: [indexPath])
    }
    
    


}

