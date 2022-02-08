## Защита проекта
## Тема: «Система сбора, хранения, анализа данных мирового ранка зерна по биржевым ценам»

***

### Инструменты:

#### - dbt (Docker)
#### - Postgres (Docker)
#### - Metabase (Dockere)
#### - Jupyter Notebook

***

### Источники:

#### Московская биржа: https://www.moex.com/
#### Мировые товарные биржи: https://ru.investing.com/

***

### Цели проекта:
#### 1. Построить процесс для сбора данных на международных товарных биржах
#### 2. Спроектировать хранилище на базе  Data Vault, нормализовать и обогатить данные. Подготовить к построению бизнес-аналитики
#### 3. Визуализировать данные. Предоставить бизнесу данные для принятия обоснованного решения.

***

### Порядок выполнения проекта:

#### 1. Загрузка данных с сайта MOEX:
##### Скрипт здесь: [moex_parser](https://github.com/ElenaDoroshenko97/project_otus_main/blob/main/py_scripts/moex_parser.ipynb)

***

#### 2. Загрузка данных с сайта INVESTING (сейчас происходит вручную):
##### Скрипт здесь для небольших изменений в выгруженных файлах: [investing loader](https://github.com/ElenaDoroshenko97/project_otus_main/blob/main/py_scripts/investing_loader.ipynb)

***

#### 3. Моделирование детального слоя на базе data vault:
##### Все настройки находятся [здесь](https://github.com/ElenaDoroshenko97/project_otus_main/tree/main/project_otus_dbt)
##### Запуск:
###### dbt seed 
###### ![image](https://user-images.githubusercontent.com/15277539/153010150-745a2117-238e-4e38-af22-7197568427b5.png)

###### dbt run
###### ![image](https://user-images.githubusercontent.com/15277539/153010286-7eeff3e8-1c87-4c91-8554-6660b443f40b.png)


###### Все созданные объекты в Postgres:
###### ![image](https://user-images.githubusercontent.com/15277539/153010443-8403af80-8979-4397-8412-a620bc0df588.png)

***

#### 4. Визуализация данных с помощью Metabase:
##### Дашборд:
##### ![image](https://user-images.githubusercontent.com/15277539/153011466-4dc0e07c-f3c4-44c8-b715-15aa1e8353e3.png)

##### Графики:
###### График, отображающий динамику цен на пшеницу и сумм продаж за каждый день на московской бирже MOEX за последние пол года
###### ![image](https://user-images.githubusercontent.com/15277539/153012116-67cddc42-e405-4bd0-a5da-ea90e65e3ceb.png)

###### Динамика цен на пшеницу на биржах: Москвы, США и Лондона
###### ![image](https://user-images.githubusercontent.com/15277539/153012485-d3919537-0af0-43d5-8098-aae5d544d4b6.png)

###### Сравнение среднемесячных цен на пшеницу по данным бирж Москвы, США и Лондона
###### ![image](https://user-images.githubusercontent.com/15277539/153013352-41335463-dd1e-4596-9016-22e81d7a947d.png)

###### LFL. Среднемесячные цены на пшеницу в разрезе по годам: 2020, 2021, 2022
###### ![image](https://user-images.githubusercontent.com/15277539/153013768-0becdf9a-8162-46d9-9644-1ec3ff5d4da0.png)


#### Архитектура проекта
#### ![image](https://user-images.githubusercontent.com/15277539/153013929-dc1de353-ddb6-42e7-80d6-c06ace8a519a.png)



