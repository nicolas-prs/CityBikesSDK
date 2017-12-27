//
//  NetworkAPIManagerTests.swift
//  CityBikesSDKTests
//
//  Created by Nicolas on 26/12/2017.
//  Copyright © 2017 Nicolas Parimeros. All rights reserved.
//

import XCTest
import CityBikesSDK

class NetworkAPIManagerTests: XCTestCase {

    override func setUp() {
        super.setUp()
        SwiftSDK.provide(adapter: nil, baseUrl: "https://api.citybik.es/v2")
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetNetworks() {
        let expectation = XCTestExpectation()
        let networkAPIManager = NetworkAPIManager()
        networkAPIManager.getNetworks { (networkList, error, response) in

            guard let networks = networkList else { return XCTFail() }

            // Test network count
            XCTAssertEqual(networks.networks.count, 558)

            // Test first network
            let firstNetwork = networks.networks.first!
            XCTAssertEqual(firstNetwork.company?.count, 1)
            XCTAssertEqual(firstNetwork.company?.first, "Bike U Sp. z o.o.")
            XCTAssertEqual(firstNetwork.href, "/v2/networks/bbbike")
            XCTAssertEqual(firstNetwork.id, "bbbike")
            XCTAssertEqual(firstNetwork.location?.city, "Bielsko-Biała")
            XCTAssertEqual(firstNetwork.location?.country, "PL")
            XCTAssertEqual(firstNetwork.location?.latitude, 49.8225)
            XCTAssertEqual(firstNetwork.location?.longitude, 19.044444)
            XCTAssertEqual(firstNetwork.name, "BBBike")

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

    func testGetNetworkVelov() {
        let expectation = XCTestExpectation()
        let networkAPIManager = NetworkAPIManager()
        networkAPIManager.getStationsForNetwork(networkId: "velov") { (networkDetails, error, response) in

            guard let network = networkDetails?.network, let stations = network.stations else { return XCTFail() }

            // Test first network
            XCTAssertEqual(network.company?.count, 1)
            XCTAssertEqual(network.company?.first, "JCDecaux")
            XCTAssertEqual(network.href, "/v2/networks/velov")
            XCTAssertEqual(network.id, "velov")
            XCTAssertEqual(network.location?.city, "Lyon")
            XCTAssertEqual(network.location?.country, "FR")
            XCTAssertEqual(network.location?.latitude, 45.764043)
            XCTAssertEqual(network.location?.longitude, 4.835659)
            XCTAssertEqual(network.license?.name, "Open Licence")
            XCTAssertEqual(network.license?.url, "https://developer.jcdecaux.com/#/opendata/licence")
            XCTAssertEqual(network.name, "Vélo'V")

            // Test stations count
            XCTAssertEqual(stations.count, 339)

            // Test first station
            let firstStation = stations.first!
            XCTAssertEqual(firstStation.extra?.address, "Avenue Antoine Saint Exupery")
            XCTAssertEqual(firstStation.extra?.banking, true)
            XCTAssertEqual(firstStation.extra?.bonus, false)
            XCTAssertEqual(firstStation.extra?.slots, 15)
            XCTAssertEqual(firstStation.extra?.status, .open)
            XCTAssertEqual(firstStation.extra?.uid, 10060)
            XCTAssertEqual(firstStation.id, "b8cf7504ec4791deefaae0a2c18e31b7")
            XCTAssertEqual(firstStation.latitude, 45.758805)
            XCTAssertEqual(firstStation.longitude, 4.87889)
            XCTAssertEqual(firstStation.name, "10060 - SAINT EXUPÉRY")

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10)
    }

}
