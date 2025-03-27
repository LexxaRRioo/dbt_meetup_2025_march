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

dbt seed
dbt run -s +ads_naive #error
# uncomment ./macros/extend_packages
dbt run -s +ads_naive -d
dbt docs generate
dbt docs serve --port 8080
dbt run -s +ads
dbt show --inline 'select count(1), source from sandbox.ads group by source'

dbt compile -s 0_list
dbt compile -s 1_json_fromjson
dbt compile -s 1_json_fromyaml

dbt compile -s 0_metrics_wo_unit_tests
dbt build -s 1_metrics

python dummy_models_generator.py --layers_num 4 --models_num 150
dbt docs generate
dbt docs serve --port 8081
# monorepo vs regular repos
```