package com.weathercrypto.flutter.weather_crypto_app_flutter

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
    override fun onCreate() {
        super.onCreate()
        //MapKitFactory.setLocale("YOUR_LOCALE") // Your preferred language. Not required, defaults to system language
        MapKitFactory.setApiKey("2eb5effa-b61b-4f6e-8294-8a3cbac2b5ce") // Your generated API key
    }
}