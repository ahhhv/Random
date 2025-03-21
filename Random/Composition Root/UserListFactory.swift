//
//  UserListFactory.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import SwiftData
import Foundation

@MainActor
class UserListFactory {
    let modelContainer: ModelContainer
    let mainContext: ModelContext
    
    init() {
        do {
            let schema = Schema([UserEntity.self])
            let configuration = ModelConfiguration(isStoredInMemoryOnly: false)
            self.modelContainer = try ModelContainer(for: schema, configurations: [configuration])
            self.mainContext = modelContainer.mainContext
            print("✅ SwiftData ModelContainer inicializado correctamente con UserEntity.")
        } catch {
            fatalError("❌ Error al inicializar SwiftData ModelContainer: \(error)")
        }
    }
    
    func createUserListView() -> UserListView {
        let localDataSource = SwiftDataLocalDataSource(context: mainContext)
        let apiDataSource = createDataSource()
        let mapper = UserMapper()

        let userRepository = UserRepository(
            apiDatasource: apiDataSource,
            localDatasource: localDataSource,
            mapper: mapper
        )

        let loadUsersUseCase = LoadUsersUseCase(repository: userRepository)
        let getUsersUseCase = GetUsersUseCase(repository: userRepository)
        let deleteUserUseCase = DeleteUserUseCase(repository: userRepository)

        let viewModel = UserListViewModel(
            loadUsersUseCase: loadUsersUseCase,
            getUsersUseCase: getUsersUseCase,
            deleteUsersUseCase: deleteUserUseCase
        )

        return UserListView(viewModel: viewModel)
    }
    
    private func createDataSource() -> ApiDataSourceType {
        let httpClient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
        return APIUserDataSource(httpClient: httpClient)
    }
}

