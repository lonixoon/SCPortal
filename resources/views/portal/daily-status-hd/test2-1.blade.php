@extends('portal.daily-status-hd.test2')

@section('form')
    <form action="{{ url('/daily-status-helpdesk/result') }}" method="post" enctype="multipart/form-data">
        {{ csrf_field() }}
        <div class="input-file">
            <div class="input-file__label">Файл не выбран</div>
            <div class="input-file__btn">Обзор</div>
            <input type="file" accept=".rtf" name="file" id="upload" onchange="getFileName(this.value)" required>
        </div>
        <p>
            <button class="btn" type="submit">Загрузить</button>
        </p>
        <p>
            <a href="{{ url('/') }}" class="btn">На главную</a>
        </p>
    </form>
    @if (count($errors) > 0)
        <div>
            <span class="error-red">Ошибка: Вставьте файл с расширением RTF</span>
        </div>
    @endif
@endsection