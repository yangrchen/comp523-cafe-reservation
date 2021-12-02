import 'package:flutter/material.dart';

class CafeInfoTemplate extends StatefulWidget {
  final List<Widget> children;
  final bool hasBackButton;
  final int? imageIdx;

  const CafeInfoTemplate(
      {Key? key,
      required this.children,
      this.hasBackButton = false,
      this.imageIdx})
      : super(key: key);

  @override
  _CafeInfoTemplateState createState() => _CafeInfoTemplateState();
}

class _CafeInfoTemplateState extends State<CafeInfoTemplate> {
  Widget _buildImage(int? idx) {
    if (idx != null) {
      if (idx < 3) {
        return Image.asset('assets/images/img$idx.jpeg', fit: BoxFit.fill);
      } else {
        return Image.asset('assets/images/img3.jpeg', fit: BoxFit.fill);
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              color: Theme.of(context).primaryColor,
              // Temporarily image placement for demo
              child: _buildImage(widget.imageIdx),
            ),
            widget.hasBackButton
                ? Positioned(
                    left: 10,
                    top: 50,
                    width: 60,
                    height: 60,
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(133, 133, 133, 0.8),
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  )
                : Container(),
            Positioned(
              top: 280,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: Container(
                margin: const EdgeInsets.only(top: 50.0),
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListView(children: widget.children),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
