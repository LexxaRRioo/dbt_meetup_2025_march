# This repo supports dbt meetup 2025 speech

Hey! This repo contains some dumb stuff DBT does. At version 1.9

Youtube link would be added later.

## Outline

нельзя писать в одну таблицу из разных мест
* наивный подход
* с учётом duckdb адаптированного кода
* с учётом зависимостей
* а если нужна разная логика по источникам

работа с макросами
* список, return и {{ }}
* {{ log() if execute }}
* джсон ‘’ и “ ”

юнит-тесты и кодогенерация
* пример конфига
* пример простой модельки генерации метрик
* во что это превращается с юнит тестами

монорепо vs разные репо
* на примере dbt docs
* только важные связи между моделями

## Setup and try yourself

```bash
python -m venv venv
. venv/bin/activate # or .\venv\Scripts\activate
pip install -r requirements.txt

dbt deps
dbt debug
dbt ls
```

## Meetup notes

```bash
rm -r ./models/3_dummy
dbt show --inline "drop schema sandbox cascade; select 1" # sql injections 101

python -c "import pyfiglet; print(pyfiglet.figlet_format('Hey, dbt meetup 2025', font='standard', width=120))"


dbt run -s +ads_naive
# uncomment ./macros/extend_packages
dbt run -s +ads_naive -d
dbt ls -s +ads_naive
dbt run -s +ads
dbt show --inline 'select count(1), source from sandbox.ads group by source'
# show dbt_project and ads_custom.sql
dbt compile -s ads_custom
dbt compile -s ads_custom --vars '{dbt_source_tags: [google-ads]}'



dbt compile -s 0_list
dbt compile -s 1_json_fromjson
dbt compile -s 1_json_fromyaml



dbt seed
# show ref_metric_config.csv
dbt compile -s 0_metrics_wo_unit_tests
# show unit-test
dbt build -s +1_metrics



python dummy_models_generator.py --layers_num 4 --models_num 150
dbt docs generate
dbt docs serve --port 8088
# monorepo vs regular repos
```