class Member :Codable{
    
    var member_id : String?
    var member_pw : String?
    var member_name : String?
    var member_email : String?
    var loc_code : String?
    var member_address : String?
    var member_phone : String?
    var member_birth : String?
    var member_sex : String?
    var member_date : String?
    var member_image : String?
    var member_type : Int?
    var member_grade : String?
    
    
}

protocol MemberProtocol {
    func setMember(member: Member?)
}
