//
//  UserListFactory.swift
//  Random
//
//  Created by Alex Hernández on 19/3/25.
//

import Foundation

class UserListFactory {
    static func create() -> UserListView {
        UserListView(viewModel: createViewModel())
    }

    private static func createViewModel() -> UserListViewModel {
        return UserListViewModel(getUserList: createUseCase())
    }

    private static func createUseCase() -> GetUserRepositoryType {
        return GetUserRepository(repository: createRepository())
    }

    private static func createRepository() -> UserRepositoryType {
        return UserRepository(apiDatasource: createDataSource(),
                              mapper: UserMapper())
    }

    private static func createDataSource() -> ApiDataSourceType {
        let httpClient = URLSessionHTTPClient(requestMaker: URLSessionRequestMaker())
        return APIUserDataSource(httpClient: httpClient)
    }
}
