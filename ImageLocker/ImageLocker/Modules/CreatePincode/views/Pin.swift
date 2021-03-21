//
//  Pin.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

class Pin: UIView {
    
    static var emptyPin: Pin {
        let emptyPin = Pin()
        emptyPin.pin.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return emptyPin
    }

    static var filledPin: Pin {
        let filledPin = Pin()
        filledPin.pin.backgroundColor = .green
        return filledPin
    }

    let pin: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pin)
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeConstraints() {
        pin.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.center.equalToSuperview()
        }
    }
}
