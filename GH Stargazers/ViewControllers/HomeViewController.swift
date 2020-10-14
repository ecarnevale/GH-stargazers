//
//  HomeViewController.swift
//  GH Stargazers
//
//  Created by Emanuel Carnevale on 14/10/2020.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var loadStargazersButton: UIButton!
    @IBOutlet var repositoryNameTextField: UITextField!
    @IBOutlet var ownerNameTextField: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    
    private var keyboardWillShowObserver: Any?
    private var keyboardWillHideObserver: Any?
    private var isKeyboardOpen = false
    private let loadStargazersSegueIdentifier = "stargazersList"
    
    private var canLoadStargazers: Bool {
        return ownerNameTextField.hasText && repositoryNameTextField.hasText
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "GH Stargazers"
        
        keyboardWillShowObserver = NotificationCenter.default.addObserver(
            self,
            selector: #selector(HomeViewController.keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        keyboardWillHideObserver = NotificationCenter.default.addObserver(
            self,
            selector: #selector(HomeViewController.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        setupDismissKeyboardGestureRecognizer()
        
        ownerNameTextField.delegate = self
        repositoryNameTextField.delegate = self
        textFieldValueChanged(self)
    }
    
    @IBAction func textFieldValueChanged(_ sender: Any) {
        loadStargazersButton.isEnabled = canLoadStargazers
    }
    
    func loadStargazers() {
        performSegue(withIdentifier: loadStargazersSegueIdentifier, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == loadStargazersSegueIdentifier {
            if let vc = segue.destination as? StargazersViewController, let ownerName = ownerNameTextField.text, let repoName = repositoryNameTextField.text {
                vc.repository = "\(ownerName)/\(repoName)"
            }
        }
    }
}

extension HomeViewController {
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if !self.isKeyboardOpen {
                self.isKeyboardOpen = true
                
                let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardRect.height, right: 0)
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
                
                scrollView.scrollRectToVisible(loadStargazersButton.frame, animated: true)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        if let _ = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.isKeyboardOpen {
                self.isKeyboardOpen = false
                
                let contentInsets = UIEdgeInsets.zero
                scrollView.contentInset = contentInsets
                scrollView.scrollIndicatorInsets = contentInsets
            }
        }
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == ownerNameTextField {
            repositoryNameTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            if canLoadStargazers {
                loadStargazers()
            }
        }
        return false
    }
}

extension HomeViewController {
    func setupDismissKeyboardGestureRecognizer() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}
