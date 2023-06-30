import android.annotation.TargetApi
import android.bluetooth.BluetoothAdapter
import android.content.Intent
import android.os.Build
import io.flutter.embedding.android.FlutterActivity

@TargetApi(Build.VERSION_CODES.ECLAIR)
class BluetoothHandler(private val activity: FlutterActivity) {
    private val REQUEST_ENABLE_BLUETOOTH = 2
    private val bluetoothAdapter: BluetoothAdapter? =
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.ECLAIR) {
            BluetoothAdapter.getDefaultAdapter()
        } else {
            TODO("VERSION.SDK_INT < ECLAIR")
        }

    fun enableBluetooth(): Boolean {
        return bluetoothAdapter?.let {
            if (!it.isEnabled) {
                val enableBluetoothIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
                activity.startActivityForResult(enableBluetoothIntent, REQUEST_ENABLE_BLUETOOTH)
                true
            } else {
                false
            }
        } ?: false
    }

    fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        if (requestCode == REQUEST_ENABLE_BLUETOOTH) {
            if (resultCode == FlutterActivity.RESULT_OK) {
                // Bluetooth was enabled successfully
                // Handle the logic here
                println("Bluetooth enabled successfully!")
            } else {
                // Bluetooth was not enabled or the user declined to enable it
                // Handle the logic here
                println("Bluetooth not enabled!")
                val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
//                startActivityForResult(enableBtIntent, REQUEST_ENABLE_BLUETOOTH)
            }
        }
    }
}
