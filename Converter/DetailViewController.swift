//
//  DetailViewController.swift
//  Converter
//
//  Created by Alex on 14.09.2018.
//  Copyright © 2018 Alex. All rights reserved.
//

import Foundation
import UIKit


class CurrencyDetailPresenter {
    let date: String
    
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
        self.view.addSubview(descriptionLabel)
        setupConstraints()
        self.title = presenter.date
        
        let tapRecognizer = UITapGestureRecognizer(target: self,
                                                   action: #selector(self.onTap))
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func onTap() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        descriptionLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    let descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 40)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    func getInternet() {
        Alamofire.request("http://www.cbr.ru/scripts/XML_daily.asp", parameters: ["date_req": choisenDate])
            .responseString(completionHandler: { (response) in
                
                
                if let data = response.data {
                    
                    let xml = SWXMLHash.parse(data)
                    
                    do {
                        self.dollarCourseLabel.text = try xml["ValCurs"]["Valute"].withAttribute("ID", "R01235")["Value"].element?.text
                        self.euroCourseLabel.text = try xml["ValCurs"]["Valute"].withAttribute("ID", "R01239")["Value"].element?.text
                    } catch {
                        let alert = UIAlertController(title: "Ошибка", message: "Не удалось получить курс валют на эту дату", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Окей", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    
                    
                }})
    }
    
    
}
