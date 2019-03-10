import UIKit
import CoreData
import SwiftEntryKit

class BalanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let cdpsTableView = UITableView()
    var CDPs = [CDP]()
    
    func getData() {
        CDPs.removeAll()
        
        // Load MakerDAO CDPs
        let makers = CoreDataHelper.loadAllMakers()
        MakerToolsAPI.loadMakerCDPs(makers) { CDPs in
            self.CDPs.append(contentsOf: CDPs)
            self.cdpsTableView.reloadData()
        }
        
        // Load Ethereum Wallets
        let ethereumAddresses = CoreDataHelper.loadAllEthereumAddresses()
        MakerToolsAPI.loadEthereumAddressCDPs(ethereumAddresses) { CDPs in
            self.CDPs.append(contentsOf: CDPs)
            self.cdpsTableView.reloadData()
        }
    }
    
    func setUpNavigation() {
        navigationItem.title = ""
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        cdpsTableView.backgroundColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0)
        
        cdpsTableView.dataSource = self
        cdpsTableView.delegate = self
        
        cdpsTableView.register(CDPTableViewCell.self, forCellReuseIdentifier: "cdpCell")
        view.addSubview(cdpsTableView)
        cdpsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        cdpsTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        cdpsTableView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor).isActive = true
        cdpsTableView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor).isActive = true
        cdpsTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        
        cdpsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        setUpNavigation()
        getData()
    }
    
    func deleteAllData(_ entity:String) {
        
        let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        print("FETCHING")
        print(fetchRequest)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            print(results)
            for managedObject in results {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                context.delete(managedObjectData)
                try context.save()
            }
        } catch let error as NSError {
            print("Deleted all my data in myEntity error : \(error) \(error.userInfo)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CDPs.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        let row = indexPath.row
        print("Row: \(row)")
 
        var attributes = EKAttributes()
        attributes = .centerFloat
        attributes.name = "Top Note"
        attributes.hapticFeedbackType = .success
        attributes.popBehavior = .animated(animation: .translation)
        attributes.entryBackground = .color(color: .black)
        attributes.roundCorners = .all(radius: 20)
        attributes.border = .none
        attributes.statusBar = .hidden
        
        attributes.positionConstraints.rotation.isEnabled = false
    
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 0.95)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
        
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)

        attributes.screenBackground = .color(color: UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.8))
        attributes.positionConstraints.rotation.isEnabled = false
        attributes.shadow = .active(with: .init(color: .black, opacity: 0.5, radius: 2))
        attributes.statusBar = .ignored
        attributes.displayDuration = .infinity

        let customView = UIView()
        
        customView.backgroundColor = UIColor(red:0.11, green:0.13, blue:0.16, alpha:1.0)
        customView.clipsToBounds = true
        customView.layer.cornerRadius = 20
        
        let mkrGreenImage = UIImage(named: "mkrGreen")
        let mkrGreenImageView = UIImageView(image: mkrGreenImage)
        mkrGreenImageView.frame = CGRect(x:0, y: 0, width: 32, height: 32)
        mkrGreenImageView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(mkrGreenImageView)
        
        mkrGreenImageView.topAnchor.constraint(equalTo: customView.topAnchor, constant: 15).isActive = true
        mkrGreenImageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 15).isActive = true
        
        let cdpItem = CDPs[indexPath.row]
        
//        let identifier:Int?
//        let ratio:Double?
//        let pip:Double? // Reference price feed
//        let art:Double? // Debt
//        let ink:Double? // Locked collateral (in SKR)
//        let liqPrice:Double?
    
        let identifierLabel = UILabel()
        identifierLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        identifierLabel.text = "Maker CDP #\(cdpItem.identifier!.description)"
        identifierLabel.textColor = .white
        identifierLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(identifierLabel)
        
        identifierLabel.leadingAnchor.constraint(equalTo: mkrGreenImageView.trailingAnchor, constant: 10).isActive = true
        identifierLabel.centerYAnchor.constraint(equalTo: mkrGreenImageView.centerYAnchor).isActive = true
        
        let collateralTitleLabel = UILabel()
        collateralTitleLabel.text = "COLLATERAL"
        collateralTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        collateralTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        collateralTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(collateralTitleLabel)
        
        collateralTitleLabel.leadingAnchor.constraint(equalTo: mkrGreenImageView.leadingAnchor).isActive = true
        collateralTitleLabel.topAnchor.constraint(equalTo: mkrGreenImageView.bottomAnchor, constant: 15).isActive = true
        
        let ethCircleImage = UIImage(named: "ethWhiteCircle")
        let ethCircleImageView = UIImageView(image: ethCircleImage)
        ethCircleImageView.frame = CGRect(x:0, y: 0, width: 20, height: 20)
        ethCircleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(ethCircleImageView)
        
        ethCircleImageView.topAnchor.constraint(equalTo:collateralTitleLabel.bottomAnchor, constant: 10).isActive = true
        ethCircleImageView.leadingAnchor.constraint(equalTo:mkrGreenImageView.leadingAnchor, constant: 0).isActive = true
        
        let etherTitleLabel = UILabel()
        etherTitleLabel.text = "Ether"
        etherTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        etherTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        etherTitleLabel.textColor = .white
        
        customView.addSubview(etherTitleLabel)
        
        etherTitleLabel.leadingAnchor.constraint(equalTo: ethCircleImageView.trailingAnchor, constant: 10).isActive = true
        etherTitleLabel.centerYAnchor.constraint(equalTo: ethCircleImageView.centerYAnchor).isActive = true
        
        let collateralBreakdownLabel = UILabel()
        collateralBreakdownLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        collateralBreakdownLabel.translatesAutoresizingMaskIntoConstraints = false
        collateralBreakdownLabel.textColor = .white
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        numberFormatter.maximumFractionDigits = 0
        
        if let ink = cdpItem.ink {
            if let pip = cdpItem.pip {
                let inkString:String? = numberFormatter.string(from: NSNumber(value:ink))
                let pipString:String? = numberFormatter.string(from: NSNumber(value:pip))
                
                collateralBreakdownLabel.text = "\(inkString!.description) ETH * \(pipString!.description) USD"
            }
        }
        
        customView.addSubview(collateralBreakdownLabel)
    
        collateralBreakdownLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -15).isActive = true
        collateralBreakdownLabel.topAnchor.constraint(equalTo: collateralTitleLabel.bottomAnchor, constant: 10).isActive = true
        
        let debtTitleLabel = UILabel()
        debtTitleLabel.text = "DEBT"
        debtTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        debtTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        debtTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(debtTitleLabel)
        
        debtTitleLabel.leadingAnchor.constraint(equalTo: mkrGreenImageView.leadingAnchor).isActive = true
        debtTitleLabel.topAnchor.constraint(equalTo: ethCircleImageView.bottomAnchor, constant: 15).isActive = true

        let daiCircleImage = UIImage(named: "daiCircle")
        let daiCircleImageView = UIImageView(image: daiCircleImage)
        daiCircleImageView.frame = CGRect(x:0, y: 0, width: 20, height: 20)
        daiCircleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(daiCircleImageView)
        
        daiCircleImageView.topAnchor.constraint(equalTo:debtTitleLabel.bottomAnchor, constant: 10).isActive = true
        daiCircleImageView.leadingAnchor.constraint(equalTo:mkrGreenImageView.leadingAnchor, constant: 0).isActive = true
        
        let daiTitleLabel = UILabel()
        daiTitleLabel.text = "Dai"
        daiTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        daiTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        daiTitleLabel.textColor = .white
        
        customView.addSubview(daiTitleLabel)
        
        daiTitleLabel.leadingAnchor.constraint(equalTo: daiCircleImageView.trailingAnchor, constant: 10).isActive = true
        daiTitleLabel.centerYAnchor.constraint(equalTo: daiCircleImageView.centerYAnchor).isActive = true
        
        let debtBreakdownLabel = UILabel()
        debtBreakdownLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        debtBreakdownLabel.translatesAutoresizingMaskIntoConstraints = false
        debtBreakdownLabel.textColor = .white
        
        if let art = cdpItem.art {
            let artString:String? = numberFormatter.string(from: NSNumber(value:art))
            debtBreakdownLabel.text = "\(artString!.description) DAI * 1.00 USD"
        }

        customView.addSubview(debtBreakdownLabel)

        debtBreakdownLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -10).isActive = true
        debtBreakdownLabel.centerYAnchor.constraint(equalTo: daiCircleImageView.centerYAnchor).isActive = true
        
        let positionTitleLabel = UILabel()
        positionTitleLabel.text = "POSITION"
        positionTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        positionTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        positionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(positionTitleLabel)
        
        positionTitleLabel.leadingAnchor.constraint(equalTo: mkrGreenImageView.leadingAnchor).isActive = true
        positionTitleLabel.topAnchor.constraint(equalTo: debtBreakdownLabel.bottomAnchor, constant: 15).isActive = true
        
        let riskTitleLabel = UILabel()
        riskTitleLabel.text = "RISK"
        riskTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        riskTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        riskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(riskTitleLabel)
        
        riskTitleLabel.leadingAnchor.constraint(equalTo: mkrGreenImageView.leadingAnchor).isActive = true
        riskTitleLabel.topAnchor.constraint(equalTo: positionTitleLabel.bottomAnchor, constant: 10).isActive = true
        
        let priceTitleLabel = UILabel()
        priceTitleLabel.text = "PRICE"
        priceTitleLabel.textAlignment = .center
        priceTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        priceTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        priceTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(priceTitleLabel)
        
        priceTitleLabel.centerXAnchor.constraint(equalTo: customView.centerXAnchor).isActive = true
        priceTitleLabel.centerYAnchor.constraint(equalTo: riskTitleLabel.centerYAnchor).isActive = true
        
        let ratioTitleLabel = UILabel()
        ratioTitleLabel.text = "RATIO"
        ratioTitleLabel.textAlignment = .right
        ratioTitleLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        ratioTitleLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        ratioTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(ratioTitleLabel)
        
        ratioTitleLabel.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -15).isActive = true
        ratioTitleLabel.centerYAnchor.constraint(equalTo: riskTitleLabel.centerYAnchor).isActive = true

        var riskColor:UIColor = .white
        var riskRange:String = "Unknown"
        
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
        
        let riskLabel = UILabel()
        riskLabel.text = riskRange
        riskLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        riskLabel.padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        riskLabel.textColor = UIColor(red: 0.176, green: 0.196, blue: 0.220, alpha: 1.000)
        riskLabel.backgroundColor =  riskColor
        riskLabel.layer.cornerRadius = 5
        riskLabel.clipsToBounds = true
        riskLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(riskLabel)
        
        riskLabel.leadingAnchor.constraint(equalTo: riskTitleLabel.leadingAnchor).isActive = true
        riskLabel.topAnchor.constraint(equalTo: riskTitleLabel.bottomAnchor, constant: 5).isActive = true
        
        let liqPriceLabel = UILabel()
        
        liqPriceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        liqPriceLabel.padding = UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
        liqPriceLabel.textColor = UIColor(red: 0.176, green: 0.196, blue: 0.220, alpha: 1.000)
        liqPriceLabel.backgroundColor =  riskColor
        liqPriceLabel.layer.cornerRadius = 5
        liqPriceLabel.clipsToBounds = true
        liqPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(liqPriceLabel)
        
        liqPriceLabel.centerXAnchor.constraint(equalTo: priceTitleLabel.centerXAnchor, constant: 0).isActive = true
        liqPriceLabel.topAnchor.constraint(equalTo: priceTitleLabel.bottomAnchor, constant: 5).isActive = true
        
        if let liqPrice = cdpItem.liqPrice {
            if let pip = cdpItem.pip {
                liqPriceLabel.text = "$\(String(format:"%.0f", pip)) / \(String(format:"%.0f", liqPrice))"
            }
        }

        let ratioLabel = UILabel()
    
        if let ratio = cdpItem.ratio {
            ratioLabel.text = " \(String(format:"%.0f", ratio))%"
        }

        ratioLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 14, weight: .medium)
        ratioLabel.padding = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 4)
        ratioLabel.textColor = UIColor(red: 0.176, green: 0.196, blue: 0.220, alpha: 1.000)
        ratioLabel.backgroundColor =  riskColor
        ratioLabel.layer.cornerRadius = 5
        ratioLabel.clipsToBounds = true
        ratioLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(ratioLabel)
        
        ratioLabel.trailingAnchor.constraint(equalTo: ratioTitleLabel.trailingAnchor, constant: 0).isActive = true
        ratioLabel.topAnchor.constraint(equalTo: ratioTitleLabel.bottomAnchor, constant: 5).isActive = true
        
        let riskBarImage = UIImage(named: "riskbar")
        let riskBarImageView = UIImageView(image: riskBarImage)
        riskBarImageView.frame = CGRect(x:0, y: 0, width: 345, height: 23)
        riskBarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(riskBarImageView)
        
        riskBarImageView.topAnchor.constraint(equalTo: riskLabel.bottomAnchor, constant: 20).isActive = true
        riskBarImageView.leadingAnchor.constraint(equalTo: customView.leadingAnchor, constant: 15).isActive = true
        riskBarImageView.trailingAnchor.constraint(equalTo: customView.trailingAnchor, constant: -15).isActive = true
        
        let riskDotImage = UIImage(named: "riskDot")
        let riskDotImageView = UIImageView(image: riskDotImage)
        riskDotImageView.frame = CGRect(x:0, y: 0, width: 345, height: 23)
        riskDotImageView.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(riskDotImageView)
        
        riskDotImageView.centerYAnchor.constraint(equalTo: riskBarImageView.centerYAnchor, constant: 0).isActive = true
        
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
        
        let rektLabel = UILabel()
        rektLabel.text = "150%"
        rektLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        rektLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        rektLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(rektLabel)
        
        rektLabel.leadingAnchor.constraint(equalTo: mkrGreenImageView.leadingAnchor).isActive = true
        rektLabel.topAnchor.constraint(equalTo: riskBarImageView.bottomAnchor, constant: 10).isActive = true
        
        let dangerLabel = UILabel()
        dangerLabel.text = "250%"
        dangerLabel.textAlignment = .center
        dangerLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        dangerLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        dangerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(dangerLabel)
        
        dangerLabel.centerXAnchor.constraint(equalTo: riskBarImageView.centerXAnchor).isActive = true
        dangerLabel.centerYAnchor.constraint(equalTo: rektLabel.centerYAnchor).isActive = true
        
        let saferLabel = UILabel()
        saferLabel.text = "350%"
        saferLabel.textAlignment = .right
        saferLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        saferLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.6)
        saferLabel.translatesAutoresizingMaskIntoConstraints = false
        
        customView.addSubview(saferLabel)
        
        saferLabel.trailingAnchor.constraint(equalTo: riskBarImageView.trailingAnchor).isActive = true
        saferLabel.centerYAnchor.constraint(equalTo: rektLabel.centerYAnchor).isActive = true

        let plainEnglishContainerView = UIView()
        
        //TODO Find a way to get the UILabel to stretch dynamically.
        plainEnglishContainerView.translatesAutoresizingMaskIntoConstraints = false

        customView.addSubview(plainEnglishContainerView)

        plainEnglishContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
        plainEnglishContainerView.leadingAnchor.constraint(equalTo: mkrGreenImageView.leadingAnchor).isActive = true
        plainEnglishContainerView.trailingAnchor.constraint(equalTo: saferLabel.trailingAnchor).isActive = true
        plainEnglishContainerView.topAnchor.constraint(equalTo: rektLabel.bottomAnchor, constant: 15).isActive = true
        plainEnglishContainerView.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -15).isActive = true
        
        let plainEnglishExplanationLabel = UILabel()
        var textForPlainEnglishExplanationLabel = ""
        plainEnglishExplanationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if let liqPrice = cdpItem.liqPrice {
            textForPlainEnglishExplanationLabel = "If Ether drops to $\(String(format:"%.0f", liqPrice)) your CDP will hit the ratio of 150% and be liquidated."
        }

        plainEnglishExplanationLabel.text = textForPlainEnglishExplanationLabel
        plainEnglishExplanationLabel.textAlignment = .center
        plainEnglishExplanationLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        plainEnglishExplanationLabel.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:0.5)
        
        plainEnglishExplanationLabel.lineBreakMode = .byWordWrapping
        plainEnglishExplanationLabel.numberOfLines = 0
        plainEnglishExplanationLabel.sizeToFit()

        customView.addSubview(plainEnglishExplanationLabel)
        
        plainEnglishExplanationLabel.leadingAnchor.constraint(equalTo: mkrGreenImageView.leadingAnchor).isActive = true
        plainEnglishExplanationLabel.trailingAnchor.constraint(equalTo: saferLabel.trailingAnchor).isActive = true
        plainEnglishExplanationLabel.topAnchor.constraint(equalTo: rektLabel.bottomAnchor, constant: 15).isActive = true
        plainEnglishExplanationLabel.bottomAnchor.constraint(equalTo: customView.bottomAnchor, constant: -15).isActive = true

        SwiftEntryKit.display(entry: customView, using: attributes)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cdpCell", for: indexPath) as! CDPTableViewCell
        cell.selectionStyle = .none
        cell.cdp = CDPs[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
