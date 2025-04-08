import 'package:fixiez/core/theme/app_colors.dart';
import 'package:fixiez/core/theme/app_text.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  const WebviewPage({super.key, required this.url});
  final String url;

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late final WebViewController controller;
  var isLoading =true;
  var hasError=false;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)..setNavigationDelegate(
        NavigationDelegate(
        onPageStarted: (url) => setState(() {
          isLoading = true;
          hasError = false;
        }),
        onPageFinished: (url) => setState(() => isLoading = false),
        onWebResourceError: (error) => setState(() {
          hasError = true;
          isLoading = false;
        }),
      ))..loadRequest(Uri.parse(widget.url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('مشاهدة البانر', style: context.bold20Blue),
        actions: [
          if(hasError)
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.reload(),
            )
    
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if(isLoading) const Center(child: CircularProgressIndicator(color: AppColors.primary)),
          if(hasError)  Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('حدث خطأ ما', style:context.error,),
              TextButton(onPressed: () => controller.reload(), child: Text('اعادة المحاولة', style: context.bold16Blue,))
            ],
          )),
        ],
      ),
    );
  }
}
