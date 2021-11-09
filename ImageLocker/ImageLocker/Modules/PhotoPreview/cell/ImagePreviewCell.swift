//
//  ImagePreviewCell.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 02.08.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

class ImagePreviewCellConfigurator: CollectionCellConfigurator<ImagePreviewCell, SavedPhotoCellModel> {
    
    init(model: SavedPhotoCellModel) {
        super.init(model: model, size: UIScreen.main.bounds.size)
    }
}

class ImagePreviewCell: UICollectionViewCell {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
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
        self.scrollView.zoomScale = scrollView.minimumZoomScale
        photoView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerImage()
    }
    
    func willDisplay() {
        scrollView.zoomScale = scrollView.minimumZoomScale
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setDefaultZoomScales() {
        let boundsSize = scrollView.bounds.size
        let imageSize = photoView.bounds.size
        
        let xScale = boundsSize.width / imageSize.width
        let yScale = boundsSize.height / imageSize.height
        let minScale = min(xScale, yScale)
        
        var maxScale: CGFloat = 1.0
        switch minScale {
        case ..<0.1: maxScale = 0.3
        case 0.1..<0.5: maxScale = 0.7
        case 0.5...: maxScale = max(1.0, minScale)
        default: return
        }
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = maxScale
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
    
    private func centerImage() {
        let boundsSize = scrollView.bounds.size
        var frameToCenter = photoView.frame
        
        if frameToCenter.size.width < boundsSize.width {
            frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2
        } else {
            frameToCenter.origin.x = 0
        }
        
        if frameToCenter.size.height < boundsSize.height {
            frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2
        } else {
            frameToCenter.origin.y = 0
        }
        
        photoView.frame = frameToCenter
    }
}

// MARK: Gestures
extension ImagePreviewCell {
    
    private func configureGesture() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_:)))
        doubleTap.numberOfTapsRequired = 2
        photoView.addGestureRecognizer(doubleTap)
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
}

// MARK: - UIScrollViewDelegate
extension ImagePreviewCell: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? { self.photoView }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerImage()
    }
}

// MARK: - CollectionConfigurable
extension ImagePreviewCell: CollectionConfigurable {
    
    func configure(model: SavedPhotoCellModel) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let image = UIImage(contentsOfFile: model.url.path) else { return }
            DispatchQueue.main.async {
                self.configure(image: image)
            }
        }
    }
    
    private func configure(image: UIImage?) {
        self.photoView.image = image
        guard let image = image else { return }
        self.scrollView.contentSize = image.size
        self.photoView.frame.size = image.size
        self.setDefaultZoomScales()
        self.scrollView.zoomScale = self.scrollView.minimumZoomScale
    }
}
