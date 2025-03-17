import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class WalletService {
  late WalletConnect connector;

  WalletService() {
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: PeerMeta(
        name: "AIVENMO",
        description: "A multi-chain crypto wallet",
        url: "https://aivenmo.com",
        icons: ["https://aivenmo.com/icon.png"],
      ),
    );

    connector.on('connect', (session) {
      print('Connected: ${session.accounts}');
    });

    connector.on('session_update', (session) {
      print('Session updated: ${session.accounts}');
    });

    connector.on('disconnect', (session) {
      print('Disconnected');
    });
  }

  Future<void> connectWallet() async {
    if (!connector.connected) {
      try {
        SessionStatus? session = await connector.createSession(
          chainId: 1,
          onDisplayUri: (uri) async {
            await launchUrl(
              Uri.parse(uri),
              mode: LaunchMode.externalApplication,
            );
          },
        );
        print('Wallet connected: ${session?.accounts}');
      } catch (e) {
        print('Error connecting wallet: $e');
      }
    }
  }

  void disconnectWallet() {
    connector.killSession();
  }
}
