//
//  Model.swift
//  AttendanceSystem
//
//  Created by Mohsin on 02/01/2015.
//  Copyright (c) 2015 PanaCloud. All rights reserved.
//

import Foundation


let ref = Firebase(url: "https://sweltering-inferno-1689.firebaseio.com/")


struct Model {
    
    static func addUser(#username: String, email: String, fname: String, lname: String, teams: [String : Bool]){
        
        let usersRef = ref.childByAppendingPath("users")
        
        let insertedData = [username : [
            "firstName" : fname,
            "lastName" : lname,
            "email" : email,
            "teams" : teams
        ]]
        
        usersRef.updateChildValues(insertedData)
        
        
    }
    
    static func addUser(user: WowUser){
        
        let usersRef = ref.childByAppendingPath("users")
        
        if user.teams != nil {
            let insertedData = [user.userName : [
                "email" : user.email,
                "firstName" : user.firstName,
                "lastName" : user.lastName,
                "teams" : user.teams
            ]]
            
            usersRef.updateChildValues(insertedData)
        }
        else{
            let insertedData = [user.userName : [
                "email" : user.email,
                "firstName" : user.firstName,
                "lastName" : user.lastName,
            ]]
            
            usersRef.updateChildValues(insertedData)
        }
        
        
    }
    
    
    static func addTeam(#ref: Firebase, name: String, admins: [String : Bool], members: [String : Bool], subTeams : [String : AnyObject]!){
        
        // let rootTeamRef = ref.childByAppendingPath("teams")
        var teamRef: Firebase = ref
        
        // if parent is null means this is the root team (orginization) so add at the teams node
        //        if ancestorRef == nil {
        //            teamRef = rootTeamRef
        if subTeams == nil {
            let insertedData = [name : [
                "admins" : admins,
                "members" : members,
            ]]
            teamRef.updateChildValues(insertedData)
        }
        else {
            let insertedData = [name : [
                "admins" : admins,
                "members" : members,
                "subTeams" : subTeams
            ]]
            teamRef.updateChildValues(insertedData)
        }
        //        }
        
        // if parent is not null means this is the sub team of any team and add this at the subteams array of parant team
        //        else{
        //            teamRef = rootTeamRef.childByAppendingPath("\(ancestorRef)/subTeams")
        //
        //            if subTeams == nil {
        //                let insertedData = [name : [
        //                    "admins" : admins,
        //                    "members" : members,
        //                ]]
        //                teamRef.updateChildValues(insertedData)
        //            }
        //            else {
        //                let insertedData = [name : [
        //                    "admins" : admins,
        //                    "members" : members,
        //                    "subTeams" : subTeams
        //                ]]
        //                teamRef.updateChildValues(insertedData)
        //            }
        //        }
        
    }
    
    
    static func addTeam(team : WowTeam){
        
        if team.subTeams == nil {
            let insertedData = [team.name : [
                "admins" : team.admins,
                "members" : team.members,
            ]]
            team.ref.updateChildValues(insertedData)
        }
            
        else {
            let insertedData = [team.name : [
                "admins" : team.admins,
                "members" : team.members,
            ]]
            team.ref.updateChildValues(insertedData)
            
            for x in team.subTeams{
                self.addTeam(x)
            }
        }
        
    }
    
    
    static func getUser(userName: String) {
        var email: String!
        var firstName: String!
        var lastName: String!
        var teams: [String : Bool]!
        
        
        let refUsers = ref.childByAppendingPath("users")
        
        
        refUsers.queryOrderedByKey().queryEqualToValue(userName).observeSingleEventOfType(.ChildAdded, withBlock: { snapshot in
            
            if snapshot != NSNull() {
                if let fName = snapshot.value["firstName"] as? String {
                    firstName = fName
                }
                if let lName = snapshot.value["lastName"] as? String {
                    lastName = lName
                }
                if let tempemail = snapshot.value["email"] as? String {
                    email = tempemail
                }
                if let tempteams = snapshot.value["teams"] as? [String : Bool] {
                    teams = tempteams
                }
                println(WowUser(userName: userName, email: email, firstName: firstName, lastName: lastName, teams: teams))
                
            }
            
        })
        
        
    }
    
    static func mapToWowTeams (subTeams : [String : AnyObject]!, parent : Firebase ) -> [WowTeam]!{
        var teams = [WowTeam]()
        
        
        if subTeams != nil {
            
            for team in subTeams {
                //            let tempTeam = WowTeam(ref: parent.childByAppendingPath("/subTeams/\(team.0)"), name: team.0, admins: team.1["admins"] as [String : Bool], members:team.1["members"] as [String : Bool], SubTeams: mapToWowTeams(team.1["subTeams"] as [String : AnyObject], parent: parent.childByAppendingPath("/subTeams/\(team.0)")))
                
                let tempAdmins = team.1["admins"] as [String : Bool]
                let tempMembers = team.1["members"] as [String : Bool]
                var tempSubTeams : [WowTeam]!
                if let tempTeams = mapToWowTeams(team.1["subTeams"] as? [String : AnyObject], parent: parent.childByAppendingPath("/subTeams/\(team.0)")) {
                    tempSubTeams = tempTeams
                }
                
                let tempTeam = WowTeam(ref: parent.childByAppendingPath("/subTeams/\(team.0)"), name: team.0, admins: tempAdmins, members: tempMembers, SubTeams: tempSubTeams)
                teams.append(tempTeam)
                //
                //                println( parent.childByAppendingPath("/subTeams/\(team.0)") )
                //                println(team.0)
                //                println( tempAdmins )
                //                println( tempMembers )
                //
                
                // mapToWowTeams(team.1["subTeams"] as [String : AnyObject], parent: parent.childByAppendingPath("/subTeams/\(team.0)"))
                //          teams.append(tempTeam)
            }
            
            
            
            return teams
            
        }
        else{
            return nil
        }
        
    }
    
}


class WowUser {
    var userName: String
    var email: String
    var firstName: String
    var lastName: String
    var teams: [String : Bool]!
    
    init(userName: String, email: String, firstName: String, lastName: String, teams: [String : Bool]!){
        self.userName = userName
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.teams = teams
    }
}

class WowTeam {
    var ref: Firebase
    var name: String
    var admins: [String: Bool]
    var members: [String: Bool]
    var subTeams: [WowTeam]!
    
    init(ref: Firebase, name: String, admins: [String: Bool], members: [String: Bool], SubTeams: [WowTeam]?) {
        self.ref = ref
        self.name = name
        self.admins = admins
        self.members = members
        self.subTeams = SubTeams
    }
    
    init(ref: Firebase){
        self.ref = ref
        self.name = String()
        self.admins = [String: Bool]()
        self.members = [String: Bool]()
        self.subTeams = [WowTeam]()
    }
    
}
