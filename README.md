# school_todo_list

Flutter проект мобильного приложения "TODO лист".

[Скачать APK файл](https://github.com/Strafe0/school_todo_list/releases/download/homework/todo-app-homework-1.apk) (см. релизы).

## Реализованные фичи
- Сверстаны оба экрана: 
    1. основной экран со списком всех задач,
    2. экран создания/редактирования задачи.
- Реализован свайп по задаче слева (Выполнить) и справа (Удалить).
- При нажатии на иконку с глазом будут показываться/скрываться выполненные задачи.
- Логирование с помощью пакета [logger](https://pub.dev/packages/logger). Используется фильтр `DevelopmentFilter` - логи не будут попадать в релизный билд.
- Добавлена иконка для Android версии приложения.
- Разбиение кода на слои Presentation, Domain и Data.
- Системная поддержка смена темы.
- Код консистентно отформатирован.
- На данном этапе не реализована главная логика и весь state management завязан на коллбеки и setState, используется глобальный список задач для быстроты.

## Скриншоты
<table>
    <tr>
        <td>
            Главный экран
        </td>
        <td>
            AppBar после прокрутки
        </td>
        <td>
            Показ скрытых (выполненных) задач
        </td>
    </tr>
    <tr>
        <td>
            <img src="/screenshots/main_screen.jpg">
        </td>
        <td>
            <img src="/screenshots/sliver_app_bar.jpg">
        </td>
        <td>
            <img src="/screenshots/show_completed_tasks.jpg">
        </td>
    </tr>
</table>

<table>
    <tr>
        <td>
            Выполнить задачу
        </td>
        <td>
            Удалить задачу
        </td>
        <td>
            Экран создания задачи
        </td>
        <td>
            Возможность скролла экрана
        </td>
    </tr>
    <tr>
        <td>
            <img src="/screenshots/complete_action.jpg">
        </td>
        <td>
            <img src="/screenshots/delete_action.jpg">
        </td>
        <td>
            <img src="/screenshots/create_task.jpg">
        </td>
        <td>
            <img src="/screenshots/scrollable_edit_screen.jpg">
        </td>
    </tr>
</table>

