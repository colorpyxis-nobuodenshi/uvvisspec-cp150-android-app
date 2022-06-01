import 'package:flutter/material.dart';
import 'uvvisspec.dart';

class SettingsPage extends StatefulWidget {
  //const SettingsPage({Key? key}) : super(key: key);
  SettingsPage(this.settings);
  Settings settings;
  @override
  State<StatefulWidget> createState() {
    return SettingsPageState();
  }}

class SettingsPageState extends State<SettingsPage> {

  var _unitSel = Unit.w;
  var _wlSumMin = "";
  var _wlSumMax = "";
  var _wlRangeValues = const RangeValues(0.33, 0.8);
  var _exposuretime = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    final settings = widget.settings;
    _wlSumMin = settings.sumRangeMin.toInt().toString();
    _wlSumMax = settings.sumRangeMax.toInt().toString();
    _wlRangeValues = RangeValues(settings.sumRangeMin / 1000.0, settings.sumRangeMax / 1000.0);
    setState(() {
      _unitSel = settings.unit;
      _exposuretime = settings.deviceExposureTime;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Settings s = Settings();
        s.unit = _unitSel;
        s.sumRangeMin = double.parse(_wlSumMin);
        s.sumRangeMax = double.parse(_wlSumMax);
        s.deviceExposureTime = _exposuretime;
        // if(_unitSel == Unit.w || _unitSel == Unit.photon)
        // {
        //   s.sumRangeMin = 330;
        //   s.sumRangeMax = 800;
        // }
        // else
        // {
        //   s.sumRangeMin = 400;
        //   s.sumRangeMax = 700;
        // }
        Navigator.of(context).pop(s);

        return Future.value(false);
      },
      child : Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => {
              
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Column(
            children: [
              Card(
                child: Column(
                children: <Widget>[
                  const Text("光強度単位"),
              RadioListTile(title: const Text("W/m2"), value: Unit.w, groupValue: _unitSel, onChanged: (value) => { setState(()=>{_unitSel = Unit.w })}),
              RadioListTile(title: const Text("photons/m2/s"), value: Unit.photon, groupValue: _unitSel, onChanged: (value) => { setState(()=>{_unitSel = Unit.photon })}),
              RadioListTile(title: const Text("mol/m2/s"), value: Unit.mol, groupValue: _unitSel, onChanged: (value) => { setState(()=>{_unitSel = Unit.mol })}),
                ],
              ),
              ),
              Card(
                child: Column(
                children: <Widget>[
                  const Text("測定波長囲"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text("短波長端"),
                          Text(_wlSumMin, style: const TextStyle(fontSize: 20),),
                        ],
                    
                      ),
                      ElevatedButton(
                        child: const Text('リセット'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueGrey,
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                              _wlRangeValues = const RangeValues(0.31, 0.8);
                              _wlSumMin = (_wlRangeValues.start * 1000).toInt().toString();
                              _wlSumMax = (_wlRangeValues.end * 1000).toInt().toString();
                            });
                        },
                      ),
                      Column(
                        children: [
                          const Text("長波長端"),
                          Text(_wlSumMax, style: const TextStyle(fontSize: 20),),
                        ],
                      ),
                    ],
                  ),
                  Center(
                    // width: 280,
                    child: RangeSlider(values: _wlRangeValues,
                      activeColor: Colors.blueGrey,
                      inactiveColor: Colors.blueGrey.shade800,
                      onChanged: (values) {
                        setState(() {
                          _wlRangeValues = values;
                          _wlSumMin = (_wlRangeValues.start * 1000).toInt().toString();
                          _wlSumMax = (_wlRangeValues.end * 1000).toInt().toString();
                          // _wlSumMinEditingController = TextEditingController(text: _wlSumMin);
                          // _wlSumMaxEditingController = TextEditingController(text: _wlSumMax);
                        });
                      },
                      min: 0.33,
                      max: 0.8,
                      divisions: 47,
                    ),
                  ),
                ],
              ),
              
              ),
              Card(
                child: Column(
                children: <Widget>[
                  const Text("露光時間"),
              RadioListTile(title: const Text("AUTO"), value: "AUTO", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
              RadioListTile(title: const Text("100us"), value: "100us", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
              RadioListTile(title: const Text("1ms"), value: "1ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
              RadioListTile(title: const Text("10ms"), value: "10ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
              RadioListTile(title: const Text("100ms"), value: "100ms", groupValue: _exposuretime, onChanged: (value) => { setState(()=>{_exposuretime = value.toString()})}),
                ],
              ),
              ),
              ],
          )
        ],
      ),
      ),
    ),
    );
  }
}