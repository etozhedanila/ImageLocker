//
//  PincodeView.swift
//  ImageLocker
//
//  Created by Виталий Субботин on 28.06.2020.
//  Copyright © 2020 Виталий Субботин. All rights reserved.
//

import UIKit

protocol PincodeViewDelegate: class {
    
    func pincodeView(_ pincodeView: PincodeView, didFinishEnterPincode pincode: String)
}

class PincodeView: UIView, UITextInputTraits {
    
    weak var delegate: PincodeViewDelegate?
    
    var pincode = "" {
        didSet {
            didChangePincode()
        }
    }
    
    private let maxLength = 6

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    override var canBecomeFirstResponder: Bool {
        return true
    }

    var keyboardType: UIKeyboardType = .numberPad

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(stackView)
        makeConstraints()
        updateStack(with: "")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func resetView() {
        pincode = ""
        updateStack(with: "")
    }

    private func makeConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func didChangePincode() {
        updateStack(with: pincode)
        if pincode.count == maxLength {
            delegate?.pincodeView(self, didFinishEnterPincode: pincode)
        }
    }

    private func updateStack(with pincode: String) {
        var pins = Array(0..<maxLength).map { _ in Pin.emptyPin }
        let filledPins = Array(0..<pincode.count).map { _ in Pin.filledPin }
        filledPins.enumerated().forEach { pins[$0.offset] = $0.element }
        stackView.removeAllArrangedSubviews()
        pins.forEach { stackView.addArrangedSubview($0) }
    }
}

extension PincodeView: UIKeyInput {
    
    var hasText: Bool {
        return !pincode.isEmpty
    }

    func insertText(_ text: String) {
        if pincode.count == maxLength { return }
        pincode.append(contentsOf: text)
    }

    func deleteBackward() {
        if hasText {
            pincode.removeLast()
        }
    }
}

fileprivate extension UIStackView {
    
    func removeAllArrangedSubviews() {
        let subviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        subviews.forEach {
            $0.snp.removeConstraints()
            $0.removeFromSuperview()
        }
    }
}
