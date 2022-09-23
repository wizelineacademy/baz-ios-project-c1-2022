//
//  FiltersMovieModalViewController.swift
//  BAZProjectC1
//
//  Created by 961184 on 22/09/22.
//

import UIKit
import Foundation

class FiltersMovieModalViewController: UIViewController{

    @IBOutlet weak var btnCloseModal: UIButton!
    @IBOutlet weak var txtFilterCategory: UITextField!
    @IBOutlet weak var txtLanguage: UITextField!
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    private var strPrincipalAction: String?
    private var strSecundaryAction: String?
    private var bHideSecundaryButton: Bool = false
    private var delegateSelectedFilter: SelectedFilterProtocol?
    
    private let filterCategoryPicker = UIPickerView()
    private let filterLanguagePicker = UIPickerView()
    private let categoryPickerData: [CategoryMovieType] = [.trending, .nowPlaying, .popular, .topRated, .upcoming]
    private let languagePickerData: [ApiLanguageResponse] = [.es, .de, .en, .pt]
    
    private var selectedTextFiel: UITextField?
    private var selectedCategoryPicker: CategoryMovieType?
    private var selectedLanguagePicker: ApiLanguageResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnAgree.setTitle(strPrincipalAction, for: .normal)
        self.btnCancel.setTitle(strSecundaryAction, for: .normal)
        self.setupUIPickers()
        if bHideSecundaryButton{
            self.btnCancel.isHidden = bHideSecundaryButton
        }
        
    }
    
    private func setupUIPickers () {
        
        self.filterCategoryPicker.delegate = self
        self.filterLanguagePicker.delegate = self
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Aceptar", style: .plain, target: self, action: #selector(doneActionPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton,doneButton], animated: false)
        
        self.txtFilterCategory.inputAccessoryView = toolbar
        self.txtFilterCategory.inputView = filterCategoryPicker
        self.txtLanguage.inputAccessoryView = toolbar
        self.txtLanguage.inputView = filterLanguagePicker
        
        self.txtFilterCategory.delegate = self
        self.txtLanguage.delegate = self
        
        self.txtFilterCategory.text = self.selectedCategoryPicker?.typeName
        self.txtLanguage.text = self.selectedLanguagePicker?.fullName
        
        self.filterCategoryPicker.selectRow(categoryPickerData.firstIndex(where: {$0 == selectedCategoryPicker}) ?? 0, inComponent: 0, animated: true)
        self.filterLanguagePicker.selectRow(languagePickerData.firstIndex(where: {$0 == selectedLanguagePicker}) ?? 0, inComponent: 0, animated: true)
    }
    
    @objc private func doneActionPicker() {
        self.view.endEditing(true)
    }

    static func requiredSetupUI(delegateSelectedFilter:SelectedFilterProtocol, bHideSecundaryButton:Bool? = false, initCategorySelected: CategoryMovieType? = .trending, initLanguageSelected: ApiLanguageResponse? = .es, strPrincipalActionTitle:String? = "Aceptar", strSecundaryActionTitle:String? = "Cancelar") -> FiltersMovieModalViewController? {
        
        let viewController = FiltersMovieModalViewController(nibName: "FiltersMovieModalViewController", bundle: Bundle(for: FiltersMovieModalViewController.self))
        
        viewController.delegateSelectedFilter = delegateSelectedFilter
        viewController.bHideSecundaryButton = bHideSecundaryButton ?? false
        viewController.selectedCategoryPicker = initCategorySelected
        viewController.selectedLanguagePicker = initLanguageSelected
        viewController.strPrincipalAction = strPrincipalActionTitle
        viewController.strSecundaryAction = strSecundaryActionTitle
        
        viewController.modalPresentationStyle = .overCurrentContext
        
        return viewController
    }
    
    private func dismissFiltersMovieModalViewController(){
        self.dismiss(animated: true, completion: nil)
        delegateSelectedFilter?.closeFiltersMovieModal()
    }
    
    @IBAction func closeModalAction(_ sender: Any) {
        dismissFiltersMovieModalViewController()
    }
    @IBAction func agreeModalAction(_ sender: Any) {
        dismissFiltersMovieModalViewController()
        delegateSelectedFilter?.addFilterToMovies(category: selectedCategoryPicker ?? .trending, language: selectedLanguagePicker ?? .es)
    }
    @IBAction func cancelModalAction(_ sender: Any) {
        dismissFiltersMovieModalViewController()
    }
    
}

extension FiltersMovieModalViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.filterCategoryPicker{
            return self.categoryPickerData.count
        }else{
            return self.languagePickerData.count
        }
    }

    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == self.filterCategoryPicker{
            return self.categoryPickerData[row].typeName
        }else{
            return self.languagePickerData[row].fullName
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == self.filterCategoryPicker{
            self.selectedTextFiel?.text = self.categoryPickerData[row].typeName
            self.selectedCategoryPicker = self.categoryPickerData[row]
        }else{
            self.selectedTextFiel?.text = self.languagePickerData[row].fullName
            self.selectedLanguagePicker = self.languagePickerData[row]
        }
    }
}

extension FiltersMovieModalViewController : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextFiel = textField
        return true
    }
}
