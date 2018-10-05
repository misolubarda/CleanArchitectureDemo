platform :ios, '9.0'
use_frameworks!
workspace 'CleanArchitecture.xcworkspace'

def unit_test_pods
    pod 'Nimble', '~> 7.0'
end

target 'CleanArchitecture' do
    target 'CleanArchitectureTests' do
        inherit! :search_paths
        unit_test_pods
    end

    target 'CleanArchitectureUITests' do
        inherit! :search_paths
    end
end

target 'DomainLayer' do
    project 'DomainLayer/DomainLayer.xcodeproj'

    target 'DomainLayerTests' do
        inherit! :search_paths
        unit_test_pods
    end
end

target 'DataLayer' do
    project 'DataLayer/DataLayer.xcodeproj'

    target 'DataLayerTests' do
        inherit! :search_paths
        unit_test_pods
    end
end
