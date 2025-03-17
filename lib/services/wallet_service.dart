import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class WalletService {
  final String rpcUrl =
      "https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID"; // Replace with your Infura ID
  late Web3Client _client;

  WalletService() {
    _client = Web3Client(rpcUrl, http.Client());
  }

  Future<String> getBalance(String walletAddress) async {
    final address = EthereumAddress.fromHex(walletAddress);
    final balance = await _client.getBalance(address);
    return balance.getValueInUnit(EtherUnit.ether).toString();
  }
}
