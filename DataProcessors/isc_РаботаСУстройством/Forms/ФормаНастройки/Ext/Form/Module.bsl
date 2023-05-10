﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	СткНастройки = Справочники.isc_Настройки.ПолучитьНастройки();
	ЗаполнитьЗначенияСвойств(ЭтаФорма, СткНастройки,,"МетодыХранения,СоответствиеУпаковок");
	ЭтаФорма.МетодыХранения.Загрузить(СткНастройки.МетодыХранения);
	ЭтаФорма.СоответствиеУпаковок.Загрузить(СткНастройки.СоответствиеУпаковок);	
КонецПроцедуры

&НаКлиенте
Процедура СохранитьНастройки(Команда)
	СохранитьНастройкиНаСервере();
КонецПроцедуры

&НаСервере
Процедура СохранитьНастройкиНаСервере() 

	СткНастройки = Новый Структура("АдресУстройства,Логин,Пароль,Порт,ИспользоватьSSL,Логирование,МетодыХранения,СоответствиеУпаковок");
	ЗаполнитьЗначенияСвойств(СткНастройки, ЭтаФорма);
	Справочники.isc_Настройки.СохранитьНастройки(сткНастройки);
КонецПроцедуры


&НаКлиенте
Процедура ТестСоединения(Команда)
	УспешноПодключились = УстановитьСоединенияНаСервере();
	Если УспешноПодключились Тогда
		ПоказатьОповещениеПользователя("Успешно!",,"Успешно подключение к устройству.", БиблиотекаКартинок.ДиалогИнформация);	
	Иначе
		ПоказатьОповещениеПользователя("Ошибка подключения",,"Не удалось установить подключение к оборудованию. Проверьте настройки.", БиблиотекаКартинок.ДиалогВосклицание);
	КонецЕсли;
КонецПроцедуры

Функция УстановитьСоединенияНаСервере(ТестСоединения = Истина, ЧитатьИсторию = Ложь)
	ПараметрыПодключения = Новый Структура("АдресУстройства,Порт,Логин,Пароль,ИспользоватьSSL");
	ЗаполнитьЗначенияСвойств(ПараметрыПодключения, ЭтаФорма);
	Возврат Справочники.isc_Настройки.УстановитьСоединениеНаСервере(ТестСоединения, ЧитатьИсторию, ПараметрыПодключения);
	КонецФункции

&НаСервере
Процедура МетодыХраниенияМетодХраненияВГХПриИзмененииНаСервере(МетодХраненияВГХ, Примечание, Свойство)
	Свойство = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.ПустаяСсылка();
		
	Если МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.РеквизитыУпаковки  ИЛИ МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.РеквизитыНоменклатуры Тогда		
		Примечание = "Укажите реквизит";
	Иначе
		Примечание = "Укажите свойство";
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура МетодыХраниенияМетодХраненияВГХПриИзменении(Элемент)
	Примечание = "";
	Свойство = Неопределено;
	МетодыХраниенияМетодХраненияВГХПриИзмененииНаСервере(Элементы.МетодыХранения.ТекущиеДанные.МетодХраненияВГХ,Примечание, Свойство);
	Элементы.МетодыХранения.ТекущиеДанные.Примечание = Примечание;
    //Элементы.МетодыХранения.ТекущиеДанные.Свойство_ИмяРеквизита = Свойство;
КонецПроцедуры

&НаСервере
Процедура МетодыХраниенияСвойствоПриИзмененииНаСервере(МетодХраненияВГХ, Примечание)
	
	Если МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.ДопРеквизитыНоменклатуры   Тогда
		Примечание = "Габарит будет записываться в доп реквизит номенклатуры.";
	ИначеЕсли МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.ДопРеквизитыХарактеристики Тогда
		Примечание = "Габарит будет записываться в доп. реквизит характеристики.";  
	ИначеЕсли МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.ДопСведенияНоменклатуры Тогда
		Примечание = "Габарит будет записываться в регистр доп.сведение номенклатуры.";
	ИначеЕсли МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.ДопСведенияХарактеристики Тогда
		Примечание = "Габарит будет записываться в регистр доп.сведение характеристики.";
	ИначеЕсли МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.РеквизитыУпаковки Тогда		
		Примечание = "Габарит будет записываться в указанный реквизит справочника Упаковки";
	ИначеЕсли МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.РеквизитыНоменклатуры Тогда		
		Примечание = "Габарит будет записываться в указанный реквизит справочника Номенклатура";
	ИначеЕсли МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.РеквизитыОбъектаХранения Тогда		
		Примечание = "Габарит будет записываться в указанный реквизит справочника ОбъектыХранения";
	КонецЕсли;	

КонецПроцедуры

&НаКлиенте
Процедура МетодыХраниенияСвойствоПриИзменении(Элемент) 
	
КонецПроцедуры

&НаКлиенте
Процедура МетодыХраниенияСвойствоНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
		Примечание = "";
		Если Элементы.МетодыХранения.ТекущиеДанные.МетодХраненияВГХ = ПредопределенноеЗначение("Перечисление.isc_МетодХраненияВГХ.РеквизитыУпаковки")  
			ИЛИ Элементы.МетодыХранения.ТекущиеДанные.МетодХраненияВГХ = ПредопределенноеЗначение("Перечисление.isc_МетодХраненияВГХ.РеквизитыНоменклатуры") 
			ИЛИ Элементы.МетодыХранения.ТекущиеДанные.МетодХраненияВГХ = ПредопределенноеЗначение("Перечисление.isc_МетодХраненияВГХ.РеквизитыОбъектаХранения") Тогда	
		сзРеквизитов = Новый СписокЗначений;
		сзРеквизитов = ПолучитьсзРеквизитов(Элементы.МетодыХранения.ТекущиеДанные.МетодХраненияВГХ);
		ВыбЭлемент = сзРеквизитов.ВыбратьЭлемент("Укажите реквизит в котором хранится измерение."); 
		Элементы.МетодыХранения.ТекущиеДанные.Примечание = "Измерение будет записано в указанный реквизит";
		Если НЕ ВыбЭлемент = Неопределено Тогда
			Элементы.МетодыХранения.ТекущиеДанные.Свойство_ИмяРеквизита = ВыбЭлемент.Значение;
        КонецЕсли;
	Иначе
        Свойство = ПредопределенноеЗначение("ПланВидовХарактеристик.ДополнительныеРеквизитыИСведения.ПустаяСсылка");//Элементы.МетодыХранения.ТекущиеДанные.Свойство_ИмяРеквизита;
		ВвестиЗначение(Свойство);
		МетодыХраниенияСвойствоПриИзмененииНаСервере(Элементы.МетодыХранения.ТекущиеДанные.МетодХраненияВГХ, Примечание);
   		Элементы.МетодыХранения.ТекущиеДанные.Примечание = Примечание;
   		Элементы.МетодыХранения.ТекущиеДанные.Свойство_ИмяРеквизита = Свойство;
	КонецЕсли;

КонецПроцедуры 

&НаСервере
Функция ПолучитьсзРеквизитов(МетодХраненияВГХ)
	сзРеквизиты = НОвый СписокЗначений; 
	Если МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.РеквизитыУпаковки Тогда
		ТипРеквизита = Тип("СправочникСсылка.Упаковки");                                                               
	ИначеЕсли МетодХраненияВГХ = Перечисления.isc_МетодХраненияВГХ.РеквизитыОбъектаХранения Тогда
		ТипРеквизита = Тип("СправочникСсылка.ОбъектыХранения");                                                               	
	Иначе
		ТипРеквизита = Тип("СправочникСсылка.Номенклатура");
	КонецЕсли;
	Для Каждого элем Из Метаданные.НайтиПоТипу(ТипРеквизита).Реквизиты Цикл
		Если элем.Тип.СодержитТип(Тип("Число")) Тогда
			сзРеквизиты.Добавить(элем.Имя, Элем.Синоним);
		КонецЕсли;
	КонецЦикла;
	Возврат сзРеквизиты;
КонецФункции	

&НаКлиенте
Процедура СоответствиеУпаковокОбработкаЗаписиНового(НовыйОбъект, Источник, СтандартнаяОбработка)
	т = 1;
КонецПроцедуры

&НаКлиенте
Процедура ЛогСобытий(Команда)
	ОткрытьФорму("РегистрСведений.isc_ЛогСобытий.ФормаСписка");
КонецПроцедуры
