# Technical assessment test
We would like you to build a simple application that consists of one screen only. The main functionality of the app is to fetch orders from our test API, save them to persistent storage on the device and display them to the user. The tricky part is that you will receive a list with more than 10,000 items, ought to this you should carefully organise the local storage and multithreading processes so that UI will not be affected while objects will be saving. Also, it is very important to follow all designs guidelines while making the interface of the app.

## Requirements:
1. You must use CoreData as persistent storage. It is prohibited to use any external libraries to work with the local storage.
2. You can use any tooling (including external open-source libraries) that you prefer for managing architecture, networking, animations and etc.
3. While the data will be downloading and saving, UI must not be freeze, but stay responsive and smooth.
4. All design guidelines must be appropriately met.

## Resources:
1. The link to fetch the test data is
GET https://assessments.stage.copper.co/ios/orders
2. Design guidelines can be found here:
https://www.figma.com/file/KooWcNZDz90ZhR2dAsc0se/Test
(you should have a Figma account to be able to export files)

<img width="240" alt="Screenshot 2023-01-27 at 17 15 06" src="https://user-images.githubusercontent.com/22453570/215136321-548d5d5c-0023-4055-8b5f-edfb91d5c608.png">
<img width="579" alt="Screenshot 2023-01-27 at 17 15 21" src="https://user-images.githubusercontent.com/22453570/215136378-49f76925-d8db-4ae7-9234-761e99cd1119.png">
