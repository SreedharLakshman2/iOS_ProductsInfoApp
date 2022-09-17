//
//  ProductDetailsViewController.swift
//  ProductsInfoApp
//
//  Created by Sreedhar L on 17/09/22.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleInfoLabel: UILabel!
    @IBOutlet weak var categoryInfoLabel: UILabel!
    @IBOutlet weak var ratingInfoLabel: UILabel!
    @IBOutlet weak var descriptionInfoLabel: UILabel!
    @IBOutlet weak var rateInfoLabel: UILabel!
    
    //MARK: - Properties declaration
    var selectedProductDetails: ProductInfo?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        showProductDetails()
    }
    
    func showProductDetails() {
        productImageView.downloadedFrom(link: selectedProductDetails?.image ?? "")
        titleInfoLabel.text = "Title:  \(selectedProductDetails?.title ?? "")"
        categoryInfoLabel.text = "Category: \(selectedProductDetails?.category ?? "")"
        descriptionInfoLabel.text = "Description:  \(selectedProductDetails?.description ?? "")"
        ratingInfoLabel.text = "Rating: \(selectedProductDetails?.rating?.rate ?? 0.0)/5.0"
        rateInfoLabel.text = "Rs: \((selectedProductDetails?.price ?? 0.0)*80.0)"
    }
    //MARK: - Button Actions
    @IBAction func backButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
