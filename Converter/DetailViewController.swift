//
//  DetailViewController.swift
//  Converter
//
//  Created by Alex on 14.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SWXMLHash


class CurrencyDetailPresenter {
    var date: String
    var courseEuro: String!
    var courseDollar: String!
    
    var description: String {
        guard let euro = courseEuro, let dollar = courseDollar else { return ""}
            return "€ - \(euro)\n$ - \(dollar)"
        
    }
    let backgroundColor: UIColor = .black
    
    init(with date: String) {
        self.date = date
    }
}

class DetailViewController: UIViewController {
    let presenter: CurrencyDetailPresenter!
    init(with presenter: CurrencyDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCourse()
        self.view.addSubview(courseLabel)
        self.view.addSubview(dateLabel)
        self.view.backgroundColor = presenter.backgroundColor
        setupConstraints()
        dateLabel.text = presenter.date
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(self.onTap))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        courseLabel.translatesAutoresizingMaskIntoConstraints = false
        courseLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        courseLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
     
        view.addConstraint(NSLayoutConstraint(item: dateLabel, attribute: NSLayoutAttribute.bottomMargin, relatedBy: NSLayoutRelation.equal, toItem: self.topLayoutGuide, attribute: NSLayoutAttribute.bottomMargin, multiplier: 1, constant: 150))
    }
    
    let courseLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 35)
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .orange
        label.numberOfLines = 1
        return label
    }()
    
    func getCourse() {
        Alamofire.request("http://www.cbr.ru/scripts/XML_daily.asp", parameters: ["date_req": presenter.date])
            .responseString(completionHandler: { (response) in
                if let data = response.data {

                    let xml = SWXMLHash.parse(data)
                    do {
                        self.presenter.courseDollar = try xml["ValCurs"]["Valute"].withAttribute("ID", "R01235")["Value"].element?.text
                        self.presenter.courseEuro = try xml["ValCurs"]["Valute"].withAttribute("ID", "R01239")["Value"].element?.text
                        self.courseLabel.text = self.presenter.description
                    } catch {
                        let alert = UIAlertController(title: "Ошибка", message: "Не удалось получить курс валют на эту дату", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Окей", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }})
    }
   
    
}
