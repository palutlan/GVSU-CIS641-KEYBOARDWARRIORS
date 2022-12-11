# Overview:
This software requirement specification document outlines the requirements of Notes app for iOS platform. The app has been developed using Swift language and Native iOS APIs.


# Software Requirements
This section of the document describes the requirements of the application using Natural Language
Functional requirements section covers details of user requirements.
Non-functional requirements provide software quality attributes.

## Functional Requirements
### Notes List
| ID | Requirement |
| -------------| ---------- |
| FR1 | The user shall have the capability to create a new note. |
| FR2 | The user shall be able to edit an existing note. |
| FR3 | The user shall close the app and reopen it and shall find their notes intact. |
| FR4 | The user shall have the capability to delete the notes. |
| FR5 | The user shall be able to scan text in an image and add it to a note. |


### Authentication
| ID | Requirement |
| -------------| ---------- |
| FR6 | The user shall be able to open the app using facial recognition. |
| FR7 | The user shall be able to set a 4 or 6-digit numieric code to authenticate and access notes. |
| FR8 | The user shall be able to turn off facial recognition authentication. |
| FR9 | The user shall be able to turn off numeric passcode authentication. |
| FR10 | The user shall be able to use their iCloud account for authentication. |
| FR11 | The user shall be able to reset their passcode for authentication. |


### Image Scan
| ID | Requirement |
| -------------| ---------- |
| FR12 | The user shall be able to scan images and add add them to the note. |
| FR13 | The user shall be able to crop the size of the scanned pictures. |
| FR14 | The user shall be able to adjust the brightness of the scanned pictures. |
| FR15 | The user shall be able to adjust the contrast of the scanned pictures. |
| FR16 | The user shall be able to adjust the color saturation of the scanned pictures. |

### Note Export
| ID | Requirement |
| -------------| ---------- |
| FR17 | The user shall be able to export a created note to a PDF file. |
| FR18 | The user shall be able to share the contents of a Note in a text message. |
| FR19 | The user shall be able to share the contents of a Note in an E-Mail. |
| FR20 | The user shall be able to share the Note on social media. |


### Preferenes
| ID | Requirement |
| -------------| ---------- |
| FR21 | The user shall be able to turn on/off facial detection authentication using the preferences screen. |
| FR22 | The user shall be able to turn on/off passcode authentication using the preferences screen. |
| FR23 | The user shall be able to turn on/off the syncing of notes to iCloud. |
| FR24 | The user shall be able to reset the 4 or 6-digit passcode using the preferences screen. |
| FR25 | The user shall be able to turn on/off the syncing of notes to iCloud. |



## Non-Functional Requirements
### Security
| ID | Requirement |
| -------------| ---------- |
| NFR1 | The system shall lock the app from malicious users for a certain period after 5 unsuccessful login attempts. |
| NFR2 | The system shall allow the user to reset the passcode using their iCloud account.
| NFR3 | No user data shall be collected and stored on any server.
| NFR4 | The system shall encrypt the local database such that no malicious software shall be able to access the data.
| NFR5 | The code implementation shall take all necessary steps to reduce vulnerabilities to data theft.


### Usability
| ID | Requirement |
| -------------| ---------- |
| NFR6 | The application shall adhere to Apple's HCI guidelines for an optimal user experience |
| NFR7 | The application shall have a tutorial to provide an overview of features or guide to the users. |
| NFR8 | The user interface shall be minimal and clutter free. |
| NFR9 | The application shall implement accessiblity for people with physical impairments. |
| NFR10 | The application shall be accessible by people of any age group. | 
| NFR11 | The user shall be able to access the app on multiple devices logged into the same iCloud account. |


### Performance
| ID | Requirement |
| -------------| ---------- |
| NFR12 | The app shall take no more than 2 seconds to launch |
| NFR13 | The app shall require a 4-digit numeric passcode to access the user’s notes. |
| NFR14 | The user shall be able to access notes with several images without any lag or processing delay. |
| NFR 15 | The app shall scan documents at a high resolution to save in the notes. 


### Operational
| ID | Requirement |
| -------------| ---------- |
| NFR16 | The app shall be written in Swift programming language. |
| NFR17 | The user interface shall be developed using storyboards in Xcode. |
| NFR18 | The app shall be deployed to the iOS AppStore for distribution. |
| NFR19 | The app shall have no In-App purchases or microtransactions. |
| NFR20 | The created user notes shall be stored in local database like CoreData. |
| NFR21 | The application shall run on minimum iOS system version of 14.0

### Availability

| ID | Requirement |
| -------------| ---------- |
| NFR22 | The server for syncing notes accross multiple devices shall be highly available and scalable |
| NFR23 |  The app should occupy minimal storage and should be accessible across all kinds of iOS devices. |
| NFR24 | The app shall be available in different geographical regions on the Appstore. |
| NFR25 | The app shall be available for beta testing on TestFlight for users who opt-in |
