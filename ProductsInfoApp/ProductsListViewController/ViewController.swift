//
//  ViewController.swift
//  ProductsInfoApp
//
//  Created by Sreedhar L on 17/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties declaration
    var productIfoCollection: [ProductInfo]? = []
    var filteredProductIfoCollection: [ProductInfo]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        
        getListOfProductsInfo{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.productIfoCollection = data
                    if let productDetails = self?.productIfoCollection {
                    self?.filteredProductIfoCollection = productDetails
                    }
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
    // MARK: - Class level methods
    func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
    func getListOfProductsInfo(onCompletion: @escaping (Result<[ProductInfo],CustomError>) -> ()) {
        
        var request = URLRequest(url: URL(string: "https://fakestoreapi.com/products")!)
        request.httpMethod = "GET"
         let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                onCompletion(.failure(.ResponseError))
            }
            guard let data = data else {
                print(String(describing: error))
                return onCompletion(.failure(.NoData))
            }
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([ProductInfo].self, from: data)
                onCompletion(.success(decodedData))
                print(String(data: data, encoding: .utf8)!)
            }
            catch  {
                onCompletion(.failure(.ParsingError))
            }
        }
        task.resume()
    }
}
