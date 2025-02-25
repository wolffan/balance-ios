//
//  CDPInfoView.swift
//  Balance
//
//  Created by Benjamin Baron on 3/10/19.
//  Copyright © 2019 Balance. All rights reserved.
//

import UIKit
import SnapKit

private let numberFormatter: NumberFormatter = {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 0
    return numberFormatter
}()

class CDPInfoView: UIView {
    private let mkrGreenImageView: UIImageView = {
        let mkrGreenImageView = UIImageView(image: UIImage(named: "mkrGreen"))
        mkrGreenImageView.frame = CGRect(x:0, y: 0, width: 32, height: 32)
        mkrGreenImageView.translatesAutoresizingMaskIntoConstraints = false
        return mkrGreenImageView
    }()
    
    private let identifierLabel: UILabel = {
        let identifierLabel = UILabel()
        identifierLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        identifierLabel.textColor = .white
        identifierLabel.translatesAutoresizingMaskIntoConstraints = false
        return identifierLabel
    }()
    
    private let collateralTitleLabel: UILabel = {
        let collateralTitleLabel = UILabel()
        collateralTitleLabel.text = "COLLATERAL"
        collateralTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        collateralTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        collateralTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return collateralTitleLabel
    }()
    
    private let ethCircleImageView: UIImageView = {
        let ethCircleImage = UIImage(named: "ethWhiteCircle")
        let ethCircleImageView = UIImageView(image: ethCircleImage)
        ethCircleImageView.frame = CGRect(x:0, y: 0, width: 20, height: 20)
        ethCircleImageView.translatesAutoresizingMaskIntoConstraints = false
        return ethCircleImageView
    }()
    
    private let etherTitleLabel: UILabel = {
        let etherTitleLabel = UILabel()
        etherTitleLabel.text = "Ether"
        etherTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        etherTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        etherTitleLabel.textColor = .white
        return etherTitleLabel
    }()
    
    private let collateralBreakdownLabel: UILabel = {
        let collateralBreakdownLabel = UILabel()
        collateralBreakdownLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        collateralBreakdownLabel.translatesAutoresizingMaskIntoConstraints = false
        collateralBreakdownLabel.textColor = .white
        return collateralBreakdownLabel
    }()
    
    private let debtTitleLabel: UILabel = {
        let debtTitleLabel = UILabel()
        debtTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        debtTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        debtTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        debtTitleLabel.text = "DEBT"
        return debtTitleLabel
    }()
    
    private let daiCircleImageView: UIImageView = {
        let daiCircleImage = UIImage(named: "daiCircle")
        let daiCircleImageView = UIImageView(image: daiCircleImage)
        daiCircleImageView.frame = CGRect(x:0, y: 0, width: 20, height: 20)
        daiCircleImageView.translatesAutoresizingMaskIntoConstraints = false
        return daiCircleImageView
    }()
    
    private let daiTitleLabel: UILabel = {
        let daiTitleLabel = UILabel()
        daiTitleLabel.text = "Dai"
        daiTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        daiTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        daiTitleLabel.textColor = .white
        return daiTitleLabel
    }()
    
    private let debtBreakdownLabel: UILabel = {
        let debtBreakdownLabel = UILabel()
        debtBreakdownLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        debtBreakdownLabel.translatesAutoresizingMaskIntoConstraints = false
        debtBreakdownLabel.textColor = .white
        return debtBreakdownLabel
    }()
    
    private let positionTitleLabel: UILabel = {
        let positionTitleLabel = UILabel()
        positionTitleLabel.text = "POSITION"
        positionTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        positionTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        positionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return positionTitleLabel
    }()
    
    private let riskTitleLabel: UILabel = {
        let riskTitleLabel = UILabel()
        riskTitleLabel.text = "RISK"
        riskTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        riskTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        riskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return riskTitleLabel
    }()
    
    private let priceTitleLabel: UILabel = {
        let priceTitleLabel = UILabel()
        priceTitleLabel.text = "PRICE"
        priceTitleLabel.textAlignment = .center
        priceTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        priceTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return priceTitleLabel
    }()
    
    private let ratioTitleLabel: UILabel = {
        let ratioTitleLabel = UILabel()
        ratioTitleLabel.text = "RATIO"
        ratioTitleLabel.textAlignment = .right
        ratioTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        ratioTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        ratioTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratioTitleLabel
    }()
    
    private let riskLabel: UILabel = {
        let riskLabel = PaddedLabel()
        riskLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        riskLabel.padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        riskLabel.textColor = UIColor(red: 0.176, green: 0.196, blue: 0.220, alpha: 1.000)
        riskLabel.layer.cornerRadius = 5
        riskLabel.clipsToBounds = true
        riskLabel.translatesAutoresizingMaskIntoConstraints = false
        return riskLabel
    }()
    
    private let liqPriceLabel: UILabel = {
        let liqPriceLabel = PaddedLabel()
        liqPriceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        liqPriceLabel.padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        liqPriceLabel.textColor = UIColor(red: 0.176, green: 0.196, blue: 0.220, alpha: 1.000)
        liqPriceLabel.layer.cornerRadius = 5
        liqPriceLabel.clipsToBounds = true
        liqPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        return liqPriceLabel
    }()
    
    private let ratioLabel: UILabel = {
        let ratioLabel = PaddedLabel()
        ratioLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        ratioLabel.padding = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 4)
        ratioLabel.textColor = UIColor(red: 0.176, green: 0.196, blue: 0.220, alpha: 1.000)
        ratioLabel.layer.cornerRadius = 5
        ratioLabel.clipsToBounds = true
        ratioLabel.translatesAutoresizingMaskIntoConstraints = false
        return ratioLabel
    }()
    
    private let riskBarImageView: UIImageView = {
        let riskBarImage = UIImage(named: "riskbar")
        let riskBarImageView = UIImageView(image: riskBarImage)
        riskBarImageView.frame = CGRect(x:0, y: 0, width: 345, height: 23)
        riskBarImageView.translatesAutoresizingMaskIntoConstraints = false
        return riskBarImageView
    }()
    
    private let riskDotImageView: UIImageView = {
        let riskDotImage = UIImage(named: "riskDot")
        let riskDotImageView = UIImageView(image: riskDotImage)
        riskDotImageView.frame = CGRect(x:0, y: 0, width: 345, height: 23)
        riskDotImageView.translatesAutoresizingMaskIntoConstraints = false
        return riskDotImageView
    }()
    
    private let rektLabel: UILabel = {
        let rektLabel = UILabel()
        rektLabel.text = "150%"
        rektLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        rektLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        rektLabel.translatesAutoresizingMaskIntoConstraints = false
        return rektLabel
    }()
    
    private let dangerLabel: UILabel = {
        let dangerLabel = UILabel()
        dangerLabel.text = "250%"
        dangerLabel.textAlignment = .center
        dangerLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        dangerLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        dangerLabel.translatesAutoresizingMaskIntoConstraints = false
        return dangerLabel
    }()
    
    private let saferLabel: UILabel = {
        let saferLabel = UILabel()
        saferLabel.text = "350%"
        saferLabel.textAlignment = .right
        saferLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        saferLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        saferLabel.translatesAutoresizingMaskIntoConstraints = false
        return saferLabel
    }()
    
    private let plainEnglishContainerView: UIView = {
        let plainEnglishContainerView = UIView()
        // TODO Find a way to get the UILabel to stretch dynamically.
        plainEnglishContainerView.translatesAutoresizingMaskIntoConstraints = false
        return plainEnglishContainerView
    }()
    
    private let plainEnglishExplanationLabel: UILabel = {
        let plainEnglishExplanationLabel = UILabel()
        plainEnglishExplanationLabel.translatesAutoresizingMaskIntoConstraints = false
        plainEnglishExplanationLabel.textAlignment = .center
        plainEnglishExplanationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        plainEnglishExplanationLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.5)
        plainEnglishExplanationLabel.lineBreakMode = .byWordWrapping
        plainEnglishExplanationLabel.numberOfLines = 0
        return plainEnglishExplanationLabel
    }()
    
    init(cdpItem: CDP) {
        super.init(frame: CGRect.zero)
        
        backgroundColor = UIColor(red:0.11, green:0.13, blue:0.16, alpha:1.0)
        clipsToBounds = true
        layer.cornerRadius = 20
        
        addSubview(mkrGreenImageView)
        mkrGreenImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
        }
        
        let id = cdpItem.id != nil ? "#\(cdpItem.id!)" : ""
        identifierLabel.text = "Maker CDP \(id)"
        addSubview(identifierLabel)
        identifierLabel.snp.makeConstraints { make in
            make.leading.equalTo(mkrGreenImageView.snp.trailing).offset(10)
            make.centerY.equalTo(mkrGreenImageView)
        }

        addSubview(collateralTitleLabel)
        collateralTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mkrGreenImageView)
            make.top.equalTo(mkrGreenImageView.snp.bottom).offset(15)
        }

        addSubview(ethCircleImageView)
        ethCircleImageView.snp.makeConstraints { make in
            make.top.equalTo(collateralTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(mkrGreenImageView)
        }

        addSubview(etherTitleLabel)
        etherTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(ethCircleImageView.snp.trailing).offset(10)
            make.centerY.equalTo(ethCircleImageView)
        }

        if let ink = cdpItem.ink {
            if let pip = cdpItem.pip {
                let inkString = numberFormatter.string(from: NSNumber(value: ink))
                let pipString = numberFormatter.string(from: NSNumber(value: pip))
                if let inkString = inkString, let pipString = pipString {
                    collateralBreakdownLabel.text = "\(inkString) ETH * \(pipString) USD"
                } else {
                    print("Failed to format inkString: \(String(describing: inkString)) or pipString: \(String(describing: pipString))")
                }
            }
        }
        addSubview(collateralBreakdownLabel)
        collateralBreakdownLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.top.equalTo(collateralTitleLabel.snp.bottom).offset(10)
        }

        addSubview(debtTitleLabel)
        debtTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mkrGreenImageView)
            make.top.equalTo(ethCircleImageView.snp.bottom).offset(15)
        }

        addSubview(daiCircleImageView)
        daiCircleImageView.snp.makeConstraints { make in
            make.top.equalTo(debtTitleLabel.snp.bottom).offset(10)
            make.leading.equalTo(mkrGreenImageView)
        }

        addSubview(daiTitleLabel)
        daiTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(daiCircleImageView.snp.trailing).offset(10)
            make.centerY.equalTo(daiCircleImageView)
        }

        if let art = cdpItem.art {
            let artString = numberFormatter.string(from: NSNumber(value:art))
            if let artString = artString {
                debtBreakdownLabel.text = "\(artString) DAI * 1.00 USD"
            } else {
                print("Failed to format artString: \(String(describing: artString))")
            }
        }
        addSubview(debtBreakdownLabel)
        debtBreakdownLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalTo(daiCircleImageView)
        }

        addSubview(positionTitleLabel)
        positionTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mkrGreenImageView)
            make.top.equalTo(debtBreakdownLabel.snp.bottom).offset(15)
        }

        addSubview(riskTitleLabel)
        riskTitleLabel.snp.makeConstraints { make in
            make.leading.equalTo(mkrGreenImageView)
            make.top.equalTo(positionTitleLabel.snp.bottom).offset(10)
        }

        addSubview(priceTitleLabel)
        priceTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(riskTitleLabel)
        }

        addSubview(ratioTitleLabel)
        ratioTitleLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalTo(riskTitleLabel)
        }

        var riskColor = UIColor.white
        var riskRange = "Unknown"
        if let ratio = cdpItem.ratio {
            if ratio < 150.00 {
                riskColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.5)
                riskRange = "Liquidated"
            } else if ratio < 200.00 {
                riskColor = .red
                riskRange = "Higher"
            } else if ratio < 250.00 {
                riskColor = .orange
                riskRange = "Medium"
            } else if ratio > 300.00 {
                riskColor = .green
                riskRange = "Lower"
            }
        }
        riskLabel.text = riskRange
        riskLabel.backgroundColor = riskColor
        addSubview(riskLabel)
        riskLabel.snp.makeConstraints { make in
            make.leading.equalTo(riskTitleLabel)
            make.top.equalTo(riskTitleLabel.snp.bottom).offset(5)
        }

        if let liqPrice = cdpItem.liqPrice, let pip = cdpItem.pip {
            liqPriceLabel.text = "$\(String(format:"%.0f", pip)) / \(String(format:"%.0f", liqPrice))"
        }
        liqPriceLabel.backgroundColor = riskColor
        addSubview(liqPriceLabel)
        liqPriceLabel.snp.makeConstraints { make in
            make.centerX.equalTo(priceTitleLabel)
            make.top.equalTo(priceTitleLabel.snp.bottom).offset(5)
        }

        if let ratio = cdpItem.ratio {
            ratioLabel.text = " \(String(format:"%.0f", ratio))%"
        }
        ratioLabel.backgroundColor = riskColor
        addSubview(ratioLabel)
        ratioLabel.snp.makeConstraints { make in
            make.trailing.equalTo(ratioTitleLabel)
            make.top.equalTo(ratioTitleLabel.snp.bottom).offset(5)
        }

        addSubview(riskBarImageView)
        riskBarImageView.snp.makeConstraints { make in
            make.top.equalTo(riskLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
        }

        addSubview(riskDotImageView)
        riskDotImageView.snp.makeConstraints { make in
            make.centerY.equalTo(riskBarImageView)
        }

        let width = riskBarImageView.frame.size.width
        print(width)
        let widthPercent:Double = Double(width / 100.00)
        print(widthPercent)
        if let ratio = cdpItem.ratio {
            if ratio <= 150.00 {
                riskDotImageView.leadingAnchor.constraint(equalTo: riskBarImageView.leadingAnchor, constant: 0).isActive = true
            } else if ratio >= 320.00 {
                riskDotImageView.trailingAnchor.constraint(equalTo: riskBarImageView.trailingAnchor, constant: 0).isActive = true
            } else {
                let pointsAway = ratio - 150.00
                let riskDotPositionFromLeft = (pointsAway / 2) * widthPercent
                riskDotImageView.leadingAnchor.constraint(equalTo: riskBarImageView.leadingAnchor, constant: CGFloat(riskDotPositionFromLeft)).isActive = true
            }
        }
        addSubview(rektLabel)
        rektLabel.snp.makeConstraints { make in
            make.leading.equalTo(mkrGreenImageView)
            make.top.equalTo(riskBarImageView.snp.bottom).offset(10)
        }

        addSubview(dangerLabel)
        dangerLabel.snp.makeConstraints { make in
            make.centerX.equalTo(riskBarImageView)
            make.centerY.equalTo(rektLabel)
        }

        addSubview(saferLabel)
        saferLabel.snp.makeConstraints { make in
            make.trailing.equalTo(riskBarImageView)
            make.centerY.equalTo(rektLabel)
        }

        addSubview(plainEnglishContainerView)
        plainEnglishContainerView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(60)
            make.leading.equalTo(mkrGreenImageView)
            make.trailing.equalTo(saferLabel)
            make.top.equalTo(rektLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        var textForPlainEnglishExplanationLabel = ""
        if let liqPrice = cdpItem.liqPrice {
            textForPlainEnglishExplanationLabel = "If Ether drops to $\(String(format:"%.0f", liqPrice)) your CDP will hit the ratio of 150% and be liquidated."
        }
        plainEnglishExplanationLabel.text = textForPlainEnglishExplanationLabel
        plainEnglishExplanationLabel.sizeToFit()
        addSubview(plainEnglishExplanationLabel)
        plainEnglishExplanationLabel.snp.makeConstraints { make in
            make.leading.equalTo(mkrGreenImageView)
            make.trailing.equalTo(saferLabel)
            make.top.equalTo(rektLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("unimplemented")
    }
}
