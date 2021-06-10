//
//  LoginViewController.swift
//  RetoCP
//
//  Created by Kevin Guanilo on 6/9/21.
//

import UIKit
import GoogleSignIn
import Google


class LoginViewController: UIViewController,GIDSignInUIDelegate {
    
    @IBOutlet weak var googleSignInButton: GIDSignInButton!
    @IBOutlet weak var welcomeView: UIView!
    @IBOutlet weak var userProfileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNotification()
        welcomeView.isHidden = true
        googleConfigurationsAndStyles()
    }
    
    func googleConfigurationsAndStyles() {
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.login")
        GIDSignIn.sharedInstance().scopes.append("https://www.googleapis.com/auth/plus.me")
        
        googleSignInButton.style = GIDSignInButtonStyle.wide
        googleSignInButton.layer.borderColor = UIColor.blue.cgColor
        googleSignInButton.layer.borderWidth = 1.0
        googleSignInButton.layer.cornerRadius = 5.0
    }
    
    func registerNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updteToWelcomeView), name: .showWelcomeView, object: nil)
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        //myActivityIndicator.stopAnimating()
    }
    
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func updteToWelcomeView() {
        DispatchQueue.main.async {
            self.welcomeView.isHidden = false
            self.loadInformation()
        }
    }
    
    func loadInformation() {
        if let nameStr = defaults.value(forKey: "gfullName") as? String {
            userName.text = nameStr
        }
                
        if let imageUrl = defaults.url(forKey: "user_photo") {
        
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    self.userProfileImg.image = UIImage(data: data!)
                }
            }
        }
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        DispatchQueue.main.async {
            GIDSignIn.sharedInstance().signOut()
            self.welcomeView.isHidden = true
        }
    }
    
}

extension Notification.Name {
    static let showWelcomeView = Notification.Name("showWelcomeView")
}
