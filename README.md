# school_todo_list

Flutter проект мобильного приложения "TODO лист".

[Скачать APK файл](https://github.com/Strafe0/school_todo_list/releases/download/homework-3/todo-app-homework-3.apk)

## Реализованные фичи
- Обработка ошибок.
- Оффлайн режим.
- Navigator 2.0 и диплинки.
Для проверки диплинка использовать команду
```
adb shell 'am start -a android.intent.action.VIEW \
    -c android.intent.category.BROWSABLE \
    -d "https://school_todo_list.example.com/task"' \
    com.example.school_todo_list
```
- Unit-тесты для `TaskRepository` и `TaskRemoteSource` + два интеграционных теста.
Для проверки интеграционных тестов использовать команду
```
flutter test -d "<device-name> или <device-id>" integration_test/*.dart --dart-define=TOKEN=<bearer-token>
```

## Скриншоты
<table>
    <tr>
        <td>
            Главный экран
        </td>
        <td>
            Главный экран, когда нет интернета
        </td>
    </tr>
    <tr>
        <td>
            <img src="/screenshots/main_screen_new.jpg">
        </td>
        <td>
            <img src="/screenshots/offline_mode.jpg">
        </td>
    </tr>
</table>