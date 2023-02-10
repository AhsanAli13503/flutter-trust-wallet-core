//
//  Wallet.swift
//  Runner
//
//  Created by Ahsan Ali on 09/02/2023.
//
import WalletCore

class Wallet{
    var wallet:HDWallet
    
    init(wallet: HDWallet) {
        self.wallet = wallet
    }
    
    func getAdreessBTC() -> String{
        return self.wallet.getAddressForCoin(coin: .bitcoin)
    }

    func getAdressETH() -> String{
        let addressETH = self.wallet.getAddressForCoin(coin: .ethereum)
        return addressETH
    }


    func getAdressBNB() -> String{
        return self.wallet.getAddressForCoin(coin: .binance)
    }
    
    
    func etheriumSigingInput(toAdrress:String, amount:String) -> String{
        let signerInput = EthereumSigningInput.with {
            $0.chainID = Data(hexString: "01")!
            $0.gasPrice = Data(hexString: "d693a400")! // decimal 3600000000
            $0.gasLimit = Data(hexString: "5208")! // decimal 21000
            $0.toAddress = toAdrress
            $0.transaction = EthereumTransaction.with {
                $0.transfer = EthereumTransaction.Transfer.with {
                   $0.amount = Data(hexString: amount)!
               }
            }
            $0.privateKey = self.wallet.getKeyForCoin(coin: .ethereum).data
        }
        let output: EthereumSigningOutput = AnySigner.sign(input: signerInput, coin: .ethereum)
        return output.encoded.hexString
    }
}



