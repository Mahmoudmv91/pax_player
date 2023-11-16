# pax_player

#### This package based on [PAX Device with NetptuneLiteApi](https://docs.hips.com/docs/pax-a920 "PAX Device") SDK

## Important:
**THIS PACKAGE WILL WORK ONLY IN ANDROID!**

## Installation

```bash
flutter pub add pax_player
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

```bash
add this line in your AndroidManifest.xml
<application
...
android:name="pax.plugin.pki.parhamkish.vakili.pax_player.PaxApp"
...
</application>
```



## What this package do
- [✅] Get DeviceInfo => use getDeviceInfo
- [✅] Get CardInfo => use getCardNumber
- [✅] Get Beep device => use getBeep
- [✅] Set Device Nav Bar enable => use setEnableNavBar set true
- [✅] Get BarcodeInfo => use getScanBarcode
- [ ] get all device info
- [ ] call printer
- [ ] device setting
- [ ] call all scanner methods 


## If you have an Pax Terminal printer and need help with integration process, just Contact me

- [Github](https://github.com/Mahmoudmv91)
- [Email](mailto:mahmoudmv1991@gmail.com)
- [Telegram](https://t.me/Mahmoud_mv)


## Tested Devices

```bash
PAX A920 
```

## Donate me if you like it
If you want to support this package, you can [Donate](https://reymit.ir/mahmoudmv)

