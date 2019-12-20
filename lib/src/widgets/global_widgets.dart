import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import './../../theme/style/global_style.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class GlobalWidgets {
  // Rotated Box
  static Widget rotatedBoxStyleraisedButtonWithoutIcon({
    List<double> heightPercentages = const [0.20, 0.25],
  }) {
    return RotatedBox(
      quarterTurns: 2,
      child: WaveWidget(
        config: CustomConfig(
          gradients: [
            [Colors.deepPurple.shade900, Colors.deepPurple.shade200],
            [Colors.deepPurple.shade200, Colors.deepPurple.shade900],
          ],
          durations: [19440, 10800],
          heightPercentages: heightPercentages,
          blur: MaskFilter.blur(BlurStyle.solid, 10),
          gradientBegin: Alignment.bottomLeft,
          gradientEnd: Alignment.topRight,
        ),
        waveAmplitude: 0,
        size: Size(
          double.infinity,
          double.infinity,
        ),
      ),
    );
  }

  // Raised Button withoutIcon Styling
  static Widget raisedButtonWithoutIcon(
    String text,
    Function _onPressed, {
    Color buttonColor = GlobalStyle.buttonsColor,
  }) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      color: buttonColor,
      onPressed: _onPressed,
      elevation: 11,
      shape: GlobalStyle.round,
      child: Text(
        text,
        style: GlobalStyle.buttonTextStyle,
      ),
    );
  }

  // Raised Button with Icon Styling
  static Widget raisedButtonWithIcon(
    icon,
    String text,
    Function _onPressed, {
    Color iconColor = GlobalStyle.iconColor,
    Color buttonColor = GlobalStyle.buttonsColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RaisedButton.icon(
        color: buttonColor,
        onPressed: _onPressed,
        elevation: 11,
        shape: GlobalStyle.round,
        icon: Icon(
          icon,
          size: 16,
          color: iconColor,
        ),
        label: Text(
          text,
          style: GlobalStyle.buttonTextStyle,
        ),
      ),
    );
  }

  // Input Field Styling
  static Widget inputFieldWidget(String placeholder, icon,
      {String label: '',
      Color iconColor: GlobalStyle.inputIconColort,
      Color fillColor: GlobalStyle.inputFilColor,
      keyboardType: TextInputType.text,
      passwordHidden: false,
      Function validatorFun,
      Function onSave}) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 20.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: TextFormField(
          obscureText: passwordHidden,
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: iconColor,
            ),
            hintText: placeholder,
            hintStyle: TextStyle(color: Colors.black26),
            filled: true,
            fillColor: fillColor,
            border: GlobalStyle.outline,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          ),
          keyboardType: keyboardType,
          validator: validatorFun,
          onSaved: onSave,
        ),
      ),
    );
  }

  // Input Field Styling
  static Widget dropDownFieldWidget(
    label,
    icon,
    list,
    Function _onDropdownFun,
    dropdownVal, {
    Color iconColor: GlobalStyle.inputIconColort,
    Color fillColor: GlobalStyle.inputFilColor,
    Function validatorFun,
    Function onSave,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 20.0,
                offset: Offset(0.0, 0.75))
          ],
        ),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              color: iconColor,
            ),
            hintStyle: TextStyle(color: Colors.black26),
            filled: true,
            fillColor: fillColor,
            border: GlobalStyle.outline,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          ),
          hint: Text(
            label,
            style: TextStyle(color: Colors.black26),
          ),
          isExpanded: true,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: _onDropdownFun,
          value: dropdownVal,
          validator: validatorFun,
          onSaved: onSave,
        ),
      ),
    );
  }
}
