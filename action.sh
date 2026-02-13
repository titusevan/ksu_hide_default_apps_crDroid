#!/system/bin/sh

# 1. ОТКЛЮЧЕННЫЕ / УДАЛЕННЫЕ ДЛЯ USER 0
echo "--- [ ОТКЛЮЧЕННЫЕ ИЛИ УДАЛЕННЫЕ ] ---"
pm list packages -u -d --user 0 | cut -d ":" -f 2 | sort
echo ""

# 2. СТАТУС ПАКЕТОВ ИЗ ТВОЕГО СПИСКА
echo "--- [ СТАТУС ТВОИХ ПАКЕТОВ ] ---"
MY_PKGS="com.android.stk org.omnirom.logcat com.android.contacts org.lineageos.aperture com.android.calculator2 com.android.deskclock org.lineageos.etar org.lineageos.glimpse org.lineageos.twelve org.lineageos.gallery3d com.android.dialer com.android.messaging org.lineageos.browser org.lineageos.recorder org.lineageos.jelly com.google.android.safetycore"

for pkg in $MY_PKGS; do
    if pm list packages --user 0 | grep -qx "package:$pkg"; then
        echo "[ СТОИТ ] $pkg"
    else
        echo "[ УДАЛЕН ] $pkg"
    fi
done
echo ""

# 3. ВООБЩЕ ВСЕ ПАКЕТЫ В СИСТЕМЕ
echo "--- [ ВСЕ ПАКЕТЫ В СИСТЕМЕ (TOTAL) ] ---"
# Выводит все пакеты, включая системные и пользовательские
pm list packages --user 0 | cut -d ":" -f 2 | sort

echo ""
echo "--- Проверка завершена ---"
