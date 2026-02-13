#!/system/bin/sh

(
  sleep 30
  log -p i -t KSU_MODULE "Starting to remove packages..."

  pm uninstall -k --user 0 com.android.stk
  pm uninstall -k --user 0 org.omnirom.logcat
  pm uninstall -k --user 0 com.android.contacts
  pm uninstall -k --user 0 org.lineageos.aperture
  pm uninstall -k --user 0 com.android.calculator2
  pm uninstall -k --user 0 com.android.deskclock
  pm uninstall -k --user 0 org.lineageos.etar
  pm uninstall -k --user 0 org.lineageos.glimpse
  pm uninstall -k --user 0 org.lineageos.twelve
  pm uninstall -k --user 0 org.lineageos.gallery3d
  pm uninstall -k --user 0 com.android.dialer
  pm uninstall -k --user 0 com.android.messaging
  pm uninstall -k --user 0 org.lineageos.browser
  pm uninstall -k --user 0 org.lineageos.recorder
  pm uninstall -k --user 0 org.lineageos.jelly

  log -p i -t KSU_MODULE "Disabling com.google.android.safetycore..."
  pm disable-user --user 0 com.google.android.safetycore
  log -p i -t KSU_MODULE "com.google.android.safetycore disabled."

  log -p i -t KSU_MODULE "Package removal and disabling finished."
) &
