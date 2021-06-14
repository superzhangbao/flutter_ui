package com.hikvision.flutter_ui

import android.Manifest
import android.content.Intent
import android.net.Uri
import android.os.Build
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.content.FileProvider
import androidx.core.content.PermissionChecker
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.File

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "launchFile")
                .setMethodCallHandler { call: MethodCall, result: MethodChannel.Result? ->
                    if (call.method == "viewPdf" || call.method == "viewExcel") {
                        val path = call.argument<String>("file_path")
                        if (!checkPermission(Manifest.permission.READ_EXTERNAL_STORAGE)) {
                            requestPermission(arrayOf(Manifest.permission.READ_EXTERNAL_STORAGE))
                        } else {
//                            launchFile(path!!)
                            result?.success("ok")
                        }
                    }
                }
    }

    private fun requestPermission(permission: Array<String>) {
        ActivityCompat.requestPermissions(this, permission, 1)
    }

    private fun checkPermission(permission: String): Boolean {
        return if (Build.VERSION.SDK_INT < Build.VERSION_CODES.M) {
            true
        } else {
            ContextCompat.checkSelfPermission(this, permission) == PermissionChecker.PERMISSION_GRANTED
        }
    }

    private fun launchFile(filePath: String) {
        val file = File(filePath)
        if (file.exists()) {
            val intent = Intent(Intent.ACTION_VIEW)
            intent.flags = Intent.FLAG_ACTIVITY_SINGLE_TOP
            intent.addCategory("android.intent.category.DEFAULT")
            val uri: Uri?
            uri = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
                intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
                val packageName = this.packageName
                FileProvider.getUriForFile(this, "$packageName.fileProvider", File(filePath))
            } else {
                Uri.fromFile(file)
            }
            if (filePath.contains(".pdf")) intent.setDataAndType(uri, "application/pdf") else intent.setDataAndType(uri, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
            try {
                this.startActivity(intent)
            } catch (e: Exception) {
                //Could not launch the file.
            }
        }
    }
}
