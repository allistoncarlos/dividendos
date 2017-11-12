# Dividendos

App to show which company is paying dividends in brazilian stock exchange (BM&F BOVESPA). It has the capability to receive push notifications through In-App Purchases, as well the subscriptions that allows the user to favorite companies and receive some news about the companies. It's not in the App Store anymore.

# Dependencies

- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [Google Analytics](https://cocoapods.org/pods/GoogleAnalytics)

Install the dependencies using CocoaPods

```sh
$ pod install
```

# Under the hood
The app is written in Swift 3 and consumes data from an API written in ASP.Net WebAPI that I created and hosted in Microsoft Azure. For Push Notifications, I've also created an service called Pusharp to manage them. You can run the app, but you can't have access to In-App Purchases (as it isn't in the App Store anymore), neither to Pusharp or Google Analytics.
For more details, please see the Screenshots folder. (Portuguese UI)