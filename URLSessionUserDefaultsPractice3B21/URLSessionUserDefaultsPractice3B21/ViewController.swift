//
//  ViewController.swift
//  URLSessionUserDefaultsPractice3B21
//
//  Created by COTEMIG on 18/09/24.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textFieldZipCode: UITextField!
    @IBOutlet weak var labelPublicPlace: UILabel!
    @IBOutlet weak var labelLocality: UILabel!
    @IBOutlet weak var lalbelNeighborhood: UILabel!
    @IBOutlet weak var labelDDD: UILabel!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonSaveAddress: UIButton!
    
    let service = Service()
    let userDefaults = UserDefaults.standard
    let addressKey: String = "ADDRESSKEY"
    var addressList: [ZipCodeModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    private func configureUI(){
        textFieldZipCode.keyboardType = .numberPad //abrir o teclado quando a pessoa digitar o cep
        textFieldZipCode.clearButtonMode = .whileEditing //aparecer o botao de limpar cep enquanto o usuario estiver digitando
        textFieldZipCode.layer.cornerRadius = 6 //borda arredondada
        textFieldZipCode.layer.borderWidth = 1 //expessura da borda
        textFieldZipCode.layer.borderColor = UIColor.black.cgColor //borda preta
        
        buttonSearch.layer.cornerRadius = 6
        buttonSearch.layer.borderWidth = 1
        buttonSearch.layer.borderColor = UIColor.black.cgColor
    }
    
    func createAlertView(with message: String) { //metodo para caixa de alerta
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func clearFields(){
        labelPublicPlace.text = "Logradouro: "
        labelLocality.text = "Localidade/UF: "
        lalbelNeighborhood.text = "Bairro: "
        labelDDD.text = "DDD: "
    }
    
    private func setAddress(){
        do {
            let addressData = try JSONEncoder().encode(addressList)
            userDefaults.set(addressData, forKey: addressKey)
            createAlertView(with: "Endereço salvo com sucesso!")
        } catch{
            createAlertView(with: "Deu ruim!")
        }
    }
    
    @IBAction func searchZipCode(_ sender: Any) {
        guard let zipCode = textFieldZipCode.text else { return }
        
        service.searchZipCode(zipCode) { result in
            DispatchQueue.main.sync {
                switch result {
                case let .failure(error):
                    self.createAlertView(with: "CEP não encontrado!")
                    self.clearFields()
                    print(error.localizedDescription)
                case let .success(zipCode):
                    self.labelPublicPlace.text = "Logradouro: \(zipCode.publicPlace)"
                    self.labelLocality.text = "Localidade/UF: \(zipCode.locality)"
                    self.lalbelNeighborhood.text = "Bairro: \(zipCode.neighborhood)"
                    self.labelDDD.text = "DDD: \(zipCode.ddd)"
                    //self.textFieldZipCode.keyboardAppearance.resignFirstResponder()
                    self.addressList.append(zipCode)
                }
            }
            
        }
        
    }
    
    @IBAction func saveAddress(_ sender: Any) {
        setAddress()
        clearFields()
    }
}

