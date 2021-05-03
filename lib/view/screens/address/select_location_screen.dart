import 'package:flutter/material.dart';
import 'package:flutter_restaurant/localization/language_constrants.dart';
import 'package:flutter_restaurant/provider/location_provider.dart';
import 'package:flutter_restaurant/utill/color_resources.dart';
import 'package:flutter_restaurant/utill/dimensions.dart';
import 'package:flutter_restaurant/utill/images.dart';
import 'package:flutter_restaurant/view/base/custom_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  GoogleMapController _controller;
  TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<LocationProvider>(context).address != null) {
      _locationController.text = '${Provider.of<LocationProvider>(context).address.name ?? ''}, '
          '${Provider.of<LocationProvider>(context).address.subAdministrativeArea ?? ''}, '
          '${Provider.of<LocationProvider>(context).address.isoCountryCode ?? ''}';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.getPrimaryColor(context),
        elevation: 0,
        leading: SizedBox.shrink(),
        centerTitle: true,
        title: Text(getTranslated('select_delivery_address', context)),
      ),
      body: Consumer<LocationProvider>(
        builder: (context, locationProvider, child) => Stack(
          clipBehavior: Clip.none, children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(locationProvider.position.latitude ?? 0.0, locationProvider.position.longitude ?? 0.0),
                zoom: 14,
              ),
              zoomControlsEnabled: false,
              compassEnabled: false,
              indoorViewEnabled: true,
              mapToolbarEnabled: true,
              onCameraIdle: () {
                locationProvider.dragableAddress();
              },
              onCameraMove: ((_position) => locationProvider.updatePosition(_position)),
              // markers: Set<Marker>.of(locationProvider.markers),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                if (_controller != null) {
                  locationProvider.getCurrentLocation(mapController: _controller);
                }
              },
            ),
            locationProvider.address != null?
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 18.0),
              margin: const EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 23.0),
              decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL)),
              child: Text(locationProvider.address.name != null
                  ? '${locationProvider.address.name} , ${locationProvider.address.subAdministrativeArea} , ${locationProvider.address.isoCountryCode} '
                  : ''),
            ):SizedBox.shrink(),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      locationProvider.getCurrentLocation(mapController: _controller);
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.PADDING_SIZE_SMALL),
                        color: ColorResources.COLOR_WHITE,
                      ),
                      child: Icon(
                        Icons.my_location,
                        color: ColorResources.COLOR_PRIMARY,
                        size: 35,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                    child: CustomButton(
                      btnTxt: getTranslated('select_location', context),
                      onTap: locationProvider.loading ? null : () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  Images.marker,
                  width: 25,
                  height: 35,
                )),
            locationProvider.loading ? Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor))) : SizedBox(),
          ],
        ),
      ),
    );
  }
}
