//
//  ImagePreviewCell.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

//struct ImagePreviewModel {
//    var image: UIImage
//}

class ImagePreviewCellConfigurator: CollectionCellConfigurator<ImagePreviewCell, PhotoCellModel> {
    
    init(model: PhotoCellModel) {
        super.init(model: model, size: UIScreen.main.bounds.size)
    }
}

class ImagePreviewCell: UICollectionViewCell {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        return scrollView
    }()
    
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(scrollView)
        scrollView.addSubview(photoView)
        configureGesture()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        scrollView.setZoomScale(1.0, animated: true)
        photoView.image = nil
    }
    
    private func configureGesture() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTap)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        photoView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView)
        }
    }
    
    @objc private func handleDoubleTap(_ sender: UITapGestureRecognizer) {
        if scrollView.zoomScale == scrollView.minimumZoomScale {
            let location = sender.location(in: sender.view)
            let rectToZoom = zommingRectFor(scale: scrollView.maximumZoomScale, center: location)
            scrollView.zoom(to: rectToZoom, animated: true)
        } else {
            scrollView.setZoomScale(scrollView.minimumZoomScale, animated: true)
        }
    }
    
    private func zommingRectFor(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        let bounds = scrollView.bounds
        
        zoomRect.size.width = bounds.size.width / scale
        zoomRect.size.height = bounds.size.height / scale
        
        zoomRect.origin.x = center.x - (zoomRect.size.width / 2)
        zoomRect.origin.y = center.y - (zoomRect.size.height / 2)
        return zoomRect
    }
}

extension ImagePreviewCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        self.photoView
    }
}

extension ImagePreviewCell: CollectionConfigurable {
    
    func configure(model: PhotoCellModel) {
        photoView.image = model.image
    }
}
