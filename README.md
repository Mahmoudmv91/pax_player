# pax_player

#### This package based on [PAX Device with NetptuneLiteApi](https://docs.hips.com/docs/pax-a920 "PAX Device") SDK

## Important:
**THIS PACKAGE WILL WORK ONLY IN ANDROID!**

## Installation

```bash
flutter pub add flutter_pax_printer_utility
```


## Set minify and shrink on your buildtype gradle

```bash
add this line in your build.gradle
buildTypes {
    release {
        .
        .
        .
        minifyEnabled false
        shrinkResources false
    }
}
```
## Set this line on your AndroidManifest xml

...bash
<application
...
android:name="pax.plugin.pki.parhamkish.vakili.pax_player.PaxApp"
...
</application>
...



## What this package do
- [✅] Get DeviceInfo => use getDeviceInfo
- [✅] Get CardInfo => use getCardNumber
- [✅] Get Beep device => use getBeep
- [✅] Set Device Nav Bar enable => use setDisableNavBar set false
- [✅] Set Device Nav Bar disable => use setDisableNavBar set true

- [ ] Draw a divisor line


## If you have an Pax Terminal printer and need help with integration process, just [Contact Me](https://saweria.co/overlays/qr?streamKey=54dc04b8045bb0355cde915ab1bb85b5&topLabel=MAHA&bottomLabel=Buy+Me+A+Coffe&backgroundColor=%232b9dfaFF&barcodeColor=%23000&username=maha)

- [Github](https://github.com/Mahmoudmv91)
- [Email](mailto:mahmoudmv1991@gmail.com)
- [Telegram](https://t.me/Mahmoud_mv)


## Tested Devices

```bash
PAX A920 
```

## Donate me if you like it
If you want to support this package, you can [Donate](https://reymit.ir/mahmoudmv)

