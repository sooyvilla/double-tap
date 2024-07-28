// import 'dart:developer' as dev;

import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/ui/providers/settings/settings_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../ui.dart';

String selectedUrl = ValorantUrls.urlLoginWebView;
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class AccountWebview extends ConsumerStatefulWidget {
  const AccountWebview({super.key});

  @override
  ConsumerState<AccountWebview> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends ConsumerState<AccountWebview>
    with DioConfigService {
  late WebViewController controller;
  final isLoading = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(kAndroidUserAgent)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) async {
          if (request.url.contains('https://playvalorant.com/')) {
            await ref
                .read(settingsAccountProvider.notifier)
                .loginWebView(request.url);

            ref
                .read(settingsAccountProvider.notifier)
                .setIsShowAccountWebView(false);

            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
        onProgress: (progress) {
          progress == 100 ? isLoading.value = false : isLoading.value = true;
        },
      ))
      ..loadRequest(
        Uri.parse(selectedUrl),
      );
  }

//
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Riot Games',
          style: textTitle,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () async {
            await controller.clearCache();
            await controller.clearLocalStorage();

            ref
                .read(settingsAccountProvider.notifier)
                .setIsShowAccountWebView(false);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: height * 0.8,
                  child: WebViewWidget(
                    controller: controller,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ValueListenableBuilder<bool>(
                    valueListenable: isLoading,
                    builder: (context, loading, child) {
                      if (loading) {
                        return const Center(
                          child: CircularLoad(),
                        );
                      }
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjJlOTg0NDA3LTEzODYtNGJjNS1iMjRlLTA4MzRmODg0YmY2YSIsIm5vbmNlIjoiYzVFTFNiRktDeWs9IiwiaWF0IjoxNzIyMTI1Nzk5fQ.VBro8NLtMKfa1CvbsejA-X5X6zZDxGzMAwklQ-z9Zo4

//_ga_0X9JWXB87B=GS1.1.1722123958.1.1.1722126939.0.0.0; _ga=GA1.1.936181038.1722123959; osano_consentmanager=xxr_rKWQviEV88gL2ds9OvGrWbarxRK1i99V-xp-Ymp55aS63AZNF2wgqfkO8SfY1n7b3ZMG_ehMzSUYL5l3iAFVVNtmq2Z4QA5TGZAnGXeew7TnxoNXujCbAM5fbw-MiPi2hZ_9JNOGlSrE1aH4P2dUNFQ-XiFjr-8x6aicJ0HnOdT8lb6v163NVI4-S9F3ZgJLel0FHLrBDLq_vL3QzoS2cRtf6enu8_6vQCv_jkOfq3dqDle1M8D9dg7UefHkSyzvnFUpqXZJnwOUOTCjEyViLFKGlQdylZQuQChJ9c8=; osano_consentmanager_uuid=2d791ef6-3bb5-404d-8af9-9c76b20bc877

// https://playvalorant.com/opt_in#access_token=eyJraWQiOiIxIiwiYWxnIjoiUlMyNTYifQ.eyJwcCI6eyJjIjoiYW0ifSwic3ViIjoiYmIzMjNlZTUtOWVkMy01MGY1LWFiMTQtMjJkMjlkYWRjMDExIiwic2NwIjpbImFjY291bnQiLCJvcGVuaWQiXSwiY2xtIjpbImZlZGVyYXRlZF9pZGVudGl0eV9wcm92aWRlcnMiLCJlbWFpbF92ZXJpZmllZCIsIm9wZW5pZCIsInB3IiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIiwiYWNjdF9nbnQiLCJsb2NhbGUiLCJhY2N0IiwiYWdlIiwiYWNjb3VudF92ZXJpZmllZCIsImZlZGVyYXRlZF9pZGVudGl0eV9kZXRhaWxzIiwiYWZmaW5pdHkiXSwiZGF0Ijp7InAiOm51bGwsImMiOiJ1dzEiLCJsaWQiOiJobHlpV2tuRWlXOW5CazFHeERYRURBIn0sImlzcyI6Imh0dHBzOi8vYXV0aC5yaW90Z2FtZXMuY29tIiwicGx0Ijp7ImRldiI6InVua25vd24iLCJpZCI6IndlYiJ9LCJleHAiOjE3MjIxMzA1NDEsImlhdCI6MTcyMjEyNjk0MSwianRpIjoiVWVqM1kydkJIRXMiLCJjaWQiOiJwbGF5LXZhbG9yYW50LXdlYi1wcm9kIn0.VjBH_MvGlr_VD4jg7D7uEakjjQ6Uz88zrOTrp8x3BpRmds9gvex2YTivJdPAOi7orIyFqIGfLKM3fUuZDczuhiqf9KB8jzEyvZg5wT2RHoDDXWn9RrGCamkB6obX6cCty59OPO0cCblQxkvBNwqpsH_C72wJp3CqnvoYSjSMFbW3uRrxM-010a3t0X6ISNA11SElYIqEgoLVlWQlKknvW-hkC27Hjbv7oL3bvxYLrFFuZhYiGQxb875fVzECdOW77uOe0_z9Fig4WSAizk8Uu4Y-jlk0PfyVFd8gaCb3xKs_MvJsmw4n9LsIim4YAUm_oN41O70ZDXf4dhpXEg3ltA&scope=account+openid&iss=https%3A%2F%2Fauth.riotgames.com&id_token=eyJraWQiOiIxIiwidHlwIjoiaWRfdG9rZW4rand0IiwiYWxnIjoiUlMyNTYifQ.eyJhdF9oYXNoIjoiS0N2b3ZWaWNrTEdFRXFDem5lUVBjQSIsInN1YiI6ImJiMzIzZWU1LTllZDMtNTBmNS1hYjE0LTIyZDI5ZGFkYzAxMSIsImNvdW50cnkiOiJ1c2EiLCJwbGF5ZXJfcGxvY2FsZSI6bnVsbCwiY291bnRyeV9hdCI6MTY1NzA1ODAyMjAwMCwiYW1yIjpbInBhc3N3b3JkIl0sImlzcyI6Imh0dHBzOi8vYXV0aC5yaW90Z2FtZXMuY29tIiwicGhvbmVfbnVtYmVyX3ZlcmlmaWVkIjpmYWxzZSwibG9jYWxlIjoiZXNfTVgiLCJub25jZSI6IjEiLCJhY2NvdW50X3ZlcmlmaWVkIjpmYWxzZSwiYXVkIjoicGxheS12YWxvcmFudC13ZWItcHJvZCIsImFjciI6InVybjpyaW90OmJyb256ZSIsImxvbF9yZWdpb24iOm51bGwsInBsYXllcl9sb2NhbGUiOiJlbiIsImV4cCI6MTcyMjIxMzM0MSwiaWF0IjoxNzIyMTI2OTQxLCJhY2N0Ijp7ImdhbWVfbmFtZSI6IkxlYXJuaW5nIEVuZ2xpc2giLCJ0YWdfbGluZSI6IkNPTCJ9LCJhZ2UiOjIzLCJqdGkiOiJ2TGhvc1FRa081YyIsImxvZ2luX2NvdW50cnkiOiJjb2wifQ.DFP7XNuIxIUT4hAzt9AQlEZEsD0TApDmnX6fKfgaDIcDcEJKGvOCNMrQiFY4wNmPsh-rM-Sd5T_XvFJeKZZYIGKu3_b_DVb6DoNcOJGkam5E1dgxdPiM_TFhIyzS-51937hZTIuNXnuO0oTnK_0btk3w97Z0d-QPiZA2U29Up32NOZxd3IWVvI6R00c_3rwE9_VlAtvmx_Zoo4d8XINzg39msQNRhcGA_TaiET8L9ApvRl0yNwdJ9BmAnL4cJVdCnv4CPoHg6mq1orPjbIEPSwqbBWgi-sRhXD44SuX1IfVieJ3Gl4SoiBHpB3KTbX26z-9OTnBL3_RNKifRXk4bDw&token_type=Bearer&session_state=0Qs0zhoslaDbzNUn4O0VHAKQMpgvPbsjH1lHbVgnrDU.0VMr73fQWEZAVWaIoUlQfQ&expires_in=3600

// class AccountWebview extends StatelessWidget {
//   const AccountWebview({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // ignore: prefer_collection_literals
//     final Set<JavascriptChannel> jsChannels = [
//       JavascriptChannel(
//           name: 'Print',
//           onMessageReceived: (JavascriptMessage message) {
//             dev.log(message.message);
//           }),
//     ].toSet();
//     return const WebViewCustom();
//   }
// }

// class WebViewCustom extends ConsumerStatefulWidget {
//   const WebViewCustom({super.key});

//   @override
//   WebViewCustomState createState() => WebViewCustomState();
// }

// class WebViewCustomState extends ConsumerState<WebViewCustom> {
//   // Instance of WebView plugin
//   final flutterWebViewPlugin = FlutterWebviewPlugin();

//   // On destroy stream
//   late StreamSubscription _onDestroy;

//   // On urlChanged stream
//   late StreamSubscription<String> _onUrlChanged;

//   // On urlChanged stream
//   late StreamSubscription<WebViewStateChanged> _onStateChanged;

//   late StreamSubscription<WebViewHttpError> _onHttpError;

//   late StreamSubscription<double> _onProgressChanged;

//   final _urlCtrl = TextEditingController(text: selectedUrl);

//   final _codeCtrl = TextEditingController(text: 'window.navigator.userAgent');

//   final _history = [];

//   @override
//   void initState() {
//     super.initState();

//     flutterWebViewPlugin.close();

//     _urlCtrl.addListener(() {
//       selectedUrl = _urlCtrl.text;
//     });

//     _onDestroy = flutterWebViewPlugin.onDestroy.listen((_) {
//       if (mounted) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(const SnackBar(content: Text('Webview Destroyed')));
//       }
//     });

//     _onUrlChanged = flutterWebViewPlugin.onUrlChanged.listen((String url) {
//       if (mounted) {
//         setState(() {
//           _history.add('onUrlChanged: $url');
//         });
//       }
//     });

//     _onProgressChanged =
//         flutterWebViewPlugin.onProgressChanged.listen((double progress) {
//       if (mounted) {
//         setState(() {
//           _history.add('onProgressChanged: $progress');
//         });
//       }
//     });

//     _onStateChanged =
//         flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
//       if (mounted) {
//         setState(() {
//           _history.add('onStateChanged: ${state.type} ${state.url}');
//         });
//       }
//     });

//     _onHttpError =
//         flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {
//       if (mounted) {
//         setState(() {
//           _history.add('onHttpError: ${error.code} ${error.url}');
//         });
//       }
//     });

//     flutterWebViewPlugin.launch(selectedUrl, hidden: true);
//   }

//   @override
//   void dispose() {
//     _onDestroy.cancel();
//     _onUrlChanged.cancel();
//     _onStateChanged.cancel();
//     _onHttpError.cancel();
//     _onProgressChanged.cancel();

//     flutterWebViewPlugin.dispose();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Login Riot'),
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () async {
//               flutterWebViewPlugin.close();

//               ref
//                   .read(settingsAccountProvider.notifier)
//                   .setIsShowAccountWebView(false);
//             },
//           ),
//         ],
//       ),
//       body: const SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [],
//         ),
//       ),
//     );
//   }
// }
