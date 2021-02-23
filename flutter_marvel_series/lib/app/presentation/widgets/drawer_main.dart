import 'package:flutter/material.dart';
import 'package:flutter_marvel_series/app/presentation/pages/settings/settings.dart';
import 'package:flutter_marvel_series/app/presentation/pages/support/support.dart';
import 'package:flutter_marvel_series/app/presentation/utils/i18n.dart';

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return SafeArea(
      child: Container(
        width: mediaQuery.size.width * 0.60,
        height: mediaQuery.size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(22),
            topRight: Radius.circular(22),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              ListTile(
                onTap: () {
                  debugPrint("Tapped settings");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
                leading: Icon(Icons.settings),
                title: Text("app.settings".T),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  debugPrint("Tapped Payments");
                  //SupportPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportPage(),
                    ),
                  );
                },
                leading: Icon(Icons.support_agent),
                title: Text("app.support".T),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  debugPrint("Cerrar");
                  closeDrawer();
                },
                leading: Icon(Icons.exit_to_app),
                title: Text("Cerrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
