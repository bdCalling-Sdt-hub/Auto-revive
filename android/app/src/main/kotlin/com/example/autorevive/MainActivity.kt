package com.example.autorevive  // তোমার প্রকল্পের প্যাকেজ নাম

import android.content.Context
import android.os.Build
import android.os.Bundle
import android.os.Vibrator
import io.flutter.embedding.android.FlutterFragmentActivity  // যদি FlutterFragmentActivity দরকার হয়, অন্যথায় FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterFragmentActivity() {  // অথবা FlutterActivity ব্যবহার করো, যা দরকার

    private val CHANNEL = "com.example.vibration/vibrate"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "vibrate") {
                val duration = call.argument<Int>("duration") ?: 1000
                vibrateDevice(duration)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun vibrateDevice(duration: Int) {
        val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val vibrationEffect = android.os.VibrationEffect.createOneShot(duration.toLong(), android.os.VibrationEffect.DEFAULT_AMPLITUDE)
            vibrator.vibrate(vibrationEffect)
        } else {
            @Suppress("DEPRECATION")
            vibrator.vibrate(duration.toLong())
        }
    }
}
