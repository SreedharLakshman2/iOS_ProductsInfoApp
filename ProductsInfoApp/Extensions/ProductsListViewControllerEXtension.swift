//
//  ProductsListViewControllerEXtension.swift
//  ProductsInfoApp
//
//  Created by Sreedhar L on 17/09/22.
//

import Foundation
import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredProductIfoCollection?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productCell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        if let productDetails = filteredProductIfoCollection?[indexPath.row] {
            productCell.categoryInfoLabel.text = "Category: \(productDetails.category ?? "")"
            productCell.titleLabel.text = "Title: \(productDetails.title ?? "")"
            DispatchQueue.main.async {
            productCell.productImageView.downloadedFrom(link: productDetails.image ?? "")
            }
            productCell.ratingInfoLabel.text = "\(productDetails.rating?.rate ?? 0)/5.0"
            // Converting Doller to rupees value
            let rateInRupees = ((productDetails.price ?? 0.0)*80.0)
            productCell.priceInfoLabel.text = "Rs: \(rateInRupees)"
        }
        return productCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        if let productDetails = filteredProductIfoCollection?[indexPath.row] {
        detailVC.selectedProductDetails = productDetails
        }
        present(detailVC, animated: true, completion: nil)
    }
    
    
}


// MARK: - ImageView
extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
        }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIView.ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
