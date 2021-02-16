//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation

typealias SampleResponse1Dto = FRPSampleAPI.ResponseDto.EmployeeServiceAvailability

extension FRPSampleAPI.ResponseDto {
    struct EmployeeServiceAvailability: Codable {
        let status: String
        let data: [Employee]
    }
    
    struct Employee: Codable {
        let id, employeeName, employeeSalary, employeeAge: String
        let profileImage: String

        enum CodingKeys: String, CodingKey {
            case id
            case employeeName = "employee_name"
            case employeeSalary = "employee_salary"
            case employeeAge = "employee_age"
            case profileImage = "profile_image"
        }
    }
}
