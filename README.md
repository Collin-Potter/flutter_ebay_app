# flutter_ebay_app

Flutter application simulating eBay&#x27;s browsing experience

## Requirements being tested

- Proper search functionlity
- Infinite scrolling listview (until out of items resulting in query)
- Item detail page is displayed upon clicking individual list items which includes extra information of item price.

### Disclaimer: Although proper token refresh capabilities are necessary to have working search functionlity, application was created without token refreshing capabilities in order to meet functional requirements. If interested in testing application, a user must generate up-to-date OAuth token using their eBay Developer's account and enter it into variable named 'myToken' in main.dart before running application. Also, due to a page display limit of 200 for a search request, listview will only reach 200 items at maximum rather than infinite.

### Please note: due to the simplicity of this project, I did not ensure that all environment variables are set correctly to run perfectly in Gradle from the command line
