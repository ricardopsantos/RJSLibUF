//
//  Created by Ricardo P Santos on 2020.
//  2020 © 2019 Ricardo P Santos. All rights reserved.
//

import Foundation
import Combine

extension FRPSampleAPI {
    public struct ResponseDto {
        private init() { }
    }
}

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
    
    // MARK: - AvailabilityElement
    struct PortugueseZipCode: Codable {
        let codConcelho, codLocalidade, nomeLocalidade, codArteria: String?
        let codDistrito, tipoArteria: String?
        let prep1: String?
        let tituloArteria, prep2, nomeArteria, localArteria: String?
        let troco, porta, cliente: String?
        let numCodPostal: String?
        let extCodPostal, desigPostal: String?

        enum CodingKeys: String, CodingKey {
            case codDistrito = "cod_distrito"
            case codConcelho = "cod_concelho"
            case codLocalidade = "cod_localidade"
            case nomeLocalidade = "nome_localidade"
            case codArteria = "cod_arteria"
            case tipoArteria = "tipo_arteria"
            case prep1
            case tituloArteria = "titulo_arteria"
            case prep2
            case nomeArteria = "nome_arteria"
            case localArteria = "local_arteria"
            case troco, porta, cliente
            case numCodPostal = "num_cod_postal"
            case extCodPostal = "ext_cod_postal"
            case desigPostal = "desig_postal"
        }
    }
}
