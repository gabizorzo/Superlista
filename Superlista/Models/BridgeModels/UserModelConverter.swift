import Foundation
import SwiftUI
import CloudKit

//MARK: - UserModelConverter Class

/**
 UserModelConverter is a Bridge class converting our Cloud record/class of User arquitecture to our local/UserDefaults class arquitecture.
 
 According to its formal definition, a Bridge is something that meakes its easier to change from one situation to another. In this case, instead of refactoring the whole backend everytime we make a new implementation of a service, a Bridge class connects both arquitectures by parsing each to each. This way is possible to manipulate both strcutures without backend refactoring.
 */
class UserModelConverter {
    
    //MARK: UserModelConverter Functions: ☁️ to Local
    
    /**
    This method converts our cloud CKUserModel structure to a local UserModel structure
     
     - Parameters:
        - user: the cloud user to be converted - CKUserModel
     - Returns: the local version of the given cloud user - UserModel
     */
    func convertCloudUserCollabToLocal(withUser user: CKUserModel) -> UserModel {
        let id: String
        let name: String
        let customProducts: [ProductModel] = []
        let myLists: [ListModel] = []
        let sharedWithMe: [ListModel] = []
                
        id = user.id.recordName
        name = user.name ?? "arrumar esse inferno krl merda cu"
        
        let localUser: UserModel = UserModel(id: id, name: name, customProducts: customProducts, myLists: myLists, sharedWithMe: sharedWithMe)
        
        return localUser
    }
    
    /**
    This method converts our cloud CKUserModel structure to a local UserModel structure
     
     - Parameters:
        - user: the cloud user to be converted - CKUserModel
     - Returns: the local version of the given cloud user - UserModel
     */
    #warning("reavaliar funcao. Ela esta chamando outras recursivamente e portanto nunca sai daqui")
    func convertCloudUserToLocal(withUser user: CKUserModel) -> UserModel {
        let id: String
        let name: String
        let customProducts: [ProductModel]
        var myLists: [ListModel] = []
        var sharedWithMe: [ListModel] = []
                
        id = user.id.recordName
        name = user.name!
        customProducts = ProductModelConverter().convertStringToProducts(withString: user.customProductsString ?? [])
        
        for list in user.myLists! {
            myLists.append(ListModelConverter().convertCloudListToLocal(withList: list))
        }
        
        for list in user.sharedWithMe! {
            sharedWithMe.append(ListModelConverter().convertCloudListToLocal(withList: list))
        }
        
        let localUser: UserModel = UserModel(id: id, name: name, customProducts: customProducts, myLists: myLists, sharedWithMe: sharedWithMe)
        
        return localUser
    }
    
    func convertCloudOwnerToLocal(withUser user: CKUserModel) -> UserModel {
        let localUser = UserModel(id: user.id.recordName, name: user.name, customProducts: [], myLists: [], sharedWithMe: [])
        return localUser
    }
    
    
    /**
    This method converts our cloud CKUserModel structure to a CKRecord.reference
     
     - Parameters:
        - user: the user to be converted - CKUserModel
     - Returns: the CKRecord.Reference version of the given CKUserModel
     */
    func convertCloudUserToReference(withUser user: CKUserModel) -> CKRecord.Reference {
            return CKRecord.Reference(recordID: user.id, action: .none)
    }
    
    //MARK: UserModelConverter Functions: Local to ☁️
    
    /**
    This method converts our current local ItemModel structure to our cloud CKItemModel structure
     
     - Parameters:
        - items: the local list of items to be converted
     - Returns: the CKItemModel version of the given ItemModel list
     */
    func convertLocalUserToCloud(withUser user: UserModel) -> CKUserModel {
        let id: CKRecord.ID
        let name: String
        let customProductsString: [String]
        
        var myLists: [CKListModel] = []
        var sharedWithMe: [CKListModel] = []
        
        id = CKRecord.ID(recordName: user.id)
        name = user.name!
        customProductsString = ProductModelConverter().convertLocalProductsToString(withProducts: user.customProducts ?? [])
        
        for list in user.myLists! {
            myLists.append(ListModelConverter().convertLocalListToCloud(withList: list))
        }
        
        for list in user.sharedWithMe! {
            sharedWithMe.append(ListModelConverter().convertLocalListToCloud(withList: list))
        }
        
        let cloudUser: CKUserModel = CKUserModel(id: id, name: name, customProductsString: customProductsString, myLists: myLists, sharedWithMe: sharedWithMe)
        
        return cloudUser
    }
}
