package app.youtube_downloader

import android.content.Intent
import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private var data: String = "";


//    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
//        super.onCreate(savedInstanceState, persistentState)
//
//        getIntentData();
//    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "app.youtube").setMethodCallHandler {call, result ->
            if(call.method == "getData"){
                getIntentData();
                result.success(data);
                data = "";
            }
        }
    }

    private fun getIntentData() {
        //Get the shared data
        //Only get the intent if the send intent is a "text"
        if (intent?.action == Intent.ACTION_SEND){
            if(intent.type == "text/plain"){
                intent.getStringExtra(Intent.EXTRA_TEXT)?.let { intentData ->
                    data = intentData
                }
            }
        }
    }

}
