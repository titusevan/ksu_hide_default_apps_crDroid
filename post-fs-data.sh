#!/system/bin/sh

(
  while [ "$(getprop sys.boot_completed)" != "1" ]; do
    sleep 2
  done
  
  sleep 30
  
  log -p i -t KSU_MODULE "Starting to remove packages and disable donate nudge..."

  # --- Блок отключения уведомления о донатах ---
  # Устанавливаем дату "последней проверки" на 200 лет вперед (в миллисекундах)
  # Это заставит DonateReceiver думать, что кулдаун в 30 дней еще не прошел
  log -p i -t KSU_MODULE "Starting: Disable Donate Nudge & Cleanup"
  FUTURE_DATE="64060588800000"

  # Отключаем плашку Live Captions (живых субтитров) в панели громкости
  settings put secure odi_captions_volume_ui_enabled 0
  adb shell settings put global asst_caption_enabled 0
  
  # Пытаемся записать через settings put (самый надежный метод для системных настроек)
  settings put global pref_donate_checked_in $FUTURE_DATE
  settings put secure pref_donate_checked_in $FUTURE_DATE
  settings put system pref_donate_checked_in $FUTURE_DATE
  
  # Дополнительно пытаемся "заморозить" сам ресивер, если это возможно
  pm disable com.android.settings/com.crdroid.settings.fragments.about.DonateReceiver > /dev/null 2>&1
  
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
