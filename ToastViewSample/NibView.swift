//
//  NibView.swift
//  TimeLineSample
//
//  Created by Terry Lee on 2020/4/23.
//  Copyright © 2020 Terry Lee. All rights reserved.
//

import UIKit

public class NibView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        backgroundColor = .clear
        if let view = loadViewFromNib() {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.translatesAutoresizingMaskIntoConstraints = true
            addSubview(view)
        }
    }

    private func loadViewFromNib() -> UIView? {
        return UINib(nibName: String(describing: type(of: self)), bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
    }

}
