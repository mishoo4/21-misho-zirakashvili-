//
//  detailsViewController.swift
//  21(misho zirakashvili)
//
//  Created by misho zirakashvili on 11.08.22.
//

import UIKit

class DetailsViewController: UIViewController {
    var data: Country? {
        didSet {
            
            if let url = URL(string: data!.flagURL.png) {
                ImageView.load(url: url)
            }
            regionalBlockLabel.text = "\(data?.regionalBlocs?.first?.acronym ?? "")  -  \(data?.regionalBlocs?.first?.name ?? "")"
            capitalLabel.text = "Capital: \(data?.capital ?? "")"
        }
    }
    
    private let ImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray5
        
        return imageView
    }()
  
    private var regionalBlockLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 2
        
        return label
    }()
    
    private var capitalLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    private var descriptionVerticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 7
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUIElements()
        
    }
    
    private func confStackView () {
        view.addSubview(descriptionVerticalStackView)
        descriptionVerticalStackView.addArrangedSubview(regionalBlockLabel)
        descriptionVerticalStackView.addArrangedSubview(capitalLabel)
    }
    
    private func configureUIElements() {
        confStackView()
        view.addSubview(ImageView)
        
        NSLayoutConstraint.activate([
            ImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            ImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            ImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            ImageView.heightAnchor.constraint(equalToConstant: 250),
            
            descriptionVerticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 130),
            descriptionVerticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -130),
            descriptionVerticalStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300),
            descriptionVerticalStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
