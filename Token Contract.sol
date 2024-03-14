// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VehicleChargingPayment {
    address public owner;

    // Araç cüzdan adresleri ve bakiyeleri
    mapping(address => uint) public balances;

    // İstasyon cüzdan adresleri ve bakiyeleri
    mapping(address => uint) public stationBalances;

    constructor() {
        owner = msg.sender;
    }

    // Para yatırma işlemi için fonksiyon
    function deposit() public payable {
        require(msg.value > 0, "Yatirilacak miktar 0'dan buyuk olmalidir");
        balances[msg.sender] += msg.value;
    }

    // Yakıt/Şarj alımı ve ödeme işlemi
    function purchaseFuel(address station, uint amount) public {
        require(balances[msg.sender] >= amount, "Yetersiz bakiye");
        require(amount > 0, "Miktar 0'dan buyuk olmalidir");

        balances[msg.sender] -= amount;
        stationBalances[station] += amount;

        // Gerçek bir uygulamada, burada aracın istasyona yakıt veya şarj sağlaması için
        // ek işlemler yapılabilir.
    }

    // İstasyon bakiyelerini çekme
    function withdrawFromStation(address payable station) public {
        require(msg.sender == station, "Yalnizca istasyon sahibi cekebilir");
        uint amount = stationBalances[station];
        stationBalances[station] = 0;
        station.transfer(amount);
    }
}
