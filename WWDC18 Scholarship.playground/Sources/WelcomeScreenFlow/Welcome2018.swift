import UIKit

public class Welcome2018: UIView {

    let welcomeString = "WELCOME"
    let toString = "TO MY"
    let playgroundString = "PLAYGROUND"

    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = welcomeString
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textAlignment = .center
        return label
    }()

    lazy var toLabel: UILabel = {
        let label = UILabel()
        label.text = toString
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textAlignment = .center
        return label
    }()

    lazy var playgroundLabel: UILabel = {
        let label = UILabel()
        label.text = playgroundString
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()

    public func trigger() {
        triggerWelcome()
    }

    private func triggerWelcome() {

        welcomeLabel.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: bounds.width, height: 30))
        addSubview(welcomeLabel)

        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.welcomeLabel.frame.origin = CGPoint(x: 0, y: self.frame.height/2 - 50)
        }, completion: nil)

        toLabel.frame = self.bounds
        addSubview(toLabel)
        toLabel.transform = CGAffineTransform(scaleX: 0, y: 0)

        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.toLabel.transform = CGAffineTransform(scaleX: 1, y: 1)
        }, completion: nil)

        playgroundLabel.frame = CGRect(x: 0, y: frame.height/2 + 50, width: bounds.width, height: 30)
        addSubview(playgroundLabel)
        playgroundLabel.transform = CGAffineTransform(translationX: 0, y: -400)

        UIView.animate(withDuration: 1, delay: 1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.playgroundLabel.transform = CGAffineTransform.identity
        }, completion: nil)

    }
}
